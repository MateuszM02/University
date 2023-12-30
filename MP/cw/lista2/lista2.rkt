#lang racket

(define lista (list 2 3 5 7 11 13))
;zad1

(define (fib n)
  [cond [(= n 0) n]
        [(= n 1) n]
        [(< n 0) 0]
        [else (+ (fib (- n 1)) (fib (- n 2)))]
  ])

(define (iter n f1 f2)
  (cond [(= n 0) f1]
        [(< n 0) 0]
        [else [iter (- n 1) f2 (+ f1 f2)]]
  ))

(define (fib-iter n)
  (iter n 0 1))

;metoda iteracyjna jest szybsza od rekurencyjnej
;wynika to stąd, że metoda rekurencyjna czasami liczy tą samą liczbę kilka razy:
;przykład: (fib 3) = [+ (fib 2) (fib 1)] =
; = (+ [+ (fib 1) (fib 0)] (fib 1)) = (+ (+ 1 0) 1) = (+ 1 1) = 2
; jak widać, 2 razy obliczyliśmy fib(1), a przy większych liczbach jest jeszcze więcej powtórzeń








;zad4

(define (elem? x xs)
(if (null? xs) #f [if(= x (car xs)) #t (elem? x (cdr xs))]))






;zad5

(define (FindMax lista MaxValue)
  (if (null? lista) MaxValue
       (if (< MaxValue (car lista))
           (FindMax (cdr lista) (car lista))
           (FindMax (cdr lista) MaxValue)
        )))

(define (maximum xs)
  (if (null? xs) null
      (FindMax (cdr xs) (car xs))))






;zad6

(define (wypisz lista sufiksy indeks)
  (define s1 (cons (list-tail lista indeks) sufiksy))
  (if(> indeks 0)
     [wypisz lista s1 (- indeks 1)]
     s1))

(define (suffixes xs)
  (wypisz xs null (length xs)))

;(suffixes lista)






;zad7

;przykladowe listy do sprawdzenia poprawnosci kodu
(define lista71 (list 0))
(define lista72 (list 0 0 1))
(define lista73 (list 3 2 4 6))
(define lista74 (list 1 2 3 2))

;kod
(define (IsSorted list value)
  [if(null? list) #t
     [if(> value (car list)) #f (IsSorted (cdr list) (car list))]])

(define (sorted? xs)
  (if (null? xs) #t
      [IsSorted (cdr xs) (car xs)]
   ))






;zad8

(define lista81 (list 10 8 2 9 34))
(define lista82 (list 1 2 3 2))

;kod
(define (FindMin lista Min)
  (if(null? lista) Min
     [if(< (car lista) Min)
        (FindMin (cdr lista) (car lista))
        (FindMin (cdr lista) Min)
     ]))

(define (select xs)
  (define minimum (if(null? xs) null (FindMin (cdr lista) (car lista))))
  (cons minimum (remove minimum xs)))

(define (pom posortowane reszta)
  (define Min [if(null? reszta) null {FindMin (cdr reszta) (car reszta)}])
  (if (null? reszta) posortowane
      [pom (append posortowane (list Min)) (remove Min reszta)]))

(define (select-sort xs)
  (pom null xs))

;(select-sort lista81)



;;;;


;zad9

(define lista91 (list 4 6 9 12 16 19))
(define lista92 (list 12 6 9 19 4 13))

;split
(define (podzial glowna lista1 lista2 warunek)
  (cond [(null? glowna) (cons lista1 lista2)]
        [(> warunek 0) (podzial (cdr glowna) (append lista1 (list (car glowna))) lista2 (- warunek 1))]
        [else (podzial (cdr glowna) lista1 (append lista2 (list (car glowna))) (- warunek 1))]
        ))

(define (split xs)
  (podzial xs null null (/ (length xs) 2)))

;merge
(define (polacz glowna xs ys)
  (cond [(and (null? xs)(null? ys)) glowna]
        [(null? xs) (append glowna ys)]
        [(null? ys) (append glowna xs)]
        [(<= (car xs) (car ys)) [polacz (append glowna (list (car xs))) (cdr xs) ys]]
        [else [polacz (append glowna (list (car ys))) xs (cdr ys)]]
  ))

(define (merge xs ys)
  (polacz null xs ys))


;merge-sort
(define (merge-sort xs)
  (if [<= (length xs) 1] xs
      (merge [merge-sort (car (split xs))] [merge-sort(cdr (split xs))])
  ))

(merge-sort lista92)
