#lang plait

;zad6

( define-type ( Formula 'v )
( var [ var : 'v ])
( neg [ f : ( Formula 'v ) ])
( conj [ l : ( Formula 'v ) ] [ r : ( Formula 'v ) ])
( disj [ l : ( Formula 'v ) ] [ r : ( Formula 'v ) ]) )

(define (to-nnf arg negate) ;arg to formula, ktora chcemy zapisac w nnf, negate to wartosc boolowska okreslajaca, czy nalezy zanegowac formule (#t - tak, #f - nie)
  (cond [(var? arg)
                   (if (equal? negate #t) ;jesli nalezy zanegowac zmienna
                   [neg arg]
                   arg
        )]
        [(neg? arg)
                   (if (equal? negate #t) ;jesli nalezy zanegowac negacje
                   (to-nnf (neg-f arg) #f) ;zwroc bez negacji (not not p = p)
                   (to-nnf (neg-f arg) #t) ;w p.p. zwroc zanegowana formule
        )]
        [(conj? arg)
                   (if (equal? negate #t) ;jesli nalezy zanegowac koniunkcje
                   [disj (to-nnf [neg [conj-l arg]] #f) (to-nnf [neg [conj-r arg]] #f)] ;zaneguj wg wzoru [not (p and q)] = [(not p) or (not q)] i ustal negate na #f
                   [conj (to-nnf [conj-l arg] negate) (to-nnf [conj-r arg] negate)] ;w p.p. zwroc formule bez negacji
        )]
        [(disj? arg)
                   (if (equal? negate #t)
                   [conj (to-nnf [neg [disj-l arg]] #f) (to-nnf [neg [disj-r arg]] #f)] ;zaneguj wg wzoru [not (p or q)] = [(not p) and (not q)] i ustal negate na #f
                   [disj (to-nnf [disj-l arg] negate) (to-nnf [disj-r arg] negate)] ;w p.p. zwroc formule bez negacji
        )]
))

;testy sprawdzajace poprawnosc funkcji

(define w0 (var 0)) ;p
(to-nnf w0 #f)
(define w1 (neg (var 1))) ;not p
(to-nnf w1 #f)
(define w2 [neg (conj (var 2) (var 12))]) ;not (p and q) = (not p) or (not q)
(to-nnf w2 #f)
(define w3 [neg (conj (var 3) [neg (var 13)])]) ;not (p and (not q)) = (not p) or q
(to-nnf w3 #f)
(define w4 [neg (disj (var 4) [neg (var 14)])]) ;not (p or (not q)) = (not p) and q
(to-nnf w4 #f)
(define w5 [disj (var 5) [neg (var 15)]]) ;p or (not q)
(to-nnf w5 #f)
(define w6 [conj [neg (disj (var 6) (var 16))] [disj (var 26) (var 36)]]) ;[not (a or b)] and (c or d) = [(not a) and (not b)] and (c or d)
(to-nnf w6 #f)
