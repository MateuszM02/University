#lang racket

(require rackunit)

;zad7

( define empty-queue (cons (list null) (list null)))
;czy kolejka jest pusta?
( define ( empty? q )
( equal? (car q) {or (list null) null} ))
;dodaj element na koniec kolejki
( define ( push-back elem kolejka ) 
( cond [(empty? kolejka) (cons (list elem) (list null))]
       [(null? (cadr kolejka)) (cons (car kolejka) (list elem))]
       [else (cons (car kolejka) (cons elem (cdr kolejka)))]
))

; podejrzyj element na poczatku kolejki
(define (front kolejka) 
(caar kolejka))

;odwroc
(define (reverse xs)
  (define (it xs ys)
    (if (null? xs)
        ys
        (it (cdr xs) (cons (car xs) ys))))
  (it xs null))

;zdejmij element z przodu kolejki
(define (pop kolejka)
(cond [(empty? kolejka) #f] ;jesli kolejka jest pusta, nie mozna zdjac elementu
      [(null? (cdr kolejka)) empty-queue] ;jesli kolejka zawiera 1 element, zwroc pusta kolejke
      [(null? (cdar kolejka)) ;jesli 1 lista kolejki zawiera 1 element
       (if(null? (cddr kolejka)) (cons (list (cadr kolejka)) (list null)) ;jesli 2 lista kolejki zawiera 1 element
       (cons (reverse (cddr kolejka)) (list (cadr kolejka))))] ;w pp
      [else (cons (cdar kolejka) (cdr kolejka))]
))

;przyklad dzialania programu

(define kol (push-back 1 empty-queue)) ;tworzy 1-elementowa kolejke z wartoscia 1
kol
(set! kol (push-back 2 kol)) ;dodaje wartosc 2 na koniec kolejki
kol
(set! kol (push-back 3 kol)) ;dodaje wartosc 3 na koniec kolejki
kol
(set! kol (push-back 4 kol)) ;dodaje wartosc 4 na koniec kolejki
kol
(set! kol (pop kol)) ;usuwa wartosc z poczatku kolejki (o ile jest niepusta)
kol
(set! kol (pop kol)) ;usuwa wartosc z poczatku kolejki (o ile jest niepusta)
kol
(set! kol (pop kol)) ;usuwa wartosc z poczatku kolejki (o ile jest niepusta)
kol
(set! kol (pop kol)) ;usuwa wartosc z poczatku kolejki (o ile jest niepusta)
kol
(set! kol (pop kol)) ;usuwa wartosc z poczatku kolejki (o ile jest niepusta)
kol

;niezmienniki programu - sprawdzaja poprawnosc dzialania funkcji

(check-equal? (empty? empty-queue) #t) ;sprawdza poprawnosc dzialania funkcji empty?
(check-equal? (push-back 1 empty-queue) (cons (list 1) (list null))) ;sprawdza czy dodawanie elementow do pustej kolejki odbywa sie poprawnie
(check-equal? (push-back 2 (cons (list 1) (list null))) (cons (list 1) (list 2))) ;sprawdza czy dodawanie elementow do 1-elementowej kolejki odbywa sie poprawnie
(check-equal? (push-back 3 (cons (list 1) (list 2))) (cons (list 1) (list 3 2))) ;sprawdza czy dodawanie elementow do wieloelementowej kolejki odbywa sie poprawnie
(check-equal? (pop empty-queue) #f) ;sprawdza czy usuwanie elementow z pustej kolejki zwraca blad (#f)
(check-equal? (pop (cons (list 1) (list null))) empty-queue) ;sprawdza czy usuwanie elementow z 1-elementowej kolejki zwraca pusta kolejke
(check-equal? (pop (cons (list 1) (list 2))) (cons (list 2) (list null))) ;sprawdza czy usuwanie elementow z 2-elementowej kolejki odbywa sie poprawnie
(check-equal? (pop (cons (list 1) (list 4 3 2))) (cons (list 2 3) (list 4))) ;sprawdza czy usuwanie elementow z wieloelementowej kolejki odbywa sie poprawnie
