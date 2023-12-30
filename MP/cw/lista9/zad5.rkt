#lang plait

(define (fib-cont n f) ;wersja 1
  (if (< n 2)
      (f n)
      (+ (fib-cont (- n 1) [lambda (value) (f value)])
      (fib-cont (- n 2) [lambda (value) (f value)]))
))

(define (fib-cont2 n k) ;wersja 2
  (if (< n 2)
      (k 1)
      (fib-cont2 (- n 1) (lambda (f1)
                     (fib-cont2 (- n 2)
                          (lambda (f2)
                            (k (+ f1 f2))))))))
