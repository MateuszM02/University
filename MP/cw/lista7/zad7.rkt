#lang plait

(define-type (Tree23 'a)
  (leaf)
  [node12 [l : (Tree23 'a)] (elem : 'a) [r : (Tree23 'a)]]
  [node23 [l : (Tree23 'a)] [c : (Tree23 'a)] [r : (Tree23 'a)] (elem1 : 'a) (elem2 : 'a)])

(define (good-height? tree)
  (local [(define (help t) 0)]) 0)
    ;(type-case (Tree23 'a) t
     ; [(leaf) #t]
     ; [(node12 l x r) #t]
     ; [(node23 l c r x1 x2) #t]
    ;));(help tree))

(define (sum xs)
  (local [(define (it xs acc)
            (if (empty? xs)
                acc
                (it (rest xs) (+ acc (first xs)))))]
    (it xs 0)))


(define example (node23 (leaf) (leaf) (leaf) 'dwa 'trzy))
example
