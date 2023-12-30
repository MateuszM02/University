#lang racket
(require racket/trace)
;hash zawierajacy pary "klucz - wartosc" ozaczajace "znak - odpowiednik w alfabecie Morse'a"
(define my-hash (make-hash))

(define (init)
       ;litery
       (hash-set! my-hash #\A "•-")
       (hash-set! my-hash #\B "-•••")
       (hash-set! my-hash #\C "-•-•")
       (hash-set! my-hash #\D "-••")
       (hash-set! my-hash #\E "•")
       (hash-set! my-hash #\F "••-•")
       (hash-set! my-hash #\G "--•")
       (hash-set! my-hash #\H "••••")
       (hash-set! my-hash #\I "••")
       (hash-set! my-hash #\J "•---")
       (hash-set! my-hash #\K "-•-")
       (hash-set! my-hash #\L "•-••")
       (hash-set! my-hash #\M "--")
       (hash-set! my-hash #\N "-•")
       (hash-set! my-hash #\O "---")
       (hash-set! my-hash #\P "•--•")
       (hash-set! my-hash #\Q "--•-")
       (hash-set! my-hash #\R "•-•")
       (hash-set! my-hash #\S "•••")
       (hash-set! my-hash #\T "-")
       (hash-set! my-hash #\U "••-")
       (hash-set! my-hash #\V "•••-")
       (hash-set! my-hash #\W "•--")
       (hash-set! my-hash #\X "-••-")
       (hash-set! my-hash #\Y "-•--")
       (hash-set! my-hash #\Z "--••")
       ;cyfry
       (hash-set! my-hash #\1 "•----")
       (hash-set! my-hash #\2 "••---")
       (hash-set! my-hash #\3 "•••--")
       (hash-set! my-hash #\4 "••••-")
       (hash-set! my-hash #\5 "•••••")
       (hash-set! my-hash #\6 "-••••")
       (hash-set! my-hash #\7 "--•••")
       (hash-set! my-hash #\8 "---••")
       (hash-set! my-hash #\9 "----•")
       (hash-set! my-hash #\0 "-----")
       ;znaki interpunkcyjne
       (hash-set! my-hash #\. "•-•-•-")
       (hash-set! my-hash #\, "--••--")
       (hash-set! my-hash #\' "•----•")
       (hash-set! my-hash #\" "•-••-•")
       (hash-set! my-hash #\_ "••--•-")
       (hash-set! my-hash #\: "---•••")
       (hash-set! my-hash #\; "-•-•-•")
       (hash-set! my-hash #\? "••--••")
       (hash-set! my-hash #\! "-•-•--")
)

;Sposob dzialania funkcji
;Krok 1. Zamienia string opisujacy slowa na liste typu char (na poczatek zmienia wielkosc liter na duze)
;Krok 2. Koduje kazdy char tej listy na string opisujacy znaki alfabetu Morse'a
;Krok 3. Zamienia powstala liste stringow w pojedynczy string

;Sposob dzialania funkcji na przykladzie:
;Wejscie: "MP 2022" <=> Wyjscie: "-- •--•  ••--- ----- ••--- ••---"
;Krok 1. "MP 2022" => (list #\M #\P #\space #\2 #\0 #\2 #\2) gdzie #\space to char okreslajacy spacje
;Krok 2. (list #\M #\P #\space #\2 #\0 #\2 #\2) => (list "--" "•--•" "" "••---" "-----" "••---" "••---") gdzie "" to string okreslajacy spacje
;Krok 3. (list "--" "•--•" "" "••---" "-----" "••---" "••---") => "-- •--•  ••--- ----- ••--- ••---"

;zamienia pojedynczy znak na odpowiadajacy mu ciag w alfabecie Morse'a
(define/contract (koduj hash znak)
  (-> (hash/c  char? string?) char? string?)
  (cond
                    [(equal? znak #\space) ""]
                    [(char-whitespace? znak) " "]
                    [(hash-has-key? hash znak) (hash-ref! hash znak null)]
                    [else (error "Nie ma takiego klucza: " znak)]))

;koduje na alfabet Morse'a
(define/contract (morse-code napis)
  (-> string? string?)
  (init) ;inicjalizuje hash-table
  (set! napis (string->list (string-upcase napis))) ;zamienia na duze litery, a potem na liste znakow typu char
  ;zamienia wszystkie znaki napisu na odpowiadajace ciagi w alfabecie Morse'a
  (define/contract (zamiana s)
  (-> (listof char?) string?)
  (match s
        ['() ""]
        [(cons first rest)
                         (if (null? rest)
                             (string-append (koduj my-hash first) (zamiana rest))
                             (string-append (koduj my-hash first) " " (zamiana rest)))]
        [else (error "Brak kodu")]))
  ;---------------------------------
  (zamiana napis))

;przyklady

(define e1 (morse-code "Metody Programowania"))
(define e2 (morse-code "Alfabet Morse'a"))
(define e3 (morse-code "Parsowanie"))
