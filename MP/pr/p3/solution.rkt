#lang plait

;==============================================================
;abstract syntax

(define-type-alias Value Number)

(define bin-ops '(+ - * <=))

(define-type Function
  (numF [n : Number])
  (varF [x : Symbol])
  (binF [arg1 : Function] [op : Symbol] [arg2 : Function])
  (ifZeroF  [cond : Function] [true : Function] [false : Function])
  (letF [var : Symbol] [value : Function] [exp : Function])
  (callF [name : Symbol] [args : (Listof Function)]))

;==============================================================
;environment of functions

(define-type Binding
  (bind [name : Symbol]
        [val : Function]))

(define-type-alias Env (Listof Binding))

(define (extend-env [env : Env] [x : Symbol] [t : Function]) : Env
  (cons (bind x t) env))

;search for function definition
(define (lookup-env [n : Symbol] [env : Env]) : Function
  (type-case (Listof Binding) env
    [empty (error 'lookup "unbound variable")]
    [(cons b rst-env)
     (cond
          [(eq? n (bind-name b))
           (bind-val b)]
          [else (lookup-env n rst-env)])]
))

;==============================================================
;parser

(define (parse-op [op : Symbol]) : Symbol ;checks if operator is on the list of known operators
  (if (member op bin-ops)
      op 
      (error 'parse "unknown operator")))

(define (parse-cases [se : S-Exp]) : Function ;TO DO
  (cond
    [(s-exp-match? `NUMBER se)
     (numF (s-exp->number se))]
    [(s-exp-match? `SYMBOL se)
     (varF (s-exp->symbol se))]
    [(s-exp-match? `{ANY SYMBOL ANY} se)
     (let ([xs (s-exp->list se)])
       (binF (parse-cases (first xs))
             (parse-op (s-exp->symbol (second xs)))
             (parse-cases (third xs))
    ))]
    [(s-exp-match? `{ifz ANY then ANY else ANY} se)
     (let ([xs (s-exp->list se)])
       (ifZeroF  (parse-cases (second xs))
             (parse-cases (fourth xs))
             (parse-cases (list-ref xs 5))
    ))]
    [(s-exp-match? `{let ANY be ANY in ANY} se)
     (let ([xs (s-exp->list se)])
       (letF  (s-exp->symbol (second xs))
              (parse-cases (fourth xs))
              (parse-cases (list-ref xs 5))
    ))]
    [(s-exp-match? `{SYMBOL (ANY ...)} se) ;consider indexing variables
     (let ([xs (s-exp->list se)])
       (callF  (s-exp->symbol (first xs))
               (map parse-cases (s-exp->list (second xs)))
    ))]
    [else (error 'parse-cases "can't parse definition - invalid input")]
))

(define (parse-definition [se : S-Exp]) : Binding ;;parses single function definition from input
  (cond
    [(s-exp-match? `{fun SYMBOL ANY = ANY} se)
     (let ([xs (s-exp->list se)]) ;xs = (list `fun `even `(n) `= `(ifz n then 0 else (odd ((n - 1)))))
       (bind (s-exp->symbol (second xs)) (parse-cases (list-ref xs 4))))]
    [else (error 'parse-definition "can't parse definition - invalid input")]
))

(define (parse [se : S-Exp]) : (Env * Function) ;parses input
  (cond
    [(s-exp-match? `{define {[fun SYMBOL ANY ...] ...} for ANY} se)
     (let ([xs (s-exp->list se)])
      (pair
           (map parse-definition (s-exp->list (second xs))) ;saving function definitions here
           (parse-cases (fourth xs))) ;saving function call here
      )]
    [else (error 'parse "can't parse - invalid input")]
))

;==============================================================
;evaluator

(define (eval-op [op : Symbol] [v1 : Value] [v2 : Value]) : Value
  (cond
    [(equal? op '+) (+ v1 v2)]
    [(equal? op '-) (- v1 v2)]
    [(equal? op '*) (* v1 v2)]
    [(equal? op '<=)
     (if (<= v1 v2) 0 1)]
    [else (error 'eval-op "wrong type of binary operator")]
))

(define (apply [f : Function] [xs : (Listof Function)]) : Value
  (type-case Function f
    [(numF x) x]
    [(varF v) (apply (first xs) empty)]
    [(binF a1 o a2) (eval-op o (apply a1 xs) (apply a2 xs))]
    [(ifZeroF cond c1 c2) (apply cond xs)]
    [(letF var value exp) ....]
    [(callF f args) ....]))

(define (eval [x : (Env * Function)]) : Value
  (type-case Function (snd x)
    [(callF name def) (apply (lookup-env name (fst x)) def)]
    [else (error 'eval "wrong input - there is no function call")]))

;==============================================================

(define (run [s : S-Exp]) : Value
  (eval (parse s)))

#|
Before parsing:
-------------------------------------------------------------------------------------------------------------
`{define
                      {[fun even (n) = {ifz n then 0 else {odd ({n - 1})}}]
                       [fun odd (n) = {ifz n then 42 else {even ({n - 1})}}]}
                        for
                      {even (1024)}}
-------------------------------------------------------------------------------------------------------------
`{define
        {[fun gcd (m n) = {ifz n then m else {ifz {m <= n} then {gcd (m {n - m})} else {gcd ({m - n} n)}}}]}
                          for
                          {gcd (81 63)}}
-------------------------------------------------------------------------------------------------------------
After parsing:

(values
  (list
       (values 'even (ifF (varF 'n) (numF 0) (callF 'odd (list (binF (varF 'n) '- (numF 1))))))
       (values 'odd (ifF (varF 'n) (numF 42) (callF 'even (list (binF (varF 'n) '- (numF 1)))))))
  (callF 'even (list (numF 1024))))
-------------------------------------------------------------------------------------------------------------
(values
  (list
         (values 'gcd (ifZeroF
                       (varF 'n)
                       (varF 'm)
                       (ifZeroF
                        (binF (varF 'm) '<= (varF 'n))
                        (callF 'gcd (list (varF 'm) (binF (varF 'n) '- (varF 'm))))
                        (callF 'gcd (list (binF (varF 'm) '- (varF 'n)) (varF 'n)))))))
  (callF 'gcd (list (numF 81) (numF 63))))

;==============================================================
;tests
(module+ test
  (print-only-errors #t)
  (test (parse `{define
                        {[fun fact (n) = {ifz n then 1 else {n * {fact (n - 1)}}}]}
                        for {fact (5)}})
        (values ;parsing returns a pair
          (list ;first element is list of definitions
            (bind 'fact (ifZeroF (varF 'n) (numF 1) (binF (varF 'n) '* (callF 'fact (list (varF 'n) (varF '-) (numF 1)))))))
          (callF 'fact (list (numF 5)))))) ;second element is function call
  (test (parse `{define
                      {[fun even (n) = {ifz n then 0 else {odd ({n - 1})}}]
                       [fun odd (n) = {ifz n then 42 else {even ({n - 1})}}]}
                        for
                      {even (1024)}})
        (values
          (list
            (bind 'even (ifZeroF (varF 'n)
                                 (numF 0)
                                 (callF 'odd (list (binF (varF 'n) '- (numF 1))))))
            (bind 'odd (ifZeroF (varF 'n)
                                (numF 42)
                                (callF 'even (list (binF (varF 'n) '- (numF 1)))))))
          (callF 'even (list (numF 1024)))))
  (test (parse `{define
                        {[fun gcd (m n) = {ifz n then m else {ifz {m <= n}
                         then {gcd (n m)}
                         else {gcd ({m - n} n)}}}]}
                        for {gcd (81 63)}})
        (values
          (list
            (bind 'gcd (ifZeroF (varF 'n)
                                (varF 'm)
                                (ifZeroF (binF (varF 'm) '<= (varF 'n))
                                         (callF 'gcd (list (varF 'n) (varF 'm)))
                                         (callF 'gcd (list (binF (varF 'm) '- (varF 'n)) (varF 'n)))))))
          (callF 'gcd (list (numF 81) (numF 63)))))
|#
