#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define (&& [v1 : Boolean] [v2 : Boolean]) (and v1 v2)) ;koniunkcja
(define (|| [v1 : Boolean] [v2 : Boolean]) (or v1 v2)) ;alternatywa
(define (! [v : Boolean]) (not v)) ;negacja
(define (~ [v : Number]) (* v -1)) ;unarny minus

(define-type Op
  (add)
  (sub)
  (mul)
  (div)
  (eql)
  (leq)
  (kon) ;nowe - koniunkcja
  (alt)) ;nowe - alternatywa

(define-type Un-Op ;nowe - operatory unarne
  (neg) ;nowe - negacja
  (minus)) ;nowe - unarny minus

(define-type Exp
  (numE [n : Number])
  (boolE [b : Boolean])
  (un-opE [op : Un-Op] ;nowe - wyrazenie moze sie skladac z unarnego operatora i wyrazenia
       [v : Exp]) ;nowe
  (opE [op : Op]
       [l : Exp]
       [r : Exp])
  (ifE [b : Exp]
       [l : Exp]
       [r : Exp])
  (condE [cs : (Listof (Exp * Exp))]))

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
    [(s-exp-match? `{SYMBOL ANY} s) ;nowe - parse dla operatorow unarnych
     (un-opE (parse-un-op (s-exp->symbol (first (s-exp->list s)))) ;nowe
          (parse (second (s-exp->list s))))] ;nowe
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s))))]
    [(or (equal? `#t s) (equal? `#f s)) ;nowe
     (boolE (s-exp->boolean s))] ;nowe
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
    [(eq? op '&&) (kon)] ;nowe - koniunkcja
    [(eq? op '||) (alt)] ;nowe - alternatywa
    [else (error 'parse "unknown operator")]))

(define (parse-un-op [op : Symbol]) : Un-Op ;nowe - parser operatorow unarnych
  (cond
    [(eq? op '!) (neg)] ;negacja
    [(eq? op '~) (minus)] ;unarny minus
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
            "parse: unknown operator")
  (test/exn (parse `{& 1 2})
            "unknown operator")
  (test (parse `{cond {{= 0 1} {* 3 4}}
                      {{= 1 1} 8}})
        (condE (list (pair (opE (eql) (numE 0) (numE 1))
                           (opE (mul) (numE 3) (numE 4)))
                     (pair (opE (eql) (numE 1) (numE 1))
                           (numE 8))))))
  
;; eval --------------------------------------

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean]))

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

(define (op-bool-bool->proc [f : (Boolean Boolean -> Boolean)]) : (Value Value -> Value) ;nowe, podobne do op-num-bool->proc
  (λ (v1 v2)
    (type-case Value v1
      [(boolV n1) ;zmiana
       (type-case Value v2
         [(boolV n2) ;zmiana
          (boolV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (un-op-bool->proc [f : (Boolean -> Boolean)]) : (Value -> Value) ;nowe, podobne do un-op-number->proc
  (λ (v)
    (type-case Value v
      [(boolV n) ;zmiana
         (boolV (f n))]
         [else
          (error 'eval "type error")])))

(define (un-op-number->proc [f : (Number -> Number)]) : (Value -> Value) ;nowe, podobne do un-op-bool->proc
  (λ (v)
    (type-case Value v
      [(numV n) ;zmiana
         (numV (f n))]
         [else
          (error 'eval "type error")])))

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) (op-num-num->proc +)]
    [(sub) (op-num-num->proc -)]
    [(mul) (op-num-num->proc *)]
    [(div) (op-num-num->proc /)]
    [(eql) (op-num-bool->proc =)]
    [(leq) (op-num-bool->proc <=)]
    [(kon) (op-bool-bool->proc &&)] ;nowe
    [(alt) (op-bool-bool->proc ||)] ;nowe
))

(define (un-op->proc [op : Un-Op]) : (Value -> Value) ;nowe
  (type-case Un-Op op ;nowe
    [(neg) (un-op-bool->proc !)] ;nowe
    [(minus) (un-op-number->proc ~)] ;nowe
))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(boolE b) (boolV b)] ;nowe
    [(un-opE o v) ((un-op->proc o) (eval v))] ;nowe
    [(opE o l r) ((op->proc o) (eval l) (eval r))]
    [(ifE b l r)
     (type-case Value (eval b)
       [(boolV v)
        (if v (eval l) (eval r))]
       [else
        (error 'eval "type error")])]
    [(condE cs)
     (eval (cond->if cs))]))

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

;; moje wlasne testy ——————————————————————————

(module+ test
  (test (run `(~ (+ 2 (* 3 5))))
        (numV -17))
  (test (run `(~ (~ 10)))
        (numV 10))
  (test (run `{|| #f #t})
        (boolV #t))
  (test (run `{&& #t #f})
        (boolV #f))
  (test (run `{! #t})
        (boolV #f))
  (test (run `{! (&& #t #f)})
        (boolV #t)))

;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]))

(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))
