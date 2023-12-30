#lang plait

;typ

( define-type Prop
( var [ v : String ])
( conj [ l : Prop ] [ r : Prop ])
( disj [ l : Prop ] [ r : Prop ])
( neg [ f : Prop ]) )

;rozwiazanie zadania 7

(define (remove-duplicates lst)
  (foldr (lambda (x y) (cons x (filter (lambda (z) (not (string=? x z))) y))) empty lst))

(define (accumulate-vars t)
  (cond
    [(var? t) (cons (var-v t) empty)]
    [(neg? t) (accumulate-vars (neg-f t))]
    [(conj? t) (append (accumulate-vars (conj-l t)) (accumulate-vars (conj-r t)))]
    [(disj? t) (append (accumulate-vars (disj-l t)) (accumulate-vars (disj-r t)))]))

(define (free-vars t)
  (remove-duplicates (accumulate-vars t)))

;rozwiazanie zadania 8

(define (eval val p)
           (cond [(var? p) (some-v (hash-ref val (var-v p)))]
                 [(conj? p) (and (eval val (conj-l p))(eval val (conj-r p)))]
                 [(disj? p) (or (eval val (disj-l p))(eval val (disj-r p)))]
                 [(neg? p) (not (eval val (neg-f p)))]))

(define proc (neg (conj (var "a") (disj (var "b") (neg (conj (var "a") (var "c")))))))
(define val (make-hash (list (pair "a" #t)(pair "b" #f)(pair "c" #f))))
(eval val proc)

;rozwiazanie zadania 9

(define (merge xs ys)
  (cond
    [(empty? ys) xs]
    [(in? (first ys) xs) (merge xs (rest ys))]
    [else (merge (cons (first ys) xs) (rest ys))]
  )
)

; Generujemy wszystkie ciagi 0-1
(define (f pref n)
  (if (= n 0)
      (list pref)
      (append (f [append pref '(#t)] (- n 1)) (f [append pref '(#f)] (- n 1)))))

(define (seq-01 n)
  (f '() n))


; uwaga - łączone listy muszą być tej samej długości
; scala liste nazw zmiennych z lista wartosci, aby
; wrzucic pary (zmienna, wartosc) do slownika i wywolac eval
(define (join-lists lst1 lst2)
  (if (empty? lst1)
      empty
      (cons (pair [first lst1] [first lst2]) (join-lists [rest lst1] [rest lst2]))))


(define (tautology? form)
  (local ( [define form-vars (free-vars form)]
           [define all-evals (seq-01 (length form-vars))]
           [define (check-all-evals form evals)
             (if (empty? evals)
                 #t
                (and [eval (hash (join-lists form-vars [first evals])) form] [check-all-evals form (rest evals)]))])
           
   (check-all-evals form all-evals)))



; formula     (q or r) and (p and !q)
(define formula (conj (disj [var "q"] [var "r"]) (conj [var "p"] [neg(var "q")])))

; p v !p
(define formula2 (disj [var "q"] [neg [var "q"]]))

; (p and q) or (!p or !q)
(define formula3 (disj [conj (var "p") (var "q")] [disj [neg (var "p")] [neg (var "q")]]))

(tautology? formula)
(tautology? formula2)
(tautology? formula3)
