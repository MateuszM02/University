#lang plait

;przyklad 1

;( curry compose )
;typ: (('_a -> '_b) -> (('_c -> '_a) -> ('_c -> '_b)))

;przede wszystkim, wywolujemy procedure curry z 1 argumentem - procedura compose
;wiemy, ze curry przyjmuje jako argument procedure (A) typu ('a1 'b1 -> 'c1)
;natomiast compose jest typu (('a -> 'b) ('c -> 'a) -> ('c -> 'b))
;zauwazmy, ze (A) przyjmuje 2 argumenty i zwraca 1 argument, tak samo jak compose, wiec ilosc argumentow (przyjmowanych i zwracanych) sie zgadza
;mozna zatem uzyc podstawienia na procedurze curry:
;poczatkowy typ curry: (('a1 'b1 -> 'c1) -> ('a1 -> ('b1 -> 'c1)))
;'a1 = ('a -> 'b)   'b1 = ('c -> 'a)   'c1 = ('c -> 'b)
;wtedy curry ma typ ([('a -> 'b) ('c -> 'a) -> ('c -> 'b)] -> [('a -> 'b) -> {('c -> 'a) -> ('c -> 'b)}])
;uzywajac podstawienia: _a = ('a -> 'b) ('c -> 'a), _b = ('c -> 'b) , _c = ('c -> 'a) ???
;(('a1 'b1 -> 'c1) -> ('a1 -> ('b1 -> 'c1)))
; _a = 'a1 'b1 , _b = 'c1 , _c = 'b1 , _b = 'c1
;(_c -> _a) = 'a1

;przyklad 2

;(( curry compose ) ( curry compose ) )
;typ: (('_a -> ('_b -> '_c)) -> ('_a -> (('_d -> '_b) -> ('_d -> '_c))))

;todo uzasadnienie

;przyklad 3

;(( curry compose ) ( curry apply ) )
;typ: (('_a -> ('_b -> '_c)) -> ('_a -> ('_b -> '_c)))

;todo uzasadnienie

;przyklad 4

;(( curry apply ) ( curry compose ) )
;typ: (('_a -> '_b) -> (('_c -> '_a) -> ('_c -> '_b)))

;todo uzasadnienie

;przyklad 5

;( compose curry flip )
;typ: (('_a '_b -> '_c) -> ('_b -> ('_a -> '_c)))

;todo uzasadnienie
