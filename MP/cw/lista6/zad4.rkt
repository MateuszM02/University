#lang plait

;zad4

( define-type ( NNF 'v )
( nnf-lit [ polarity : Boolean ] [ var : 'v ])
( nnf-conj [ l : ( NNF 'v ) ] [ r : ( NNF 'v ) ])
( nnf-disj [ l : ( NNF 'v ) ] [ r : ( NNF 'v ) ]) )

(define (neg-nnf arg)
  (cond [(nnf-conj? arg) [nnf-disj (neg-nnf [nnf-conj-l arg]) (neg-nnf [nnf-conj-r arg])]]
        [(nnf-disj? arg) [nnf-conj (neg-nnf [nnf-disj-l arg]) (neg-nnf [nnf-disj-r arg])]]
        [(nnf-lit? arg) [nnf-lit [not (nnf-lit-polarity arg)] (nnf-lit-var arg)]]
        [else arg]))

;testy

(define p1 (nnf-lit #t 1))
(neg-nnf p1)
(define p2 (nnf-conj (nnf-lit #t 2) (nnf-lit #f 12)))
(neg-nnf p2)
(define p3 (nnf-disj (nnf-lit #f 3) (nnf-lit #f 13)))
(neg-nnf p3)
(define p4 (nnf-disj (nnf-conj (nnf-lit #t 4) (nnf-lit #t 14)) (nnf-lit #f 40)))
(neg-nnf p4)

;dowod przez indukcje

;podstawa - literal

;wezmy dowolny literal L (typu nnf-lit)
;udowodnie, ze (neg-nnf (neg-nnf L)) = L
;(neg-nnf (neg-nnf [nnf-lit [polarity: L] [value:L] ])) = (neg-nnf [nnf-lit [polarity: (not L)] [value:L] ]) = L

;krok - dowolne wyrazenie skladajace sie z alternatyw, koniunkcji i literalow

;wezmy dowolne wyrazenie W
;udowodnie, ze (neg-nnf (neg-nnf W)) = W

;dowod dla koniunkcji: W = A and B

;(neg-nnf (neg-nnf [A and B])) = (neg-nnf [not A or not B])) = [A and B]

;dowod dla koniunkcji: W = A or B

;(neg-nnf (neg-nnf [A or B])) = (neg-nnf [not A and not B])) = [A or B]
