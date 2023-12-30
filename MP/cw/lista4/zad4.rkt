#lang racket
(require rackunit)

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

( define t
( node
  [ node ( leaf ) 2 ( leaf ) ]
  5
  [ node 
         ( node ( leaf ) 6 ( leaf ) )
         8
         ( node (leaf) 9 ( leaf ) ) ]
) )

;zad4

(define (flat-append t xs)
  (cond [(leaf? t) xs]
      [(node? t) [flat-append (node-l t) (cons (node-elem t) [flat-append (node-r t) xs])]]
      [else #f]
  ))

(define (flatten-fast t) ;ulepszona wersja flatten z zadania 2
(flat-append t null))

;niezmienniki programu
(check-equal? (flatten-fast (leaf)) null) ;puste drzewo ma zwracac pusta liste
(check-equal? (flatten-fast (node (leaf) 5 (leaf))) (list 5)) ;drzewo 1-elementowe ma zwracac 1-elementowa liste
(check-equal? (flatten-fast (node [node (leaf) 2 (leaf)] 5 (leaf))) (list 2 5)) ;drzewo 2-elementowe ma zwracac 2-elementowa liste (w kolejnosci infiksowej)
(check-equal? (flatten-fast t) (list 2 5 6 8 9)) ;drzewo 5-elementowe ma zwracac 5-elementowa liste (w kolejnosci infiksowej)
