#lang racket
(require rackunit)

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

;przykladowe drzewa
( define t
( node
  [ node ( leaf ) 2 ( leaf ) ]
  5
  [ node 
         ( node ( leaf ) 6 ( leaf ) )
         8
         ( node (leaf) 9 ( leaf ) ) ]
) )

(define nie_bst
(node [node (leaf) 10 (leaf)] 5 (leaf)
))

(define bst_tree
(node [node (leaf) 6 [node (leaf) 6 (leaf)]] 8 (leaf)
))

(define nie_bst2
(node [node (leaf) 6 [node (leaf) 10 (leaf)]] 8 (leaf)
))

;zad3

(define (bst? t)
  (define (is_in_range t min max)
    (cond [(leaf? t) #t]
          [(< (node-elem t) min) #f]
          [(> (node-elem t) max) #f]
          [else (and
              [is_in_range (node-l t) min (node-elem t)]
              [is_in_range (node-r t) (node-elem t) max]
          )]
  ))
(is_in_range t -inf.0 +inf.0))

(define (sum-paths t)
  (define (current_sum t c)
    (if (leaf? t)   t
        [node
        (current_sum (node-l t) (+ c (node-elem t)))
        (+ c (node-elem t))
        (current_sum (node-r t) (+ c (node-elem t)))
  ]))
(current_sum t 0))

;przyklady
(check-equal? (bst? t) #t)
(check-equal? (bst? nie_bst) #f)
(check-equal? (bst? bst_tree) #t)
(check-equal? (bst? nie_bst2) #f)
(check-equal? (sum-paths nie_bst) (node [node (leaf) 15 (leaf)] 5 (leaf)))
(check-equal? (sum-paths bst_tree) (node [node (leaf) 14 [node (leaf) 20 (leaf)]] 8 (leaf)))
(check-equal? (sum-paths nie_bst2) (node [node (leaf) 14 [node (leaf) 24 (leaf)]] 8 (leaf)))
