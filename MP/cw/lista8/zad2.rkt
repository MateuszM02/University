#lang racket

(provide
 mqueue?
 nonempty-mqueue/c
 (contract-out
  [mqueue-empty? (-> mqueue? boolean?)]
  [mqueue-make   (-> mqueue?)]
  [mqueue-push-back   (-> mqueue? any/c any/c)]
  [mqueue-push-front   (-> mqueue? any/c any/c)]
  ;[mqueue-pop-back    (-> nonempty-mqueue/c any/c)]
  ;[mqueue-pop-front    (-> nonempty-mqueue/c any/c)]
  [mqueue-back   (-> nonempty-mqueue/c any/c)]
  [mqueue-front   (-> nonempty-mqueue/c any/c)]
  [mqueue-join   (-> nonempty-mqueue/c nonempty-mqueue/c any/c)]))

(define (insert-after p1 p2)
  (define p3 (mcdr p1))
  (set-mcdr! p2 p3)
  (set-mcdr! p1 p2))

(struct mqueue
  ([front #:mutable] [back #:mutable]))

(define (mqueue-empty? q)
  (null? (mqueue-front q)))

(define nonempty-mqueue/c
  (and/c mqueue? (not/c mqueue-empty?)))

(define (mqueue-make)
  (mqueue null null))

(define (mqueue-push-back q x) ;dodaje element na koniec kolejki
  (define p (mcons x null))
  (if (mqueue-empty? q)
      (set-mqueue-front! q p)
      (set-mcdr! (mqueue-back q) p))
  (set-mqueue-back! q p))

(define (mqueue-push-front q x) ;dodaje element na poczatek kolejki DO POPRAWY
  (define p (mcons x null))
  (if (mqueue-empty? q)
      (set-mqueue-front! q p)
      (set-mqueue-front! q (mcons x (mqueue-front q)))))
      ;(set-mcar! (mqueue-front q) p))
  ;(set-mqueue-front! q p))

(define/contract (mqueue-pop q)
  (-> nonempty-mqueue/c any/c)
  (define p (mqueue-front q))
  (set-mqueue-front! q (mcdr p))
  (mcar p))

(define (mqueue-peek q)
  (mcar (mqueue-front q)))

(define (mqueue-join q1 q2)
  (set-mcdr! (mqueue-back q1) (mqueue-front q2))
  (set-mqueue-back! q1 (mqueue-back q2))
  (set-mqueue-front! q2 null))

;przyklady

(define m (mqueue-make))
(mqueue-push-front m 1)
(mqueue-push-front m 2)
(mqueue-front m)
(mqueue-pop m)
(mqueue-front m)
(mqueue-pop m)
(mqueue-front m)
(mqueue-push-front m 3)
(mqueue-front m)
