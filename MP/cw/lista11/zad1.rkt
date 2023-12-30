#lang plait

;my-and
(define-syntax my-and
  (syntax-rules ()
    [(my-and) #t]
    [(my-and v1 v2 ...)
        (if(equal? v1 #f)
        #f
        (my-and v2 ...))]))

;my-or
(define-syntax my-or
  (syntax-rules ()
    [(my-or) #f]
    [(my-or v1 v2 ...)
        (if(equal? v1 #t)
        #t
        (my-or v2 ...))]))

;my-let*
(define-syntax my-let*
  (syntax-rules ()
    [(my-let* ([x v]) exp)
     ((lambda (x) exp) v)]
    [(my-let* ([x1 v1] [x2 v2] ...) exp)
        ((lambda (x1) (my-let* ([x2 v2] ...) exp)) v1)]))

;my-let
(define-syntax my-let
  (syntax-rules ()
    [(my-let ([x v]) exp)
     ((lambda (x) exp) v)]
    [(my-let ([x1 v1] ... [x2 v2]) exp)
        ((lambda (x2) (my-let ([x1 v1] ...) exp)) v2)]))

#|----------------------------------------------------------------------------------------------------
testy do zadania
----------------------------------------------------------------------------------------------------|#

(module+ test
  (print-only-errors #t)
  ;testy na my-and oraz my-or
  (test (my-and #t #t) (and #t #t)) ;#t
  (test (my-and #t #f) (and #t #f)) ;#f
  (test (my-or #f #t) (or #f #t)) ;#t
  (test (my-or #f #f) (or #f #f)) ;#f
  ;testy na my-let oraz my-let*
  (test (my-let ([x 2] [y 3]) (+ x y)) (let ([x 2] [y 3]) (+ x y))) ;5
  (test (my-let* ([x 2] [y 3]) (+ x y)) (let* ([x 2] [y 3]) (+ x y))) ;5
  (test (my-let ([x 2]) (my-let ([x 3] [y x]) y)) (let ([x 2]) (let ([x 3] [y x]) y))) ;2
  (test (my-let* ([x 2]) (my-let* ([x 3] [y x]) x)) (let* ([x 2]) (let* ([x 3] [y x]) y))) ;3
)
