#lang racket
(require data/heap)
(require racket/trace)
(require rackunit)

(provide sim? wire?
         (contract-out
          [make-sim        (-> sim?)] ;ok
          [sim-wait!       (-> sim? positive? void?)] ;???
          [sim-time        (-> sim? real?)] ;ok
          [sim-add-action! (-> sim? positive? (-> any/c) void?)] ;ok 

          [make-wire       (-> sim? wire?)] ;ok
          [wire-on-change! (-> wire? (-> any/c) void?)] ;ok??
          [wire-value      (-> wire? boolean?)] ;ok
          [wire-set!       (-> wire? boolean? void?)] ;ok??

          [bus-value (-> (listof wire?) natural?)] ;gotowe
          [bus-set!  (-> (listof wire?) natural? void?)] ;gotowe

          [gate-not  (-> wire? wire? void?)] ;ok
          [gate-and  (-> wire? wire? wire? void?)] ;ok
          [gate-nand (-> wire? wire? wire? void?)] ;ok
          [gate-or   (-> wire? wire? wire? void?)] ;ok
          [gate-nor  (-> wire? wire? wire? void?)] ;ok
          [gate-xor  (-> wire? wire? wire? void?)] ;ok

          [wire-not  (-> wire? wire?)] ;ok
          [wire-and  (-> wire? wire? wire?)] ;ok
          [wire-nand (-> wire? wire? wire?)] ;ok
          [wire-or   (-> wire? wire? wire?)] ;ok
          [wire-nor  (-> wire? wire? wire?)] ;ok
          [wire-xor  (-> wire? wire? wire?)] ;ok

          [flip-flop (-> wire? wire? wire? void?)])) ;gotowe

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
moje definicje - struktury
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

