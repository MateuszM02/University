#lang racket

(require racket/trace)

(define (reverse-back! mlista last)
  (match mlista
    ['() last]
    [(mcons x xs) 
     (let ([tail xs]) ;zapamietaj ogon listy
          (set! xs (mcons x (mcons last null))) ;nowym ogonem listy jest poprzedni element
          (reverse-back! tail x))]))

(define (mreverse! q) ;odwraca liste mutowalna (1, 2 3)
  (define (rev q)
    (define nowa_glowa (mcar q))
    [set-mcdr! q (mreverse! (mcdr q))] ;wywolanie rekurencyjne na ogonie listy - odwrocenie ogona (1, 3 2)
    (if (null? (mcdr q)) ;jesli ogon jest pusty
        (mcar q) ;zwroc glowe
    (   [set! nowa_glowa (mcar (mcdr q))] ;zapamietuje glowe odwroconego ogonu (3) dla (1, 3 2)
        [set-mcdr! q (mcdr (mcdr q))] ;nowym ogonem jest glowa ogonu (1, 2)
        [set-mcdr! q q] ;nowym ogonem jest cala lista (1, 1 2)
        [set-mcar! q nowa_glowa] ;nowa glowa to zapamietana wartosc (3, 1 2)
        [set-mcdr! q (mreverse! (mcdr q))] ;wywolanie rekurencyjne na ogonie listy - odwrocenie ogona (3, 2 1)
    ))
  q)
  (trace rev)
  [cond
        [(null? q) q]
        [(null? (mcdr q)) (mcar q)]
        ;[(null? (mcdr (mcdr q))) q]
        [else (set-mcdr! q (rev (mcdr q)))]
  ]
  q)

(trace reverse-back!)
(trace mreverse!)

(define q0 (mcons 0 null))
(define q1 (mcons 1 (mcons 2 null)))
(define q2 (mcons 1 (mcons 2 (mcons 3 null))))
(define q3 (mcons 1 (mcons 2 (mcons 3 (mcons 4 null)))))
(mreverse! q0)
(mreverse! q1)
(mreverse! q2)
(mreverse! q3)
