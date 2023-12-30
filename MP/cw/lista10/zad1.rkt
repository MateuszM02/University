#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op] [args : (Listof Exp)])) ;zmiana - operator przyjmuje liste argumentow zamiast 2 jak dotychczas

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{SYMBOL ANY ...} s) ;zmiana - operator przyjmuje zmienna ilosc argumentow, stad trzykropek
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse-list (rest (s-exp->list s))))] ;zmiana
    [else (error 'parse "invalid input")]))

(define (parse-list [xs : (Listof S-Exp)]) : (Listof Exp) ;nowe - parsuje liste argumentow operatora
  (type-case (Listof S-Exp) xs
    [empty empty]
    [(cons h t) (cons (parse h) (parse-list t))]))

(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [else (error 'parse "unknown operator")]))
              
(module+ test
  (test (parse `2)
        (numE 2))
  (test (parse `{+ 2 1})
        (opE (add) (list (numE 2) (numE 1)))) ;zmiana
  (test (parse `{* 3 4})
        (opE (mul) (list (numE 3) (numE 4)))) ;zmiana
  (test (parse `{+ {* 3 4} 8}) ;zmiana
        (opE (add)
             (list (opE (mul) (list (numE 3) (numE 4)))
             (numE 8))))
  (test/exn (parse `{{+ 1 2}})
            "invalid input")
  (test/exn (parse `{^ 1 2})
            "unknown operator"))

;; eval --------------------------------------

(define-type-alias Value Number)

(define (op->proc [op : Op]) : (Value Value -> Value) ;zmiana
  (type-case Op op
    [(add) +]
    [(sub) -]
    [(mul) *]
    [(div) /]))

(define (op-neutral [op : Op]) : Value ;nowe, zwraca element neutralny danej operacji w przypadku wywolania bezargumentowego
  (type-case Op op
    [(add) 0]
    [(sub) 0]
    [(mul) 1]
    [(div) 1]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) n]
    [(opE o args) (eval-list o args)] ;zmiana
))

(define (eval-list [op : Op] [xs : (Listof Exp)]) : Value ;nowe - wylicza wyrazenia typu (op (list a b c d ...))
  (type-case (Listof Exp) xs
    [empty (op-neutral op)] ;konwencja: dla listy pustej argumentow zwracam element neutralny operatora
    [(cons h t)
           (cond
                [(empty? t) (eval h)] ;operator ma 1 argument
                [else (eval-list op (cons (numE [(op->proc op) (eval h) (eval (first t))]) (rest t)))]
                ;w else korzystamy z faktu: (op (list a b c d ...)) = (op (op a b) (list c d ...)) dla listy rozmiaru min. 2
)]))

(define (run [e : S-Exp]) : Value
  (eval (parse e)))

(module+ test
  (test (run `2)
        2)
  (test (run `{+ 2 1})
        3)
  (test (run `{* 2 1})
        2)
  (test (run `{+ {* 2 3} {+ 5 8}})
        19))

;; moje testy —————————————————————————————————

(module+ test
  (test (run `{+}) ;operator bezargumentowy zwraca element neutralny
        0)
  (test (run `{+ 4}) ;operator jednoargumentowy zwraca identycznosc
        4)
  (test (run `{+ 1 2 3})
        6)
  (test (run `{- 10 22 36})
        -48)
  (test (run `{* 2 3 4 5})
        120)
  (test (run `{/ 48 6 2 4})
        1)
  (test (run `{* 4 6 {/ 12 4}})
        72))

;; printer ———————————————————————————————————-

(define (print-value [v : Value]) : Void
  (display v))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))
