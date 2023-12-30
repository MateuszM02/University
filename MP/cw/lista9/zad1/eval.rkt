#lang plait
(require "syntax.rkt")
(require (typed-in "parser.rkt"
                   (parse-exp : (S-Exp -> Exp))))

;========================================================================

(define (op->func op) ;dla operatorow binarnych
  (type-case Op op
    [(op-add) +]
    [(op-sub) -]
    [(op-mul) *]
    [(op-div) /]
    [(op-pow) ^]))

(define (unary-op->func op) ;dla operatorow unarnych
  (type-case Unary-Op op
    [(op-fact) !]
    [(op-opposite) ~]))

(define (eval ex)
  (type-case Exp ex
    [(exp-number n) n]
    [(exp-unary-op op e) ;operator unarny (np. silnia i liczba przeciwna)
     ((unary-op->func op) (eval e))]
    [(exp-op op e1 e2)
     ((op->func op) (eval e1) (eval e2))]
))

(define (calc e)
  (eval (parse-exp e)))

;========================================================================

;(define e0 (calc `(0)))
;(define e1 (calc `(3 + 5 * 7)))
;(define e2 (calc `((3 + 5) * 7)))
;(define e3 (calc `((12 - 7) ^ (2 + 1))))
(define e4 (calc `(2 !)))
;(define e5 (calc `((5 !) + (3 !))))

;========================================================================
