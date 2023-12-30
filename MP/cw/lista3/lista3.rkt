#lang racket
(require racket/trace)

;zadanie 1 NIE MAM

;'(( car ( a . b ) ) (* 2) )
;‘ ( ,( car '( a . b ) ) ,(* 2) )
;'((+ 1 2 3) ( cons ) ( cons a b ) )

;zadanie 2

(define (my-foldl f x xs)
  (define (it xs acc)
    (if (null? xs)
        acc
        (it (cdr xs) (f (car xs) acc))))
  (it xs x))

(define (product xs)
  (if (null? xs) 0 (my-foldl * 1 xs)))

;(product (list 1 2 3 4))

;zadanie 3

;((lambda ( x y ) [+ x (* x y ) ] ) 1 2) ->
;(lambda ( 1 2 ) [+ x (* x y ) ] ) ->
;(lambda ( 1 2 ) [+ 1 (* 1 2 ) ] ) ->
;(lambda ( 1 2 ) [+ 1 2 ] ) ->
;(lambda ( 1 2 ) 3 ) -> 3

;(( lambda ( x ) x ) ( lambda ( x ) x ) ) ->
;(( lambda (lambda ( x ) x ) x ) ->
;(( lambda ( x ) x ) -> x

;(( lambda ( x ) (x x) ) ( lambda ( x ) x ) ) ->
;(( lambda ( lambda ( x ) x ) (x x) ) ->
;(( lambda ( x ) (x x) ) -> x

;(( lambda ( x ) (x x) ) ( lambda ( x ) (x x) ) ) ->
;(( lambda ( lambda ( x ) (x x) ) (x x) ) ->
;(( lambda ( x ) (x x) ) -> x

;zadanie 4

(define (square x) (sqrt x))
(define (inc x) (+ x 1))

(define (my-compose f g)
  (lambda (x) [f [g x]]))

;((my-compose square inc) 5) ;sqrt(5+1) = sqrt(6) = 2,449
;((my-compose inc square) 5) ;sqrt(5)+1 = 3,236

;zadanie 5

;(define (build-list n f)
  ;(define (iter lista akt n f)
   ; (if(= akt n) lista
   ; [cons (f akt) (iter lista (+ akt 1) n f)]))
 ; (iter null 0 n f))

(define (negatives n) [build-list n [lambda (n) (- (* -1 n) 1)]])
(define (reciprocals n) [build-list n [lambda (n) (/ 1 (+ 1 n))]])
(define (evens n) [build-list n [lambda (n) (* n 2)]])
(define (identityM n)
  [build-list n [lambda (indeks_jedynki)
                  (build-list n {lambda (akt_indeks)
                                  [if (= akt_indeks indeks_jedynki) 1 0]})]])

;(negatives 20)
;(reciprocals 20)
;(evens 20)
;(identityM 3)

;zadanie 6

(define (empty-set) (lambda (x) #f))
(define (singleton a) (lambda (x) (equal? x a)))
(define (in a s)
  (cond [(null? s) #f]
        [(equal? a (car s)) #t]
        [else (in a (cdr s))]
  ))

(define (union s t)
  (cond [(null? t) s]
        [(in (car t) s) (union s (cdr t))]
        [else (union (append s (list (car t))) (cdr t))]
  ))

(define (intersect s t)
  (if (null? s)     null
      [if (in (car s) t)
          (cons (car s) (intersect (cdr s) t))
          (intersect (cdr s) t)
      ]))

(union (list 1 2 3 4 5) (list 3 7 10 17 4))
(trace intersect)
(intersect (list 1 2 3 4 5) (list 3 7 10 17 4))

;zadanie 7 NIE ZROBIONE!

( define ( foldr-reverse xs )
( foldr ( lambda ( y ys ) ( append ys ( list y ) ) ) null xs ) )

;(foldr-reverse (list 0 1 2 3 4)) -> ( lambda (null (list 0 1 2 3 4)) ( cons (list 0) (list null)) )

;( length ( foldr-reverse ( build-list 10 identity ) ) ;)

;(trace foldr-reverse)
;(foldr-reverse (build-list 10 identity))

;zadanie 8

;kod
