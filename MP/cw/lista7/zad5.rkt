#lang racket

(require rackunit)

; 1. (parametric->/c [a b] (-> a b a))
; 2. (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
; 3. (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
; 4. (parametric->/c [a] (-> (-> (-> a a) a) a))

;przypomnienie: (lepiej wyjasnione na wykladzie 7, 3 czesci nagrania, okolo 14 minuty)
;pozycja pozytywna to takie wystapienie, gdzie "wyjmujemy z pudelka",
;czyli wystapienie jest parzyscie wiele razy argumentem procedury
;pozycja negatywna to takie wystapienie, gdzie "wkladamy do pudelka"
;czyli wystapienie jest nieparzyscie wiele razy argumentem procedury

;procedura spelniajaca 1:
(define/contract (first x y) 
  (parametric->/c [a b] (-> a b a))
  x)

;wystapienia pozytywne: 2 wystapienie 'a'
;wystapienia negatywne: 1 wystapienie 'a' oraz 1 wystapienie 'b'

;procedura spelniajaca 2:
(define/contract (second x y z) 
  (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
  (x z (y z)))

;wystapienia pozytywne: 1 i 2 wystapienia 'a', 1 wystapienie 'b' oraz 2 wystapienie 'c'
;wystapienia negatywne: 3 wystapienie 'a', 2 wystapienie 'b' oraz 1 wystapienie 'c'

;procedura spelniajaca 3:
(define/contract (third f g) 
  (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
  (lambda (x) [f (g x)]))

;wystapienia pozytywne: 1 wystapienie 'a', 1 wystapienie 'b' oraz 2 wystapienie 'c'
;wystapienia negatywne: 2 wystapienie 'a', 2 wystapienie 'b' oraz 1 wystapienie 'c'
  
;procedura spelniajaca 4:
(define/contract (fourth f) 
  (parametric->/c [a] (-> (-> (-> a a) a) a))
  (f [lambda (x) [identity x]]))

;wystapienia pozytywne: 2, 4
;wystapienia negatywne: 1, 3

;procedury pomocnicze

(define (duo f g) (lambda (x) (f (g x))))
(define subs (lambda (x) (- x 1)))
(define multi (lambda (x) (* x 2)))

;wywolania procedur
(first 1 2)
(second [lambda (y z) (* y z)] [lambda (x) (- x 1)] 3)
((third multi subs) 3)
((fourth (lambda (x) x)) 11)
