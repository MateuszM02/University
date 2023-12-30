#lang plait

;   +
;  /  \
; 2     *
;      /   \
;     3      -
;           / \
;          7   21
; 2 + 3 * (7 - 21)

;===============================================================================

(define (^ base index) ;potegowanie (wykladnik zaokraglany do liczby calkowitej)
  (cond [(= base 0) 0]
        [(< index 0) (^ (/ 1 base) (* index -1))]
        [(< index 1) 1]
        [else (* base (^ base (- index 1)))]
))

(define (! n) ;silnia (dla liczb ujemnych x przyjmujemy x! = 1 zeby typy sie zgadzaly)
  (cond [(<= n 1) 1]
        [else (* n (! (- n 1)))]
))

(define (~ n) ;liczba przeciwna
  (* n -1))

;===============================================================================

(define-type Op
  (op-add) (op-sub) (op-mul) (op-div) (op-pow))

(define-type Unary-Op
  (op-fact) (op-opposite))

(define-type Exp
  (exp-number [n : Number])
  (exp-unary-op [op : Unary-Op] [e : Exp]) ;dla silnii i liczby przeciwnej
  (exp-op [op : Op] [e1 : Exp] [e2 : Exp]))

;===============================================================================

(define (s-exp->op se)
  (if (s-exp-symbol? se)
      (let ([sym (s-exp->symbol se)])
        (cond
          [(symbol=? sym '+) (op-add)]
          [(symbol=? sym '-) (op-sub)]
          [(symbol=? sym '*) (op-mul)]
          [(symbol=? sym '/) (op-div)]
          [(symbol=? sym '^) (op-pow)]))
      (error 's-exp->op "Syntax error: s-exp->op")))

(define (s-exp->op1 se)
  (if (s-exp-symbol? se)
      (let ([sym (s-exp->symbol se)])
        (cond
          [(symbol=? sym '!) (op-fact)]
          [(symbol=? sym '~) (op-opposite)]))
      (error 's-exp->op1 "Syntax error: s-exp->op1")))

(define (s-exp->exp se)
  (cond
    [(s-exp-number? se) (exp-number (s-exp->number se))]
    [(s-exp-match? `(SYMBOL ANY) se) ;dla silnii
     (let ([se-list (s-exp->list se)])
        (exp-unary-op (s-exp->op1 (first se-list))
                (s-exp->exp (second se-list))
    ))]
    [(s-exp-match? `(ANY SYMBOL) se) ;dla liczby przeciwnej
     (let ([se-list (s-exp->list se)])
        (exp-unary-op (s-exp->op1 (first se-list))
                     (s-exp->exp (second se-list))
    ))]
    [(s-exp-match? `(SYMBOL ANY ANY) se)
     (let ([se-list (s-exp->list se)])
        (exp-op (s-exp->op (first se-list))
                (s-exp->exp (second se-list))
                (s-exp->exp (third se-list))
    ))]
    [else (error 's-exp->exp "Syntax error: s-exp->exp")]))

;========================================================================
