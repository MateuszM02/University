#lang plait

;zad1

;procedura ('a 'b - > 'a )
(define (f1 a b) a)

;procedura (('a 'b - > 'c ) ('a - > 'b ) 'a - > 'c )
(define (f2 fa fb a)
  (fa a (fb a)))

;procedura ((( 'a - > 'a ) - > 'a ) - > 'a )

(define (f3 [x : (( 'a -> 'a ) -> 'a ) ])
  (x identity))

;procedura (['a - > 'b ] ['a - > 'c ] - > ['a - > ('b * 'c ) ] )
(define (f4 f g)
  (lambda (a) (pair (f a) (g a))))

;f jest typu 'a - > 'b
;g jest typu 'a - > 'c
;zatem procedura (A) (pair (f a) (g a)) jest typu ('b * 'c)
;procedura (A) jest 1-argumentowa i jest elementem zwracanym procedury f4

;procedura (['a - > { Optionof ('a * 'b ) } ] 'a - > [ Listof 'b ] )
(define (f5 [y : ('x -> (Optionof ('x * 'b)))] x)
  (cons [snd (some-v(y x))] empty))

;some-v jest typu ((Optionof 'a) -> 'a)
;poniewaz y zwraca typ Optionof ('a * 'b ), to some-v jest typu ((Optionof ('a * 'b)) -> ('a * 'b))
;snd jest typu ('a * 'b ) - > 'b, stad [snd (some-v(y x))] jest typu 'b
;cons jest typu ('b (Listof 'b) -> (Listof 'b)) wiec f5 zwraca (Listof 'b)
