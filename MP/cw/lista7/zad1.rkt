#lang plait

;Zadanie 1

(define-type (2-3tree 'a)
  (leaf)
  (2-node (left : (2-3tree 'a)) (elem : 'a) (right : (2-3tree 'a)))
  (3-node (left : (2-3tree 'a)) (elem1 : 'a)
          (middle : (2-3tree 'a))
          (elem2 : 'a) (right : (2-3tree 'a))))

(define (is23tree? t min max acc wys) ;sprawdza, czy drzewo t spelnia wszystkie warunki 2-3 drzewa
  (type-case (2-3tree 'a) t
    [(leaf) (equal? acc wys)] ;jesli drzewo jest lisciem, sprawdz, czy wysokosc jest odpowiednia
    [(2-node l x r) ;gdy drzewo ma 2 dzieci
     (and (< min x)
          (< x max)
          (is23tree? l min x (+ acc 1) wys) ;rekurencyjne sprawdzenie dla lewego poddrzewa
          (is23tree? r x max (+ acc 1) wys) ;rekurencyjne sprawdzenie dla prawego poddrzewa
     )]
     [(3-node l a m b r) ;gdy drzewo ma 3 dzieci
     (and (> a b)
          (< min a)
          (< min b)
          (< a max)
          (< b max)
          (is23tree? l min b (+ acc 1) wys) ;rekurencyjne sprawdzenie dla lewego poddrzewa
          (is23tree? m b a (+ acc 1) wys) ;rekurencyjne sprawdzenie dla srodkowego poddrzewa
          (is23tree? r a max (+ acc 1) wys) ;rekurencyjne sprawdzenie dla prawego poddrzewa
     )]
  ))

(define (tree-height t acc) ;zwraca wysokosc lewego poddrzewa, ktora powinna byc o 1 mniejsza od aktualnego drzewa
  (type-case (2-3tree 'a) t
    [(leaf) acc]
    [(2-node l x r) (tree-height l (+ acc 1))]
    [(3-node l x m y r) (tree-height l (+ acc 1))]))

(define (2-3tree-true? t)
  (is23tree? t -inf.0 +inf.0 0 (tree-height t 0)))

;przyklady:

(define tree1
  (2-node (3-node (2-node (leaf) -5 (leaf))
                  33
                  (2-node (leaf) 30 (leaf))
                  24
                  (2-node (leaf) 39 (leaf)))
          42
          (2-node (2-node (leaf) 100 (leaf))
                  123
                  (3-node (leaf) 9999 (leaf) 2022 (leaf)))))

(define tree2
  (2-node (3-node (2-node (leaf) -5 (leaf))
                  21
                  (2-node (leaf) 30 (leaf))
                  37
                  (2-node (leaf) 39 (leaf)))
          42
          (2-node (2-node (leaf) 100 (leaf))
                  123
                  (3-node (leaf) 9999 (leaf) 2022 (leaf)))))

(test (2-3tree-true? tree1)  #t)
(test (2-3tree-true? tree2) #f)
