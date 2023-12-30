#lang racket

(define/contract (foldl-map f a xs)
  ;zauwazmy, ze elementy listy wejsciowej moga byc innego typu niz elementy listy wyjsciowej
  (parametric->/c [type1 type2 acc] (-> (-> type1 acc (list*of type2 acc)) acc (listof type1) (list*of (listof type2) acc)))
  (define (it a xs ys)
    (if (null? xs)
      (cons (reverse ys) a)
      (let [(p (f (car xs) a))]
        (it (cdr p)  (cdr xs) (cons (car p) ys))
      )))
  (it a xs null))
  
(foldl-map (lambda (x a) (cons a (+ a x))) 0 (list 1 2 3)) ;sumy czesciowe
(foldl-map (lambda (x a) (cons x (+ a x))) 0 (list 1 2 3)) ;suma liczb
(foldl-map (lambda (x a) (cons x [and a (positive? x)])) #t (list 1 2 3)) ;czy wszystkie liczby na liscie sa dodatnie?
(foldl-map (lambda (x a) (cons x (string-append a x))) "" (list "zadanie" "_" "6")) ;polaczenie listy znakow w 1 znak
(foldl-map (lambda (x a) (cons (string-length x) (+ a (string-length x)))) 0 (list "a" "bb" "ccc")) ;dlugosc laczna i poszczegolnych znakow
