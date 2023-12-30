#lang plait

(define-type (Tree 'a)
  (leaf)
  (node [l : (Tree 'a)] [elem : 'a] [r : (Tree 'a)]))

;zad5

(define (process-tree fnode fleaf accl accr acc tree)
  (if (leaf? tree)
      (fleaf acc) ;procedura dla wezla
      (fnode acc
             (process-tree fnode fleaf accl accr (accl acc (node-elem tree)) (node-l tree)) ;akumulator lewej galezi
             (node-elem tree) ;zawartosc akumulatora
             (process-tree fnode fleaf accl accr (accr acc (node-elem tree)) (node-r tree)) ;akumulator prawej galezi
             ))) ;procedura dla liscia

(define (sum-paths t)
  (process-tree (lambda (a b c d) (node b (+ a c) d)) ;procedura dla wezla
                (lambda (x) (leaf)) ;procedura dla liscia
                + + 0 t))

(define (bst? t)
  (process-tree
                (lambda (a b c d)
                                (and (> (snd a) c) (< (fst a) c) (and b d))) ;procedura dla wezla
                (lambda (x) #t) ;procedura dla liscia
                (lambda (x y) (pair (fst x) y)) ;akumulator lewej galezi
                (lambda (x y) (pair y (snd x))) ;akumulator prawej galezi
                (pair -inf.0 +inf.0) ;poczatkowa zawartosc akumulatora
                t))

;przyklad

(define example-tree (node (node (leaf) 1 (leaf))
                           2
                           (node (node (leaf) 3 (leaf))
                                 4
                                 (node (leaf)
                                       5
                                       (node (leaf) 6 (leaf))))))

example-tree
(sum-paths example-tree)
(bst? example-tree)
