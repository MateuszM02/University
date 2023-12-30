#lang plait

;pseudokod algorytmu
;krok 1. zacznij w polu (x,y) na przyklad (0,0)
;krok 2. jesli odwiedzono wszystkie pola, zwroc sciezke pol i zakoncz program
;krok 3. wyznacz liste "xs" pol, na ktore mozesz przejsc z aktualnego pola
;krok 4. jesli xs = empty, zwroc liste pusta, wroc na poprzednie pole i wykonaj dla niego krok 3
;krok 5. wybierz jedno z pol z listy "xs", przejdz na nie i wykonaj dla niego krok 2

;wazne elementy algorytmu
;1. zrobienie listy pol, na ktore da sie przejsc z aktualnego pola (ze wzgledu na sposob poruszania sie skoczka, ma ona max 8 elementow) 
;2. wybranie jednego z tych pol i sprawdzenie, czy mozna na nie pojsc z aktualnego pola
;a) czy dane pole (x,y) jest poprawne? tzn. czy x>=0, y>=0, x<size,y<size
;b) czy dane pole (x,y) zostalo juz odwiedzone? Jesli tak, to nie mozna juz na nie pojsc
;3. alogorytm z nawrotami - jesli 1 rozwiazanie, ktore algorytm wybral okaze sie niepoprawne, to cofnie sie i wybierze kolejne rozwiazanie

;============================================================================================================
;MOZLIWE POLA, NA KTORE SKOCZEK MOZE PRZEJSC W DANYM RUCHU
;============================================================================================================

;typ: (Listof (Number * Number))
(define lista_par
  (list
   [pair -2 1]
   [pair -1 2]
   [pair 1 2]
   [pair 2 1]
   [pair 2 -1]
   [pair 1 -2]
   [pair -1 -2]
   [pair -2 -1]
))

;============================================================================================================
;SPRAWDZANIE, CZY MOZNA PRZEJSC NA DANE POLE
;============================================================================================================

;typ: ((Listof (Number * Number)) (Number * Number) -> Boolean)
(define (odwiedzono? odwiedzone [para : (Number * Number)]) ;sprawdza, czy dane pole zostalo juz odwiedzone
  (cond [(empty? odwiedzone) #f]
        [(equal? (first odwiedzone) para) #t]
        [else (odwiedzono? (rest odwiedzone) para)]
))

;typ: ((Listof (Number * Number)) (Number * Number) Number -> Boolean)
(define (prawidlowe-pole? lista [para : (Number * Number)] size) ;sprawdza, czy skoczek moze przejsc na podane pole w nastepym ruchu
   (cond
        ;lokalizacja pola musi byc nieujemnymi wspolrzednymi mniejszymi od rozmiaru size
        [(or (< (fst para) 0) (>= (fst para) size) (< (snd para) 0) (>= (snd para) size)) #f] 
        [(odwiedzono? lista para) #f] ;jesli odwiedzono pole, to nie mozna zrobic tego ponownie
        [else #t])) ;jesli pole ma wlasciwa lokalizacje i nie zostalo odwiedzone, to skoczek moze je odwiedzic

;============================================================================================================
;SZUKANIE POLA NA KTORE PRZEJDZIEMY W NASTEPNYM RUCHU
;============================================================================================================

;typ: (Number * Number)
     ;(Listof (Number * Number))
     ;((Number * Number) (Number * Number) -> 'a)
     ;-> (Listof 'a)
(define (select-options [akt_pole : (Number * Number)] options options_builder) ;tworzy liste pol, na ktore mozemy przejsc z aktualnego pola
  (type-case (Listof (Number * Number)) options
    [empty empty]
    [(cons head tail)
          (cons (options_builder akt_pole head) (select-options akt_pole tail options_builder))]
))

;typ: ((Listof 'a) ('a -> (Optionof 'b)) -> (Optionof 'b))
(define (wybierz-pierwsze xs proc) ;zwraca 1 pole na liscie na ktore skoczek moze przejsc z aktualnego pola 
  (type-case (Listof 'a) xs
    [empty (none)]
    [(cons head tail)
     (type-case (Optionof 'b) (proc head)
       [(none)   (wybierz-pierwsze tail proc)]
       [(some value) (some value)])]))

;typ: ('a -> (Optionof 'b))
(define (fail cont) (none))

;typ: ('a -> (Optionof 'a))
(define (value->some x) (some x))

;typ: (Number * Number)
     ;((Number * Number) (Number * Number) -> 'a)
     ;('a -> (Optionof 'b))
     ;-> (Optionof 'b)
(define (wybierz-pole akt_pole proc-budowania-opcji proc-poprawnosci-pola) ;zwraca pole, na ktore skoczek przejdzie
  (wybierz-pierwsze (select-options akt_pole lista_par proc-budowania-opcji) proc-poprawnosci-pola))

;============================================================================================================
;WYWOLANIE ALGORYTMU - DZIALA SPRAWNIE I POPRAWNIE DLA n <= 6,
;DLA WIEKSZYCH ROZMIAROW DLUGO LICZY ZE WZGLEDU NA SILNIOWA ZLOZONOSC CZASOWA
;============================================================================================================

;typ: (Number -> (Optionof (Listof (Number * Number))))
(define (skoczek n)
  (local
    [(define (iter odwiedzone aktualne left proc)
       (cond
          [(= left 0) (proc odwiedzone)]
          [else (wybierz-pole
                         aktualne
                         (lambda (pole opcja)
                                 (pair (+ (fst pole) (fst opcja)) (+ (snd pole) (snd opcja))))
                         (lambda (para)
                                 (if (prawidlowe-pole? odwiedzone para n)
                                     (iter (cons para odwiedzone) para (- left 1) proc)
                                     (fail proc)
                         ))
          )]
    ))]
    (if (< n 0)
        (error 'skoczek "niepoprawny rozmiar planszy!")
        (iter (list (pair 0 0)) (pair 0 0) (- (* n n) 1) value->some)
)))

;============================================================================================================
