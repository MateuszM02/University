#lang plait

(module+ test
  (print-only-errors #t))

;zad5 - bool.rkt

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div)
  (eql)
  (leq))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op]
       [l : Exp]
       [r : Exp])
  (ifE [b : Exp]
       [l : Exp]
       [r : Exp])
  (condE [cs : (Listof (Exp * Exp))])
  (carE [e : (Listof Exp)]) ;car
  (nullE) ;null
  (isNullE [e : Exp]) ;null?
  (listE [e : (Listof Exp)]) ;list
  )

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{if ANY ANY ANY} s)
     (ifE (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s)))
          (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{cond ANY ...} s)
     (condE (parse-cond (rest (s-exp->list s))))]
    ;NOWE KONSTRUKCJE
    [(s-exp-match? `{cons ANY ANY} s)   ;cons
    (listE (cons-join (parse (second (s-exp->list s)))
           (parse (third (s-exp->list s)))))]
    [(s-exp-match? `{car ANY} s)   ;car
    (carE (listE-e (parse (second (s-exp->list s)))))]
    [(s-exp-match? `{cdr ANY} s)   ;cdr
     (listE (rest (listE-e (parse (second (s-exp->list s))))))]
    [(s-exp-match? `null s)   ;null
    (nullE)]
    [(s-exp-match? `{null? ANY} s)   ;null?
    (isNullE (parse (second (s-exp->list s))))]
    [(s-exp-match? `{list ANY ...} s)   ;list
    (listE (filter [lambda (x) (not (equal? x (nullE)))] [map parse (rest (s-exp->list s))]))]
    ;KONIEC
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s))))]
    [else (error 'parse "invalid input")]))

(define (parse-cond [ss : (Listof S-Exp)]) : (Listof (Exp * Exp))
  (type-case (Listof S-Exp) ss
    [empty
     empty]
    [(cons s ss)
     (if (s-exp-match? `{ANY ANY} s)
         (cons (pair (parse (first (s-exp->list s)))
                     (parse (second (s-exp->list s))))
               (parse-cond ss))
         (error 'parse "invalid input: cond"))]))
  
(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [(eq? op '=) (eql)]
    [(eq? op '<=) (leq)]
    [else (error 'parse "unknown operator")]))
                
(module+ test
  (test (parse `2)
        (numE 2))
  (test (parse `{+ 2 1})
        (opE (add) (numE 2) (numE 1)))
  (test (parse `{* 3 4})
        (opE (mul) (numE 3) (numE 4)))
  (test (parse `{+ {* 3 4} 8})
        (opE (add)
             (opE (mul) (numE 3) (numE 4))
             (numE 8)))
  (test (parse `{if {= 0 1} {* 3 4} 8})
        (ifE (opE (eql) (numE 0) (numE 1))
             (opE (mul) (numE 3) (numE 4))
             (numE 8)))
   (test/exn (parse `{{+ 1 2}})
            "invalid input")
  (test/exn (parse `{+ 1})
            "invalid input")
  (test/exn (parse `{^ 1 2})
            "unknown operator")
  (test (parse `{cond {{= 0 1} {* 3 4}}
                      {{= 1 1} 8}})
        (condE (list (pair (opE (eql) (numE 0) (numE 1))
                           (opE (mul) (numE 3) (numE 4)))
                     (pair (opE (eql) (numE 1) (numE 1))
                           (numE 8))))))
  
;; eval --------------------------------------

(define-type Value
  (emptyV) ;NOWE
  (numV [n : Number])
  (boolV [b : Boolean])
  (listV [xs : (Listof Value)])) ;NOWE

(define (cons-join [c1 : Exp][c2 : Exp]) : (Listof Exp) ;NOWE
  (type-case Exp c2
    [(listE xs) (cons c1 xs)]
    [(nullE) (list c1)]
    [else (error 'cons-join "Drugim argumentem cons ma byc lista!")]
    ))

(define (op-num-num->proc [f : (Number Number -> Number)]) : (Value Value -> Value)
  (λ (v1 v2)
    (type-case Value v1
      [(numV n1)
       (type-case Value v2
         [(numV n2)
          (numV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (op-num-bool->proc [f : (Number Number -> Boolean)]) : (Value Value -> Value)
  (λ (v1 v2)
    (type-case Value v1
      [(numV n1)
       (type-case Value v2
         [(numV n2)
          (boolV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) (op-num-num->proc +)]
    [(sub) (op-num-num->proc -)]
    [(mul) (op-num-num->proc *)]
    [(div) (op-num-num->proc /)]
    [(eql) (op-num-bool->proc =)]
    [(leq) (op-num-bool->proc <=)]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(opE o l r) ((op->proc o) (eval l) (eval r))]
    [(ifE b l r)
     (type-case Value (eval b)
       [(boolV v)
        (if v (eval l) (eval r))]
       [else
        (error 'eval "type error")])]
    [(condE cs)
     (eval (cond->if cs))]
    ;NOWE KONSTRUKCJE
    [(carE e) (eval (first e))]
    [(nullE) (listV (list (emptyV)))]
    [(isNullE e) (boolV (equal? (nullE) e))]
    [(listE xs) (listV (map eval xs))]
    ))

(define (cond->if [cs : (Listof (Exp * Exp))]) : Exp
  (type-case (Listof (Exp * Exp)) cs
    [empty
     (numE 42)]
    [(cons c cs)
     (ifE (fst c)
          (snd c )
          (cond->if cs))]))

(define (run [e : S-Exp]) : Value
  (eval (parse e)))

;; testy ———————————————————————————————————----

(module+ test
  (test (run `2)
        (numV 2))
  (test (run `{+ 2 1})
        (numV 3))
  (test (run `{* 2 1})
        (numV 2))
  (test (run `{+ {* 2 3} {+ 5 8}})
        (numV 19))
  (test (run `{= 0 1})
        (boolV #f))
  (test (run `{if {= 0 1} {* 3 4} 8})
        (numV 8))
  (test (run `{cond {{= 0 1} {* 3 4}}
                    {{= 1 1} 8}})
        (numV 8)))

;; moje testy —————————————————————————————————

(module+ test
  (test (run `{cons 1 null})
        (listV (list (numV 1))))
  (test (run `{cons 1 {cons 2 {cons 3 null}}})
        (listV (list (numV 1) (numV 2) (numV 3))))
  (test/exn (run `{cons 1 2})
        "Drugim argumentem cons ma byc lista!")
  (test (run `{list 1 2 3})
        (listV (list (numV 1) (numV 2) (numV 3))))
  (test (run `{car {list 2 1 3 7}})
        (numV 2))
  (test (run `{cdr {list 2 1 3 7}})
        (listV (list (numV 1) (numV 3) (numV 7))))
  (test (run `{car {cdr {list 2 1 3 7}}})
        (numV 1))
  (test (run `{cdr {cdr {list 2 1 3 7}}})
        (listV (list (numV 3) (numV 7))))
  (test (run `{null? {list 2 1 3 7}})
        (boolV #f))
  (test (run `{null? null})
        (boolV #t)))

;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(emptyV) ""] ;NOWE
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]
    [(listV xs) ""])) ;NOWE

(define (print-all [xs : (Listof Value)]) : Void ;NOWE
 (first (map (lambda (x) (display (value->string x))) xs)))
  
(define (print-value [v : Value]) : Void ;ZMIANA
  (type-case Value v
  [(listV a) (print-all a)] ;NOWE
  [else (display (value->string v))]
))
  
(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))
