#lang plait

;============================================================

(define-type-alias (Stream 'a) (-> (StreamData 'a)))
(define-type (StreamData 'a)
(sempty)
(scons [head : 'a] [tail : (-> (StreamData 'a))]))

;============================================================

;typ: ((-> (StreamData (-> (StreamData 'a)))) -> (-> (StreamData 'a)))
(define (concat-streams [s : (Stream (Stream 'a))])
  (lambda () (type-case (StreamData (Stream 'a)) (s)
      [(sempty) (sempty)]
      [(scons s1 s2) ((stream-join s1 (concat-streams s2)))]
)))

;typ: ((-> (StreamData 'a)) (-> (StreamData 'a)) -> (-> (StreamData 'a)))
(define (stream-join stream1 stream2) ;dolacza 2 strumien na koniec 1 strumienia
  (lambda () (type-case (StreamData 'a) (stream1)
                          [(sempty) (stream2)]
                          [(scons h t) (scons h (stream-join t stream2))]
)))

;typ: (Number (Number -> 'a) -> (-> (StreamData 'a)))
(define (build-stream n f) ;odpowiednik build-list dla strumienii 
  (lambda ()
                          (if (= n 0) (sempty)
                          (scons (f (- n 1)) (build-stream (- n 1) f))
)))

;============================================================

;typ: (Number (Listof Number) -> Boolean)
(define (valid-pos? i board)
  (local
    [(define (valid-it i j k board)
       (type-case (Listof Number) board
         [empty #t]
         [(cons x board)
          (and (not (= i x))
               (not (= j x))
               (not (= k x))
               (valid-it (- i 1) j (+ k 1) board))]))]
    (valid-it (- i 1) i (+ i 1) board)))

;============================================================
;Z WYKLADU 10
;============================================================

(define (concat xs)
  (if (empty? xs)
      empty
      (append (first xs) (concat (rest xs)))))

(define (queens n)
  (local
    [(define (queens-it board left)
       (if (= left 0)
           (list board)
           (concat (build-list n (lambda (i)
              (if (valid-pos? i board)
                  (queens-it (cons i board) (- left 1))
                  '()))))))]
    (queens-it '() n)))

;============================================================

(define (select xs cont)
  (type-case (Listof 'a) xs
    [empty (none)]
    [(cons x xs)
     (type-case (Optionof 'b) (cont x)
       [(none)   (select xs cont)]
       [(some v) (some v)])]))

(define (fail cont)
  (none))

(define (init-cont x) (some x))

(define (select-number n cont)
  (select (build-list n (lambda (i) i)) cont))

(define (queens2 n)
  (local
    [(define (queens-it board left cont)
       (if (= left 0)
           (cont board)
           (select-number n (lambda (i)
             (if (valid-pos? i board)
                 (queens-it (cons i board) (- left 1) cont)
                 (fail cont))))))]
    (queens-it '() n init-cont)))

;============================================================

;typ: ((StreamData 'a) -> (Listof 'a))
(define (stream->list stream) ;zamienia strumien na liste
  (local
       [(define (iter s acc)
                (cond
                     [(sempty? s) acc]
                     [else (iter ((scons-tail s)) (append acc (list (scons-head s))))]
       ))]
    (iter stream empty)
))

;typ: (Number -> (-> (StreamData (Listof Number))))
(define (queens-streams n)
  (local
    [(define (queens-it board left)
       (if (= left 0)
           (lambda () (scons board (lambda () (sempty))))
           (concat-streams (build-stream n (lambda (i)
              (if (valid-pos? i board)
                  (queens-it (cons i board) (- left 1))
                  (lambda () (sempty))))))))]
    (queens-it '() n)))

;typ: (Number -> (Listof (Listof Number)))
(define (wynik n)
  (stream->list ((queens-streams n))))

;============================================================
