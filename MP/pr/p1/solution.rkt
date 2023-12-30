#lang racket

(require rackunit)

(provide (struct-out column-info)
         (struct-out table)
         (struct-out and-f)
         (struct-out or-f)
         (struct-out not-f)
         (struct-out eq-f)
         (struct-out eq2-f)
         (struct-out lt-f)
         table-insert ;ok
         table-project ;ok
         table-sort ;ok
         table-select ;ok
         table-rename ;ok
         table-cross-join ;ok
         table-natural-join) ;ok

(define-struct column-info (name type) #:transparent)

(define-struct table (schema rows) #:transparent)

(define cities
  (table
   (list (column-info 'city    'string)
         (column-info 'country 'string)
         (column-info 'area    'number)
         (column-info 'capital 'boolean))
   (list (list "Wrocław" "Poland"  293 #f)
         (list "Warsaw"  "Poland"  517 #t)
         (list "Poznań"  "Poland"  262 #f)
         (list "Berlin"  "Germany" 892 #t)
         (list "Munich"  "Germany" 310 #f)
         (list "Paris"   "France"  105 #t)
         (list "Rennes"  "France"   50 #f))))

(define countries
  (table
   (list (column-info 'country 'string)
         (column-info 'population 'number))
   (list (list "Poland" 38)
         (list "Germany" 83)
         (list "France" 67)
         (list "Spain" 47))))

(define (empty-table columns) (table columns '()))

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; funkcje ogolne
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define (cinf t) (column-info-name (car t))) ;zwraca nazwe 1 kolumny
(define (citf t) (column-info-type (car t))) ;zwraca typ 1 kolumny

(define (list-begin lista elem) ;dolaczanie elementu na poczatek listy
  (cond [(null? elem) lista]
        [(null? lista) (list elem)]
        [else (cons elem lista)]
))

(define (list-end lista elem) ;dolaczanie elementu na koniec listy
  (cond [(null? elem) lista]
        [(null? lista) (list elem)]
        [(cons (car lista) (list-end (cdr lista) elem))]
))

(define (my-append xs ys) ;polaczenie 2 list
  [if(null? xs) ys
  (cons (car xs) [my-append (cdr xs) ys])])

(define (GetSchemaNames arg) ;zwraca nazwy kolumn tabeli
  (cond [(table? arg) (GetSchemaNames (table-schema arg))]
        [(list? arg) (map (lambda (name) (column-info-name name)) arg)]
        [else error]))

(define (GetValuesAtIndexes lista_wartosci lista_indeksow) ;zwraca wartosci listy na podanych indeksach w kolejnosci ich wystepowania
  (cond [(null? lista_wartosci) null]
        [(null? lista_indeksow) null]
        [else (list-begin [GetValuesAtIndexes lista_wartosci (cdr lista_indeksow)] [list-ref lista_wartosci (car lista_indeksow)])]
))

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-insert OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define (CzyTenSamTyp wartosc symbol) ;zwraca #t jesli elementy sa tego samego typu lub #f w p.p.
  (cond [(number? wartosc) (equal? symbol 'number)]
        [(string? wartosc) (equal? symbol 'string)]
        [(symbol? wartosc) (equal? symbol 'symbol)]
        [(boolean? wartosc) (equal? symbol 'boolean)]
        [else #f]))

(define (CzyDobreTypy rzad schematy_tabeli) ;zwraca #t jesli rzad ma wszystkie kolumny tego samego typu co dana tabela lub #f w p.p.
  (cond [(null? rzad) #t]
        [(CzyTenSamTyp (car rzad) (citf schematy_tabeli)) (CzyDobreTypy (cdr rzad) (cdr schematy_tabeli))]
        [else #f]))

(define (table-insert row tab)
  (cond [(not (list? row)) error] ;wiersze tabeli musza byc listami
        [(not (equal? [length row] [length (table-schema tab)])) error] ;ilosc kolumn rzedu musi byc taka sama jak tabeli
        [(not [CzyDobreTypy row (table-schema tab)]) error] ;typ kazdej kolumny rzedu musi byc taki sam jak tabeli
        [else (cons row (table-rows tab))] ;jesli wszystkie powyzsze warunki sa spelnione, to mozna rzad dodac do tabeli
))

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-project OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         
(define (ListaKolumn cols tab) ;zwraca liste indeksow, ktorej elementami sa indeksy podanych nazw kolumn tabeli
        (define SchemaNames (GetSchemaNames tab)) ;lista nazw kolumn
        (define ListaIndeksow (filter-map [lambda (nazwa) (index-of SchemaNames nazwa)] cols))
ListaIndeksow)

(define (NowaTabela tab lista_indeksow) ;zwraca tabele tylko z kolumnami o podanych indeksach
  (table
   (GetValuesAtIndexes (table-schema tab) lista_indeksow) ;table-schema
   (filter-map ;table-rows
             (lambda (x) (and (not (equal? x null)) x))
             (map (lambda (rzad) [GetValuesAtIndexes rzad lista_indeksow]) (table-rows tab)))
 ))

(define (table-project cols tab)
  (define indeksy_kolumn (ListaKolumn cols tab)) ;lista indeksow kolumn, ktore mamy wypisac
  (NowaTabela tab indeksy_kolumn))

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-sort OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define (DwieListy tablica xs ys) ;dzieli liste na 2 prawie-rowne podlisty (tzn |dl(xs) - dl(ys)| <= 1)
    (cond [(null? tablica) (list xs ys)]
          [(null? (cdr tablica)) (list [list-end xs (car tablica)] ys)]
          [(null? (cddr tablica)) (list [list-end xs (car tablica)] [list-end ys (cadr tablica)])]
          [else (DwieListy (cddr tablica) [list-end xs (car tablica)] [list-end ys (cadr tablica)])]
  ))

;zwraca #t jesli a < b lub #f dla a > b; dla a = b sprawdza nastepny element klucza sortowania; jesli klucz jest pusty, nie zmieniamy kolejnosci - sortowanie stabilne
(define (warunek a b kol_sortujace)
  (define (CzySpelnione x y kolumna)
    (cond
      [{or (null? x) (null? y)} #t]
      [(number? (list-ref x kolumna)) ;ok
          (cond
            [(< (list-ref x kolumna) (list-ref y kolumna)) #t]
            [(> (list-ref x kolumna) (list-ref y kolumna)) #f]
            [else "brak"])]
      [(string? (list-ref x kolumna)) ;ok
           (cond
             [(string<? (list-ref x kolumna) (list-ref y kolumna)) #t]
             [(string>? (list-ref x kolumna) (list-ref y kolumna)) #f]
             [else "brak"])]
      [(boolean? (list-ref x kolumna)) ;ok
           (cond
             [{and [equal? (list-ref x kolumna) #t] [equal? (list-ref y kolumna) #f]} #t]
             [{and [equal? (list-ref x kolumna) #f] [equal? (list-ref y kolumna) #t]} #f]
             [else "brak"])]
      [(symbol? (list-ref x kolumna)) ;ok
           (cond
             [(symbol<? (list-ref x kolumna) (list-ref y kolumna)) #t]
             [(symbol<? (list-ref x kolumna) (list-ref y kolumna)) #f]
             [else "brak"])]
      [else error]
  ))
  ;warunek
    (cond [(null? kol_sortujace) #t] ;zakladamy, ze jesli skonczyly sie kryteria sortowania (np. dlatego, ze argumenty byly rowne dla poprzednich kryteriow) to nie zmieniamy kolejnosci - sortowanie stabilne
          [else
               (define wynik [CzySpelnione a b (car kol_sortujace)]) ;zwraca #t dla a < b, #f dla a > b i "brak" (rozstrzygniecia) dla a = b - wtedy nalezy porownac a,b kolejnym elementem klucza
               (if (equal? wynik "brak") ;dla a = b wg aktualnego klucza
                   (warunek a b (cdr kol_sortujace)) ;sprawdzamy a =? b dla nastepnego elementu klucza
                    wynik)] ;dla a!= b zwracamy #t lub #f
  ))

(define (Polacz tablica xs ys kol) ;łączy dwie posortowane listy
    (cond [(null? xs) (my-append tablica ys)]
          [(null? ys) (my-append tablica xs)]
          [(warunek (car xs) (car ys) kol) (Polacz [list-end tablica (car xs)] (cdr xs) ys kol)] ;jesli (first xs) <= (first ys) to dolacz (first xs) do listy wynikowej
          [else (Polacz [list-end tablica (car ys)] xs (cdr ys) kol)])) ;w p.p. dolacz (first ys) do listy wynikowej
;---
(define (MergeSort kol_sortujace tab) ;sortuje wiersze tabeli algorytmem merge-sort
        (define dwa (DwieListy tab null null)) ;wiersze tabeli podzielone na 2 prawie-rowne podlisty (tzn |dl(xs) - dl(ys)| <= 1)
        (cond [(<= (length tab) 1) tab] ;lista 1-elementowa jest zawsze posortowana
              [else
                   (Polacz null [MergeSort kol_sortujace (car dwa)] ;rekurencyjnie wywoluje sie dla obu podlist, po czym laczy otrzymane posortowane listy
                                [MergeSort kol_sortujace (cadr dwa)]
                                kol_sortujace)]
  ))

(define (table-sort cols tab) ;sortuje algorytmem merge-sort
  [table (table-schema tab) (MergeSort (ListaKolumn cols tab) (table-rows tab))])

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-select OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define-struct and-f (l r)) ;koniunkcja
(define-struct or-f (l r)) ;alternatywa
(define-struct not-f (e)) ;negacja
(define-struct eq-f (name val)) ;sprawdza rownosc z podana nazwa
(define-struct eq2-f (name name2)) ;sprawdza rownosc 2 nazw
(define-struct lt-f (name val)) ;sprawdza, czy wartość kolumny name mniejsza niż val

(define (table-select form tab)
  ;zwraca #t gdy eqVal to wartosc kolumny o nazwie eqName lub #f w p.p.
  (define (czy-rowne eqName eqVal rzad tab)
    (cond [(null? rzad) #f]
          [(equal? (cinf tab) eqName) (equal? eqVal (car rzad))]
          [else (czy-rowne eqName eqVal (cdr rzad) (cdr tab))]
  ))
  ;zwraca pare (x1,x2) gdzie x1 to wartosc kolumny o nazwie eqName1, a x1 -||- eqName2
  (define (czy-rowne2 eqName1 eqName2 rzad tab wynik)
    (cond [(null? rzad) (cons #f #f)]
          [(equal? (cinf tab) eqName1) (cons (car rzad) (cdr wynik))]
          [(equal? (cinf tab) eqName2) (cons (car wynik) (car rzad))]
          [else (czy-rowne2 eqName1 eqName2 (cdr rzad) (cdr tab) wynik)]
  ))
  ;zwraca #t gdy wartosc kolumny o nazwie ltName jest mniejsza niz ltVal lub #f w p.p.
  (define (czy-mniejsza ltName ltVal rzad tab)
    (cond [(null? rzad) #f]
          [(equal? (cinf tab) ltName) (< (car rzad) ltVal)]
          [else (czy-mniejsza ltName ltVal (cdr rzad) (cdr tab))]
  ))
  ;zwraca #t gdy warunek form jest spelniony dla podanego rzedu row lub #f w p.p.
  (define (CzyWarunekSpelniony warunek1 rzad tab)
    (cond [(and-f? warunek1) (and [CzyWarunekSpelniony (and-f-l warunek1) rzad tab] [CzyWarunekSpelniony (and-f-r warunek1) rzad tab])]
          [(or-f? warunek1) (or [CzyWarunekSpelniony (or-f-l warunek1) rzad tab] [CzyWarunekSpelniony (or-f-r warunek1) rzad tab])]
          [(not-f? warunek1) (not [CzyWarunekSpelniony (not-f-e warunek1) rzad tab])]
          [(eq-f? warunek1) (czy-rowne (eq-f-name warunek1) (eq-f-val warunek1) rzad tab)]
          [(eq2-f? warunek1)
           (define para [czy-rowne2 (eq2-f-name warunek1) (eq2-f-name2 warunek1) rzad tab (cons null null)])
           (equal? (car para) (cdr para))]
          [(lt-f? warunek1) (czy-mniejsza (lt-f-name warunek1) (lt-f-val warunek1) rzad tab)]))
  ;zwraca tylko te rzedy, ktore spelniaja podany warunek
  (define (Filtr warunek rzedy tab)
    (cond [(null? rzedy) null]
          [(CzyWarunekSpelniony warunek (car rzedy) (table-schema tab)) (cons (car rzedy) (Filtr warunek (cdr rzedy) tab))]
          [else (Filtr warunek (cdr rzedy) tab)]
  ))
  ;---
  (table
   (table-schema tab)
   (Filtr form (table-rows tab) tab)))

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-rename OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define (table-rename col ncol tab)
  [table
        [map ;dla kazdego rzedu tabeli
             (lambda (rzad)
                          (if (equal? (column-info-name rzad) col) ;jesli rzad ma szukana nazwe
                              (column-info ncol (column-info-type rzad)) ;to ja zamien na nowa nazwe
                              rzad)) ;w p.p. zostaw obecna nazwe
             (table-schema tab)] ;kolumny tabeli sie nie zmieniaja
        [table-rows tab]
   ])

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-cross-join OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define (table-cross-join tab1 tab2)
  (table
        [my-append (table-schema tab1) (table-schema tab2)] ;laczy kolumny tabel
        [map flatten (cartesian-product (table-rows tab1) (table-rows tab2))] ;laczy wiersze tab1 i tab2
))

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; table-natural-join OK
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(define (GdzieWystepuje nazwa lista_nazw indeks) ;zwraca -1 jesli nazwa nie wystepuje na liscie lub indeks, na ktorym wystepuje
  (cond [(null? lista_nazw) -1]
        [(equal? nazwa (car lista_nazw)) indeks]
        [else (GdzieWystepuje nazwa (cdr lista_nazw) (+ indeks 1))]))

(define (PodajPary lista indeks) ;zwraca liste par (list (a1 . b1) (a2 . b2) ...) gdzie kazda para (a . b) oznacza, ze kolumny a,b maja takie same nazwy w danej tabeli
  (cond [(null? lista) null]
        [(>= (car lista) 0) [list-begin [PodajPary (cdr lista) (+ indeks 1)] (cons indeks (car lista))]]
        [else [PodajPary (cdr lista) (+ indeks 1)]]))

(define (ZmienNazwy lista_nazw lista_indeksow indeks) ;zmienia nazwy zduplikowanych kolumn na 'duplikat, zeby pozniej latwiej bylo taka kolumne usunac
 (cond [(null? lista_nazw) null]
       [(null? lista_indeksow) lista_nazw]
       [(= indeks (car lista_indeksow)) (list-begin [ZmienNazwy (cdr lista_nazw) (cdr lista_indeksow) (+ indeks 1)] 'duplikat)]
       [else (list-begin [ZmienNazwy (cdr lista_nazw) lista_indeksow (+ indeks 1)] (car lista_nazw))]))

(define (table-natural-join tab1 tab2)
(define NazwyKolumny1 (GetSchemaNames tab1)) ;lista nazw kolumn tab1
(define NazwyKolumny2 (GetSchemaNames tab2)) ;lista nazw kolumn tab2
(define ListaWystapien1w2 [map (lambda (x) [GdzieWystepuje x NazwyKolumny2 0]) NazwyKolumny1]) ;lista indeksow, na ktorych nazwy kolumn tab1 wystepuja w liscie nazw kolumn tab2
(define ListaDuplikatow (PodajPary ListaWystapien1w2 0)) ;lista par (list (x1 . y1) (x2 . y2) ...) takich, ze x1-ta nazwa kolumny tab1 jest rowna y1-tej nazwie kolumny tab2

(define NazwyKolumny2BezPowtorek [ZmienNazwy NazwyKolumny2 [sort (filter (lambda (x) (not (negative? x))) ListaWystapien1w2) <] 0]) ;lista nazw kolumn tabeli tab2 bez kolumn zduplikowanych
(define new_tab1 [table ;tab1 ze zmienionymi nazwami kolumn
                        [build-list (length NazwyKolumny1)
                                    (lambda (row) [column-info (list-ref NazwyKolumny1 row) (column-info-type (list-ref (table-schema tab1) row))])]
                        (table-rows tab1)])
(define new_tab2 [table ;tab2 ze zmienionymi nazwami kolumn
                        [build-list (length NazwyKolumny2BezPowtorek)
                                    (lambda (row) [column-info (list-ref NazwyKolumny2BezPowtorek row) (column-info-type (list-ref (table-schema tab2) row))])]
                        (table-rows tab2)])
(define Tab (table-cross-join new_tab1 new_tab2)) ;tabela po zlaczeniu kartezjanskim 2 tabel
(define ListaKolumnDoUsuniecia ;lista par (list (y1. x1) (y2 . x2) ...) takich, ze y1-ta nazwa kolumny Tab jest rowna x1-tej nazwie kolumny Tab (po wykonaniu cross-join)
                        [map [lambda (x) [cons (car x) (+ (cdr x) (length NazwyKolumny1))]] ListaDuplikatow])

(define (FiltrujTabele wiersze_tabeli) ;zwraca przefiltrowana liste wierszy tabeli
  (define (FiltrujWiersz elem) ;zwraca wiersz tabeli
      [flatten (filter-map (lambda (para) ;para to (a1 . b1) taka, ze kolumny a1,b1 maja takie same nazwy; jesli a1(value) = a2(value) to rzad pozostanie w tabeli, w p.p. zostanie z niej usuniety 
                             (if [equal? (list-ref elem (car para)) (list-ref elem (cdr para))] elem #f)) ListaKolumnDoUsuniecia)])
(map [lambda (grupa) (FiltrujWiersz grupa)] wiersze_tabeli)) ;dla kazdego wiersza (a1 b1) ..., filtruj
  
(define FiltrowanaTabela [table (table-schema Tab) (FiltrujTabele (table-rows Tab))]) ;tabela po wykonaniu 3 kroku z polecenia table-natural-join
(define FiltrowaneNazwy (filter (lambda (name) [not (equal? name 'duplikat)]) (GetSchemaNames Tab))) ;lista nazw kolumn, ktore sie nie powtarzaja
(define PolaczonaTabela (table-project FiltrowaneNazwy FiltrowanaTabela)) ;4 krok polecenia table-natural-join

  [table
   (table-schema PolaczonaTabela)
   (remove-duplicates (table-rows PolaczonaTabela))]) ;remove-duplicates na wypadek, gdyby tab1 = tab2, wtedy chcemy zwrocic oryginalna tabele



;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;niezmienniki programu
;program sie nie kompiluje, jesli ktorykolwiek z nich jest niespelniony
;program zdaje wszystkie ponizsze testy, co pokazuje jego poprawnosc dzialania
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;funkcja table-insert

(check-equal? [table-insert (list 2) cities] error) ;error, bo list 2 nie jest tablica

(check-equal? [table-insert (list-ref (table-rows cities) 2) cities]
 '(("Poznań" "Poland" 262 #f)
  ("Wrocław" "Poland" 293 #f)
  ("Warsaw" "Poland" 517 #t)
  ("Poznań" "Poland" 262 #f)
  ("Berlin" "Germany" 892 #t)
  ("Munich" "Germany" 310 #f)
  ("Paris" "France" 105 #t)
  ("Rennes" "France" 50 #f))) ;ok

(check-equal? [table-insert (list-ref (table-rows countries) 0) countries]
 '(("Poland" 38) ("Poland" 38) ("Germany" 83) ("France" 67) ("Spain" 47))) ;ok

(check-equal? [table-insert (list-ref (table-rows countries) 0) cities] error) ;error, bo nie mozna wstawic elementu typu countries do tablicy typu cities

;funkcja table-rename

(check-equal? (table-rename 'city 'name cities)
(table   (list (column-info 'name 'string) ;zmiana nazwy
         (column-info 'country 'string)
         (column-info 'area    'number)
         (column-info 'capital 'boolean))
(table-rows cities)))

(check-equal? (table-rename 'country 'panstwo cities)
(table   (list (column-info 'city 'string)
         (column-info 'panstwo 'string) ;zmiana nazwy
         (column-info 'area    'number)
         (column-info 'capital 'boolean))
(table-rows cities)))

(check-equal? (table-rename 'population 'count countries)
(table   (list (column-info 'country 'string)
         (column-info 'count 'number)) ;zmiana nazwy
(table-rows countries)))

;funkcja table-project

(check-equal?
 (table-project '(nie_ma_takiej_kolumny) cities)
 [table null null])

(check-equal?
 (table-project '(country capital) cities)
 [table
  (list (column-info 'country 'string) (column-info 'capital 'boolean))
     '(("Poland" #f)
       ("Poland" #t)
       ("Poland" #f)
       ("Germany" #t)
       ("Germany" #f)
       ("France" #t)
       ("France" #f)
  )])

(check-equal?
 (table-project '(capital country) cities) ;zmieniona kolejnosc sortowania wzgledem poprzedniego testu 
 [table
  (list (column-info 'capital 'boolean) (column-info 'country 'string))
     '((#f "Poland")
       (#t "Poland")
       (#f "Poland")
       (#t "Germany")
       (#f "Germany")
       (#t "France")
       (#f "France")
  )])

(check-equal?
 (table-project '(population) countries)
 [table
  (list (column-info 'population 'number))
  (list '(38) '(83) '(67) '(47))
 ])

;funkcja table-sort

(check-equal?
 (table-sort '(country) countries)
 (table
  (table-schema countries)
 (list (list "France" 67)
       (list "Germany" 83)
       (list "Poland" 38)
       (list "Spain" 47))))

(check-equal?
 (table-sort '(population) countries)
 (table
  (table-schema countries)
 (list (list "Poland" 38)
       (list "Spain" 47)
       (list "France" 67)
       (list "Germany" 83))))

(check-equal?
 (table-sort '(country area) cities)
 (table
       (table-schema cities)
       (list (list "Rennes"  "France"   50 #f)
             (list "Paris"   "France"  105 #t) ;ten sam kraj co "Rennes" wiec kryterium sortowania jest area
             (list "Munich"  "Germany" 310 #f)
             (list "Berlin"  "Germany" 892 #t) ;jw
             (list "Poznań"  "Poland"  262 #f)
             (list "Wrocław" "Poland"  293 #f) ;jw
             (list "Warsaw"  "Poland"  517 #t) ;jw
 )))

(check-equal?
 (table-sort '(country city) cities)
 (table
       (table-schema cities)
       (list (list "Paris"   "France"  105 #t)
             (list "Rennes"  "France"   50 #f)
             (list "Berlin"  "Germany" 892 #t)
             (list "Munich"  "Germany" 310 #f)
             (list "Poznań"  "Poland"  262 #f)
             (list "Warsaw"  "Poland"  517 #t)
             (list "Wrocław" "Poland"  293 #f)
 )))

; funkcja table-cross-join

(check-equal?
 (table-cross-join countries cities)
 (table
 (list
  (column-info 'country 'string)
  (column-info 'population 'number)
  (column-info 'city 'string)
  (column-info 'country 'string)
  (column-info 'area 'number)
  (column-info 'capital 'boolean))
 '(("Poland" 38 "Wrocław" "Poland" 293 #f)
    ("Poland" 38 "Warsaw" "Poland" 517 #t)
    ("Poland" 38 "Poznań" "Poland" 262 #f)
    ("Poland" 38 "Berlin" "Germany" 892 #t)
    ("Poland" 38 "Munich" "Germany" 310 #f)
    ("Poland" 38 "Paris" "France" 105 #t)
    ("Poland" 38 "Rennes" "France" 50 #f)
    ("Germany" 83 "Wrocław" "Poland" 293 #f)
    ("Germany" 83 "Warsaw" "Poland" 517 #t)
    ("Germany" 83 "Poznań" "Poland" 262 #f)
    ("Germany" 83 "Berlin" "Germany" 892 #t)
    ("Germany" 83 "Munich" "Germany" 310 #f)
    ("Germany" 83 "Paris" "France" 105 #t)
    ("Germany" 83 "Rennes" "France" 50 #f)
    ("France" 67 "Wrocław" "Poland" 293 #f)
    ("France" 67 "Warsaw" "Poland" 517 #t)
    ("France" 67 "Poznań" "Poland" 262 #f)
    ("France" 67 "Berlin" "Germany" 892 #t)
    ("France" 67 "Munich" "Germany" 310 #f)
    ("France" 67 "Paris" "France" 105 #t)
    ("France" 67 "Rennes" "France" 50 #f)
    ("Spain" 47 "Wrocław" "Poland" 293 #f)
    ("Spain" 47 "Warsaw" "Poland" 517 #t)
    ("Spain" 47 "Poznań" "Poland" 262 #f)
    ("Spain" 47 "Berlin" "Germany" 892 #t)
    ("Spain" 47 "Munich" "Germany" 310 #f)
    ("Spain" 47 "Paris" "France" 105 #t)
    ("Spain" 47 "Rennes" "France" 50 #f))))

;funkcja table-select

(check-equal? ;zwraca wszystkie stolice z wartoscia area ponizej 300
  [table-rows (table-select (and-f (eq-f 'capital #t) (not-f (lt-f 'area 300))) cities)]
  [list (list "Warsaw" "Poland" 517 #t) (list "Berlin" "Germany" 892 #t)])

(check-equal? ;zamieniona kolejnosc warunkow poprzedniego
  [table-rows (table-select (and-f (not-f (lt-f 'area 300)) (eq-f 'capital #t)) cities)]
  [list (list "Warsaw" "Poland" 517 #t) (list "Berlin" "Germany" 892 #t)])

(check-equal? ;
  [table-rows (table-select (not-f (lt-f 'population 50)) countries)]
  [list (list "Germany" 83) (list "France" 67)])

(check-equal? ;zwraca te rzedy, ktore sa albo stolica, albo z Francji
  [table-rows (table-select (or-f (eq-f 'country "France") (eq-f 'capital #t)) cities)]
  [list  (list "Warsaw"  "Poland"  517 #t)
         (list "Berlin"  "Germany" 892 #t)
         (list "Paris"   "France"  105 #t)
         (list "Rennes"  "France"   50 #f)])

(check-equal? ;warunek niemozliwy do spelnienia - zadne miasto nie jest jednoczesnie stolica i nie-stolica
  [table-rows (table-select (and-f (eq-f 'capital #f) (eq-f 'capital #t)) cities)]
  null)

;funkjca table-natural-join

(check-equal?
  (table-natural-join cities countries) ;polaczenie tabel cities countries ma zwrocic tabele cities poszerzona o kolumne 'population z tabeli countries
  (table
 (list (column-info 'city 'string) (column-info 'country 'string) (column-info 'area 'number) (column-info 'capital 'boolean) (column-info 'population 'number))
 '(("Wrocław" "Poland" 293 #f 38)
   ("Warsaw" "Poland" 517 #t 38)
   ("Poznań" "Poland" 262 #f 38)
   ("Berlin" "Germany" 892 #t 83)
   ("Munich" "Germany" 310 #f 83)
   ("Paris" "France" 105 #t 67)
   ("Rennes" "France" 50 #f 67))))

(check-equal?
  (table-natural-join countries cities) ;polaczenie tabel countries cities ma zwrocic tabele countries poszerzona o kolumny '(city area capital) z tabeli cities
  (table
 (list (column-info 'country 'string)
       (column-info 'population 'number)
       (column-info 'city    'string)
       (column-info 'area    'number)
       (column-info 'capital 'boolean))
     '(("Poland" 38 "Wrocław" 293 #f)
       ("Poland" 38 "Warsaw" 517 #t)
       ("Poland" 38 "Poznań" 262 #f)
       ("Germany" 83 "Berlin" 892 #t)
       ("Germany" 83 "Munich" 310 #f)
       ("France" 67 "Paris" 105 #t)
       ("France" 67 "Rennes" 50 #f))))

(check-equal?
  (table-natural-join cities cities) ;polaczenie 2 takich samych tabel ma zwrocic oryginalna tabele
  (table
 (list (column-info 'city 'string) (column-info 'country 'string) (column-info 'area 'number) (column-info 'capital 'boolean))
 '(("Wrocław" "Poland" 293 #f)
   ("Warsaw" "Poland" 517 #t)
   ("Poznań" "Poland" 262 #f)
   ("Berlin" "Germany" 892 #t)
   ("Munich" "Germany" 310 #f)
   ("Paris" "France" 105 #t)
   ("Rennes" "France" 50 #f))))
