#lang racket
(require racket/trace)

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

;zad2

(define (fold-tree f drzewo if_leaf)
  (cond [(leaf? drzewo) if_leaf] ;jesli jest lisciem, zwroc wartosc domyslna, np. 0 dla sumy lub #t dla predykatu bst?
        [(node? drzewo)
         [f (fold-tree f (node-l drzewo) if_leaf)
            (node-elem drzewo)
            (fold-tree f (node-r drzewo) if_leaf)]
        ] ;wywolaj podana funkcje dla lewego poddrzewa, wartosci i prawego poddrzewa
        [else #f]
  ))

;suma
(define (tree-sum t) (fold-tree + t 0))
;zamiana
(define (tree-flip t)
  (define (zamiana lewy elem prawy)
    (cond [{and (null? lewy) (null? prawy)} (node (leaf) elem (leaf))]
          [(null? lewy) (node prawy elem (leaf))]
          [(null? prawy) (node (leaf) elem lewy)]
          [else (node prawy elem lewy)]
    ))
  (fold-tree zamiana t null))
;wysokosc
(define (tree-height t)
  (define (max_wys lewy elem prawy)
    (cond [(= lewy 0) (+ prawy 1)]
          [(= prawy 0) (+ lewy 1)]
          [(if(> prawy lewy) (+ prawy 1) (+ lewy 1))]
    )
  )
(fold-tree max_wys t 0))
;para
(define (tree-span t)
  (define (para lewy elem prawy)
    (cond [{and (equal? (car lewy) #f) (equal? (cdr prawy) #f)} (cons elem elem)]
          [(equal? (car lewy) #f) (cons elem (cdr prawy))]
          [(equal? (cdr prawy) #f) (cons (car lewy) elem)]
          [else (cons (car lewy) (cdr prawy))]
    )
  )
(fold-tree para t [cons #f #f]))
;lista elementow drzewa
(define (flatten t)
  (define (polacz lewy elem prawy)
    (cond [{and (null? lewy) (null? prawy)} (list elem)]
          [(null? lewy) (cons elem prawy)]
          [(null? prawy) (cons lewy elem)]
          [else (append lewy (cons elem prawy))]
    ))
  (fold-tree polacz t null))

;przyklady
(tree-sum t)
(tree-flip t)
(tree-height t)
(tree-span t)
(flatten t)
(flatten (tree-flip t))
