#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define rocket .)

;zadania 1-4 trywialne

;zadanie 5

(define (zad5 x y z)
  (cond
  [ (and (>= x z) (>= y z) )
  (+ (* x x) (* y y))]
  [ (and (>= x y) (<= y z) )
  (+ (* x x) (* z z))]
  [ (and (<= x y) (<= x z) )
  (+ (* y y) (* z z))]
  )
)

;zadanie 6

(define (zad6 a b)
(( if ( > b 0) + -) a b ) )

;zadanie 7

(define (zad7 war a b)
  [or (and war a) b])

;zadanie 8

(define szer 600)
(define wys 1000)
(define scene1 (empty-scene szer wys))

(define(place_text czas)
  (define text1 (text (number->string czas) (/ wys 10) "black"))
  (place-image text1 (/ szer 2) (* wys (/ 8 9)) scene1))

(define(place_rocket czas)
  (place-image rocket (/ szer 2) (- wys (* czas czas (/ 1 3))) scene1))

(define (zad8 h)
  (if (> h 10) (place_rocket h) (place_text h)))

;(animate zad8)
