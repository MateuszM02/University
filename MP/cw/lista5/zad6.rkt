#lang plait

;typ rose-trees

(define-type (rose-trees 'a)
  (leaf [value : 'a])
  (node [poddrzewa : (Listof (rose-trees 'a))]))

;procedura wypisujaca wszystkie elementy rose-trees w porzadku in-order

(define (print-all tree lista)
  (cond [(leaf? tree)
               (cons (leaf-value tree) lista)]
        [(node? tree)
               (foldr [lambda (x xs) (print-all x xs)] lista (node-poddrzewa tree))
        ]))

;przyklady

(define example1
  (node [list (leaf 1) (leaf 5)]))

(define example2
  (node [list (leaf 1) (node (list (leaf 3) (leaf 4))) (leaf 5)]))

(print-all example1 empty)
(print-all example2 empty)
