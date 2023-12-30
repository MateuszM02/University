#lang racket

(require rackunit)

(define/contract (suffixes lista)
  ;kontrakt parametryczny:
  ;procedura suffixes bierze jako argument liste typu a, zwraca liste list typu a 
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
  
  (match lista
    	['() (list null)]
    	[(cons x xs) (cons (cons x xs) (suffixes xs))]
  ))

(define example (list 1 2 3 4))

(suffixes example)