(struct sim ([t #:mutable] [actHeap #:mutable]) #:transparent) ;(real? heap?)
(struct wire ([status #:mutable] [actions #:mutable] [sim]) #:transparent) ;(boolean? list? sim?)
(struct action (fun time)) ;((-> any) real?) 

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
moje definicje
-------------------------------------------------------------------------------------------------------------------------------------------------------|#
;funkcje poprawiajace czytelnosc kodu

;dodaje element na koniec listy
(define/contract (add-end x xs)
  (-> any/c (listof any/c) (listof any/c))
  (match xs
    ['() (list x)]
    [(cons h t)
     (cons h (add-end x t))]
))

;zwraca najwczesniejsza akcje w symulacji
(define/contract (first-action s)
  (-> sim? action?)
  (heap-min (sim-actHeap s)))

;zwraca czas najwczesniejszej akcji w symulacji
(define/contract (time-of-first s)
  (-> sim? real?)
  (action-time (first-action s)))

;zwraca procedure najwczesniejszej akcji w symulacji
(define/contract (fun-of-first s)
  (-> sim? (-> any))
  (action-fun (first-action s)))

;sprawdza, czy kopiec jest pusty
(define/contract (empty-heap? h)
  (-> heap? boolean?)
  (equal? (heap-count h) 0))

;sprawdza, czy kopiec nalezacy do symulacji jest pusty
(define/contract (empty-sim-heap? s)
  (-> sim? boolean?)
  (empty-heap? (sim-actHeap s)))

;================================================

;sprawdza, czy przewody sa w tej samej symulacji
(define/contract (same-sim? xs)
  (-> (non-empty-listof wire?) boolean?)
  (define (check xs expected_sim)
    (match xs
      ['() #t]
      [(cons h t)
       (and (equal? (wire-sim h) expected_sim)
            (check t expected_sim))]
  ))
  (check (cdr xs) (wire-sim (car xs))))

;wywoluje wszystkie akcje podpiete do przewodu
(define/contract (run-actions w)
  (-> wire? void?)
  (foldl (lambda (action acc) (action)) (void) (wire-actions w)))

;uruchamia i usuwa najwczesniejsza akcje symulacji
(define/contract (run-and-remove-first! s)
  (-> sim? void?)
  (if (empty-sim-heap? s) ;jesli symulacja nie zawiera zadnych akcji
      (void)
      (begin
        ((fun-of-first s)) ;wykonaj akcje
        (heap-remove-min! (sim-actHeap s)) ;usun akcje
)))

;komparator 2 akcji
(define/contract (sort-by-time a1 a2)
  (-> action? action? boolean?)
  (<= (action-time a1) (action-time a2)))

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
moje definicje z szablonu
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

(define (call sim action)
  (heap-remove-min! (sim-actHeap sim)) ;usun aktulana akcje
  ((action-fun action)) ;wykonaj aktualną akcje
  )

;tworzenie nowej symulacji
(define/contract (make-sim)
  (-> sim?)
  (sim 0 (make-heap sort-by-time)))

;wlaczanie symulacji na time jednostek czasu
(define/contract (sim-wait! s time)
  (-> sim? real? void?)
  (cond
    [(empty-sim-heap? s) ;jesli symulacja nie ma zadnych akcji
     (set-sim-t! s (+ time (sim-time s)))] 
    [(<= (time-of-first s) (+ (sim-time s) time)) ;jesli najwczesniejsza akcja ma sie wykonac przed koncem symulacji
     (begin
        (define time_left (- (+ (sim-time s) time) (time-of-first s))) ;ilosc czasu pomiedzy wykonaniem 1 akcji a koncem symulacji 
        (set-sim-t! s (time-of-first s)) ;ustal czas symulacji na czas wykonania 1 akcji symulacji
        (run-and-remove-first! s) ;wykonuje najwczesniejsza akcje symulacji, po czym usuwa ja
        (sim-wait! s time_left))]
   [else ;jesli najwczesniejsza akcja ma sie wykonac po zakonczeniu symulacji
      (set-sim-t! s (+ time (sim-time s)))]
))

;aktualny czas symulacji
(define/contract (sim-time s)
  (-> sim? real?)
  (sim-t s))

;dodawanie akcji do symulacji
(define/contract (sim-add-action! s time fun)
  (-> sim? positive? (-> any/c) void?)
  (heap-add! (sim-actHeap s) (action fun (+ (sim-time s) time)))) ;dodawanie akcji za time sekund

;tworzenie przewodu
(define/contract (make-wire s)
  (-> sim? wire?)
  (wire #f null s))

;dodawanie akcji do przewodu
(define/contract (wire-on-change! w action)
  (-> wire? (-> any/c) void?)
  (begin
    (set-wire-actions! w (add-end action (wire-actions w))) ;dodaje akcje na koniec listy akcji przewodu
    (action))) ;i od razu ja uruchamia

;zwraca stan przewodu
(define/contract (wire-value w)
  (-> wire? boolean?)
  (wire-status w))

;ustawianie nowego stanu przewodu
(define/contract (wire-set! w value)
  (-> wire? boolean? void?)
  (if (equal? (wire-status w) value) ;jesli stan sie nie zmienia
      (void) ;nie rob nic
      [begin
        (set-wire-status! w value) ;w p.p. zmien stan
        (run-actions w)]) ;i wywolaj akcje
)

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
moje definicje - gate
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

;dodaje akcje do przewodow
(define/contract (gate-action-changer! out in1 in2 action)
  (-> wire? wire? wire? (-> any) void?)
  (if (same-sim? (list out in1 in2))
      (begin
        (wire-on-change! in1 action)
        (wire-on-change! in2 action))
      (error 'gate-action-handler "bramki sa w roznych symulacjach!")))

;bramka not
(define/contract (gate-not out in)
  (-> wire? wire? void?)
  (define (not-action)
    (sim-add-action! (wire-sim out)
                     1
                     (lambda () (wire-set! out (not (wire-value in))))))
  (wire-on-change! in not-action))

;bramka and
(define/contract (gate-and out in1 in2)
  (-> wire? wire? wire? void?)
  (define (and-action)
    (sim-add-action! (wire-sim out)
                     1
                     (lambda () (wire-set! out (and (wire-value in1) (wire-value in2))))))
  (gate-action-changer! out in1 in2 and-action))

;bramka nand
(define/contract (gate-nand out in1 in2)
  (-> wire? wire? wire? void?)
  (define (nand-action)
    (sim-add-action! (wire-sim out)
                     1
                     (lambda () (wire-set! out (nand (wire-value in1) (wire-value in2))))))
  (gate-action-changer! out in1 in2 nand-action))

;bramka or
(define/contract (gate-or out in1 in2)
  (-> wire? wire? wire? void?)
  (define (or-action)
    (sim-add-action! (wire-sim out)
                     1
                     (lambda () (wire-set! out (or (wire-value in1) (wire-value in2))))))
  (gate-action-changer! out in1 in2 or-action))

;bramka nor
(define/contract (gate-nor out in1 in2)
  (-> wire? wire? wire? void?)
  (define (nor-action)
    (sim-add-action! (wire-sim out)
                     1
                     (lambda () (wire-set! out (nor (wire-value in1) (wire-value in2))))))
  (gate-action-changer! out in1 in2 nor-action))

;bramka xor
(define/contract (gate-xor out in1 in2)
  (-> wire? wire? wire? void?)
  (define (xor-action)
    (sim-add-action! (wire-sim out)
                     2
                     (lambda () (wire-set! out (xor (wire-value in1) (wire-value in2))))))
  (gate-action-changer! out in1 in2 xor-action))

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
moje definicje - wire
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

;not
(define/contract (wire-not in)
  (-> wire? wire?)
  (define out (make-wire (wire-sim in))) ;tworzy nowy przewod
  (gate-not out in) ;dodaje akcje not
  out)
;pozostale przewody tworzymy w identyczny sposob, zmieniajac jedynie nazwy bramek

;and
(define/contract (wire-and in1 in2)
  (-> wire? wire? wire?)
  (define out (make-wire (wire-sim in1)))
  (begin
    (gate-and out in1 in2)
    out))

;nand
(define/contract (wire-nand in1 in2)
  (-> wire? wire? wire?)
  (define out (make-wire (wire-sim in1)))
  (begin
    (gate-nand out in1 in2)
    out))

;or
(define/contract (wire-or in1 in2)
  (-> wire? wire? wire?)
  (define out (make-wire (wire-sim in1)))
  (begin
    (gate-or out in1 in2)
    out))

;nor
(define/contract (wire-nor in1 in2)
  (-> wire? wire? wire?)
  (define out (make-wire (wire-sim in1)))
  (begin
    (gate-nor out in1 in2)
    out))

;xor
(define/contract (wire-xor in1 in2)
  (-> wire? wire? wire?)
  (define out (make-wire (wire-sim in1)))
  (begin
    (gate-xor out in1 in2)
    out))

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
bus
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

(define/contract (bus-set! wires value)
  (-> (listof wire?) natural? void?)
  (match wires
    ['() (void)]
    [(cons w wires)
     (begin
       (wire-set! w (= (modulo value 2) 1))
       (bus-set! wires (quotient value 2)))]
))

(define/contract (bus-value ws)
  (-> (listof wire?) natural?)
  (foldr (lambda (w value) (+ (if (wire-value w) 1 0) (* 2 value)))
         0
         ws))

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
flip-flop
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

(define/contract (flip-flop out clk data)
  (-> wire? wire? wire? void?)
  (define simf (wire-sim data))
  (define w1  (make-wire simf))
  (define w2  (make-wire simf))
  (define w3  (wire-nand (wire-and w1 clk) w2))
  (gate-nand w1 clk (wire-nand w2 w1))
  (gate-nand w2 w3 data)
  (gate-nand out w1 (wire-nand out w3)))

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
przyklady i testy
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

(define add_simulation (make-sim))
(define wire_add_1 (make-wire add_simulation))
(define wire_add_2 (make-wire add_simulation))
(define wire_not2 (wire-not wire_add_2))
(define output_1 (wire-xor wire_add_1 wire_add_2))
(define output_2 (wire-and wire_add_1 wire_add_2))

;--------------------------------------------------

(wire-set! wire_add_1 #t)

(check-equal? (wire-value wire_not2) #f) ;test 1 - not
(check-equal? (wire-value output_1) #f) ;test 2 - xor
(check-equal? (wire-value output_2) #f) ;test 3 - and
(sim-wait! add_simulation 2)
(check-equal? (wire-value output_1) #t) ;test 4 - xor
(check-equal? (wire-value output_2) #f) ;test 5 - and
(wire-set! wire_add_2 #t)
(sim-wait! add_simulation 2)
(check-equal? (wire-value output_1) #f) ;test 6 - xor
(check-equal? (wire-value output_2) #t) ;test 7 - and

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
jeszcze wiecej testow
-------------------------------------------------------------------------------------------------------------------------------------------------------|#

(define mult_simulation(make-sim))
(define cabel_A0 (make-wire mult_simulation))
(define cabel_A1 (make-wire mult_simulation))
(define cabel_B0 (make-wire mult_simulation))
(define cabel_B1 (make-wire mult_simulation))
(define cabel_H1 (wire-and cabel_A0 cabel_B1))
(define cabel_H2 (wire-and cabel_A1 cabel_B0))
(define cabel_H3 (wire-and cabel_A1 cabel_B1))
(define cabel_H4 (wire-and cabel_H1 cabel_H2))
(define cabel_O1 (wire-and cabel_A0 cabel_B0))
(define cabel_O2 (wire-xor cabel_H1 cabel_H2))
(define cabel_O3 (wire-xor cabel_H4 cabel_H3))
(define cabel_O4 (wire-and cabel_H4 cabel_H3))
(wire-set! cabel_A0 #t)
(sim-wait! mult_simulation 10)
(check-equal? (wire-value cabel_O1) #f)
(check-equal? (wire-value cabel_O2) #f)
(check-equal? (wire-value cabel_O3) #f)
(check-equal? (wire-value cabel_O4) #f)
(wire-set! cabel_B0 #t)
(sim-wait! mult_simulation 10)
(check-equal? (wire-value cabel_O1) #t)
(check-equal? (wire-value cabel_O2) #f)
(check-equal? (wire-value cabel_O3) #f)
(check-equal? (wire-value cabel_O4) #f)
(wire-set! cabel_B0 #f)
(wire-set! cabel_B1 #t)
(sim-wait! mult_simulation 10)
(check-equal? (wire-value cabel_O1) #f)
(check-equal? (wire-value cabel_O2) #t)
(check-equal? (wire-value cabel_O3) #f)
(check-equal? (wire-value cabel_O4) #f)

#|-------------------------------------------------------------------------------------------------------------------------------------------------------
przyklad z wykladu
-------------------------------------------------------------------------------------------------------------------------------------------------------|#
(define sim1 (make-sim))

(define (make-counter n clk en)
  (if (= n 0)
      '()
      (let [(out (make-wire sim1))]
        (flip-flop out clk (wire-xor en out))
        (cons out (make-counter (- n 1) clk (wire-and en out))))))

(define clk (make-wire sim1))
(define en  (make-wire sim1))
(define counter (make-counter 4 clk en))

(define (tick)
  (wire-set! clk #t)
  (sim-wait! sim1 20)
  (wire-set! clk #f)
  (sim-wait! sim1 20)
  (bus-value counter))
