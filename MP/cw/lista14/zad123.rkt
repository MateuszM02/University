#lang racket

;; streams aka lazy lists ---------------------------------

;; delay and force

(define-syntax-rule
  (stream-cons v s)
  (cons v (delay s)))

(define stream-car car)

(define (stream-cdr s)
  (force (cdr s)))

(define stream-null null)
(define stream-null? null?)

;; operations on streams

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

 ;; combining (infinite) streams 

(define (map2 f xs ys)
  (stream-cons
   (f (stream-car xs)
      (stream-car ys))
   (map2 f (stream-cdr xs) (stream-cdr ys))))

;zad1 - silnia---------------------------------------------

(define (integers-from n) ;z wykladu
  (stream-cons n (integers-from (+ n 1))))

;wersja z map2
(define fact
  (stream-cons 1 (map2 * fact (integers-from 1))))

;wersja iteracyjna z akumulatorem
(define (fact-it n acc)
  (stream-cons acc (fact-it (+ 1 n) (* n acc))))

(define fact2
  (fact-it 1 1))

;zad2 - sumy czesciowe-------------------------------------

;wersja iteracyjna z akumulatorem
(define (partial-sums-it s acc)
  (stream-cons acc (partial-sums-it (stream-cdr s) (+ (stream-car s) acc))))

(define (partial-sums2 s)
  (partial-sums-it (stream-cdr s) (stream-car s)))

;zad3 - Hamming--------------------------------------------

(define (only235? n) ;sprawdza, czy liczba jest iloczynem jedynie 2,3,5
  (cond [(or (= n 2) (= n 3) (= n 5)) #t]
        [(= (modulo n 2) 0) (only235? (/ n 2))]
        [(= (modulo n 3) 0) (only235? (/ n 3))]
        [(= (modulo n 5) 0) (only235? (/ n 5))]
        [else #f]
))

(define (first235 n) ;znajduje najmniejsza liczbe (nie mniejsza od n) bedaca iloczynem jedynie 2,3,5
  (if (only235? n)
      n
      (first235 (+ n 1))
))

;wersja iteracyjna z akumulatorem
(define (Hamming-it acc)
  (let ([next (first235 acc)])
    (stream-cons next (Hamming-it (+ 1 next)))
))

(define Hamming
  (Hamming-it 2))

;merge
(define (merge s1 s2)
  (cond
    [(stream-null? s1) s2]
    [(stream-null? s2) s1]
    [(< (stream-car s1) (stream-car s2))
     (stream-cons
       (stream-car s1)
       (merge (stream-cdr s1) s2))]
    [(> (stream-car s1) (stream-car s2))
     (stream-cons
       (stream-car s2)
       (merge s1 (stream-cdr s2)))]
    [else ;jesli (car s1) = (car s2) to zapominamy o (car s2) zeby uniknac powtorzen
     (merge s1 (stream-cdr s2))]
))

;scale
(define (scale s n)
  (if (stream-null? s)
      s
      (stream-cons (* (stream-car s) n) (scale (stream-cdr s) n))))
