#lang racket
(require rackunit)

;zad5

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

;funkcja do przeszukiwania elementow drzewa
(define (fold-tree funkcja drzewo)
  (cond [(leaf? drzewo) null]
        [(node? drzewo)
         [funkcja (fold-tree funkcja (node-l drzewo)) (node-elem drzewo) (fold-tree funkcja (node-r drzewo))]
        ]
        [else #f]
  ))

;zmodyfikowany insert
(define (insert-bst x t)
  (cond [(leaf? t) (node (leaf) x (leaf))]
        [(node? t)
        (cond [(<= x (node-elem t))
                 (node
                 (insert-bst x (node-l t))
                 (node-elem t)
                 (node-r t))]
              [else
                (node
                 (node-l t)
                 (node-elem t)
                 (insert-bst x (node-r t))
                )]
        )]))

;utworz drzewo
(define (make-tree lista drzewo)
  (if (or (null? lista) (null? (car lista))) drzewo
  [make-tree (cdr lista) (insert-bst (car lista) drzewo)]))

;polacz listy
(define (polacz lewy elem prawy)
  (if (or (null? lewy) (null? (car lewy)))
      (cons elem prawy)
      (cons (car lewy) (polacz (cdr lewy) elem prawy))
  ))

;tree-sort
(define (tree-sort xs) (fold-tree polacz (make-tree xs (leaf))))

;przyklady
(tree-sort (list 7 11 3 10 77 63))
(tree-sort (list 72 87 67 3 47 1 21 71))
(tree-sort (list 1 2 1 3))

;niezmienniki programu
(check-equal?
    (insert-bst 8 (node (leaf) 7 [node (leaf) 9 (leaf)]))
    (node (leaf) 7 [node (node (leaf) 8 (leaf)) 9 (leaf)])) ;sprawdza poprawnosc wstawiania wartosci do drzewa bst
(check-equal?
    (insert-bst 7 (node (leaf) 7 [node (leaf) 9 (leaf)]))
    (node (node (leaf) 7 (leaf)) 7 [node (leaf) 9 (leaf)])) ;sprawdza poprawnosc wstawiania wartosci do drzewa bst (dla takich samych wartosci)
(check-equal?
    (make-tree (list null) (leaf))    (leaf)) ;sprawdza poprawnosc przeksztalcania listy na drzewo bst
(check-equal?
    (make-tree (list 5) (leaf))
    (node (leaf) 5 (leaf))) ;sprawdza poprawnosc przeksztalcania listy na drzewo bst
(check-equal?
    (make-tree (list 8 7 9) (leaf))
    (node (node (leaf) 7 (leaf)) 8 [node (leaf) 9 (leaf)])) ;sprawdza poprawnosc przeksztalcania listy na drzewo bst
(check-equal?
    (polacz (list null) 4 (list 0 4))
    (list 4 0 4)) ;sprawdza poprawnosc laczenia 2 list i elementu w jedna liste
(check-equal?
    (polacz (list 1 2 3) 4 (list 5 6))
    (list 1 2 3 4 5 6)) ;sprawdza poprawnosc laczenia 2 list i elementu w jedna liste
(check-equal?
 (fold-tree polacz (make-tree (list 14 11 17 11) (leaf)))
 (list 11 11 14 17)) ;sprawdza poprawnosc folda
(check-equal?
 (tree-sort (list 14 11 17 11))
 (list 11 11 14 17)) ;sprawdza poprawnosc sortowania
