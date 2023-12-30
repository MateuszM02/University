#lang racket

;hash zawierajacy pary "klucz - wartosc" oznaczajace "ciag w alfabecie Morse'a - odpowiednik w alfabecie"
(define my-hash (make-hash))

(define (init)
       ;litery
       (hash-set! my-hash "•-" #\A)
       (hash-set! my-hash "-•••" #\B)
       (hash-set! my-hash "-•-•" #\C)
       (hash-set! my-hash "-••" #\D)
       (hash-set! my-hash "•" #\E)
       (hash-set! my-hash "••-•" #\F)
       (hash-set! my-hash "--•" #\G)
       (hash-set! my-hash "••••" #\H)
       (hash-set! my-hash "••" #\I)
       (hash-set! my-hash "•---" #\J)
       (hash-set! my-hash "-•-" #\K)
       (hash-set! my-hash "•-••" #\L)
       (hash-set! my-hash "--" #\M)
       (hash-set! my-hash "-•" #\N)
       (hash-set! my-hash "---" #\O)
       (hash-set! my-hash "•--•" #\P)
       (hash-set! my-hash "--•-" #\Q)
       (hash-set! my-hash "•-•" #\R)
       (hash-set! my-hash "•••" #\S)
       (hash-set! my-hash "-" #\T)
       (hash-set! my-hash "••-" #\U)
       (hash-set! my-hash "•••-" #\V)
       (hash-set! my-hash "•--" #\W)
       (hash-set! my-hash "-••-" #\X)
       (hash-set! my-hash "-•--" #\Y)
       (hash-set! my-hash "--••" #\Z)
       ;cyfry
       (hash-set! my-hash "•----" #\1)
       (hash-set! my-hash "••---" #\2)
       (hash-set! my-hash "•••--" #\3)
       (hash-set! my-hash "••••-" #\4)
       (hash-set! my-hash "•••••" #\5)
       (hash-set! my-hash "-••••" #\6)
       (hash-set! my-hash "--•••" #\7)
       (hash-set! my-hash "---••" #\8)
       (hash-set! my-hash "----•" #\9)
       (hash-set! my-hash "-----" #\0)
       ;znaki interpunkcyjne
       (hash-set! my-hash "•-•-•-" #\.)
       (hash-set! my-hash "--••--" #\,)
       (hash-set! my-hash "•----•" #\')
       (hash-set! my-hash "•-••-•" #\")
       (hash-set! my-hash "••--•-" #\_)
       (hash-set! my-hash "---•••" #\:)
       (hash-set! my-hash "-•-•-•" #\;)
       (hash-set! my-hash "••--••" #\?)
       (hash-set! my-hash "-•-•--" #\!)
)

;Sposob dzialania funkcji
;Krok 1. Zamienia string opisujacy slowa alfabetu Morse'a na liste stringow, gdzie kazdy nowo utworzony string jest pojedynczym slowem lub spacja
;Krok 2. Dekoduje kazdy string tej listy z alfabetu Morse'a na char opisujacy zwykle znaki alfabetu
;Krok 3. Zamienia powstala liste char na string

;Sposob dzialania funkcji na przykladzie:
;Wejscie: "-- •--•  ••--- ----- ••--- ••---" <=> Wyjscie: "MP 2022"
;Krok 1. "-- •--•  ••--- ----- ••--- ••---" => (list "--" "•--•" "" "••---" "-----" "••---" "••---") gdzie "" to spacja
;Krok 2. (list "--" "•--•" "" "••---" "-----" "••---" "••---") => (list #\M #\P #\space #\2 #\0 #\2 #\2)
;Krok 3. (list #\M #\P #\space #\2 #\0 #\2 #\2) => "MP 2022"

;zamienia string opisujacy pojedynczy ciag w alfabecie Morse'a na odpowiadajacy mu znak w alfabecie
(define/contract (dekoduj hash ciag)
  (-> (hash/c string? char?) string? char?)
  (cond
                    [(equal? ciag "") #\space]
                    [(hash-has-key? hash ciag) (hash-ref! hash ciag null)]
                    [else (error "Nie ma takiego kodu: " ciag)]))

;dekoduje z alfabetu Morse'a na alfabet
(define/contract (morse-decode napis)
  (-> string? string?)
  (init)
  (set! napis (regexp-split #rx" " napis)) ;dzieli napis na liste pod-napisow (jesli napis zawieral spacje, to zostanie ona zapisana jako "")
  ;-------------------------------------------------------------------------------------
  ;zamienia liste znakow w alfabecie Morse'a na liste odpowiadajacych znakow w alfabecie
  (define/contract (zamiana s)
  (-> (listof string?) (listof char?))
  (match s
        ['() null]
        [(cons first rest) (cons (dekoduj my-hash first) (zamiana rest))]
        [else (error "Brak kodu")]))
  ;-------------------------------------------------------------------------------------
  (list->string (zamiana napis)))

;przyklady

(define e1 (morse-decode "-- •--•  ••--- ----- ••--- ••---")); "MP 2022"
(define e2 (morse-decode "•- •-•• ••-• •- -••• • -  -- --- •-• ••• • •----• •-")) ;"Alfabet Morse'a"
(define e3 (morse-decode "•--• •- •-• ••• --- •-- •- -• •• •")) ;"Parsowanie"
