#lang racket

(require rackunit)

;poprawiona procedura sublists:
(define/contract (sublists xs)
  ;kontrakt parametryczny:
  ;procedura sublists bierze jako argument liste typu a, zwraca liste list typu a 
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
  
  (match xs 
      ['() (list null)]
      [(cons first rest) 
        (append-map 
            [lambda (ys) (cons (cons first ys) (cons ys null))] 
            (sublists rest))]
  ))

;po poprawce procedura dziala prawidlowo, przyklady:
;(w poleceniu nie bylo nic napisane na temat kolejnosci wypisywania)
(sublists '(1 2))
;wczesniej: '((1 2) 2)
;teraz: '((1 2) (2) (1) ())
(sublists '(1 2 3))
;wczesniej: '((1 2 3) 2 3 (1 . 3) . 3)
;teraz: '((1 2 3) (2 3) (1 3) (3) (1 2) (2) (1) ())
