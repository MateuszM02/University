#lang racket
(require rackunit)

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

( define t
( node
  [ node ( leaf ) 2 ( leaf ) ]
  5
  [ node 
         ( node ( leaf ) 6 ( leaf ) )
         8
         ( node (leaf) 9 ( leaf ) ) ]
) )

;zad6

(define (delete x t)
  (cond [(leaf? t) t]
        [(node? t)
         (cond [(= x (node-elem t)) ;w przypadku usuwania wartosci z aktualnego wezla
                {cond [(and (leaf? (node-r t)) (leaf? (node-l t))) (leaf)] ;jesli wezel nie ma poddrzew, zwroc lisc
                      [(leaf? (node-r t)) (node-l t)] ;jesli wezel ma tylko lewe poddrzewo, zwroc je
                      [(leaf? (node-l t)) (node-r t)] ;jesli wezel ma tylko prawe poddrzewo, zwroc je
                      [else (node ;;jesli wezel ma oba poddrzewa, wywolaj rekurencje
                                 (delete (node-elem (node-l t)) (node-l t))
                                 (node-elem (node-l t))
                                 (node-r t)
                      )]}]
               [(< x (node-elem t)) (node (delete x (node-l t)) (node-elem t) (node-r t))] ;w przypadku usuwania wartosci z lewego poddrzewa
               [(> x (node-elem t)) (node (node-l t) (node-elem t) (delete x (node-r t)))] ;w przypadku usuwania wartosci z prawego poddrzewa
               [else #f])]
        [else #f]
))

;niezmienniki programu
(check-equal? (delete 2 t) ;przypadek gdy wartosc znajduje sie w drzewie nieposiadajacym poddrzew
              ( node
                (leaf)
                5
                [node 
                  {node (leaf) 6 (leaf) }
                  8
                  {node (leaf) 9 (leaf) }
                ]))

(check-equal? (delete 9 t) ;przypadek gdy wartosc znajduje sie w drzewie nieposiadajacym poddrzew
              ( node
                [ node ( leaf ) 2 ( leaf ) ]
                5
                [node 
                  {node (leaf) 6 (leaf) }
                  8
                  (leaf)
                ]))

(check-equal? (delete 8 t) ;przypadek gdy wartosc znajduje sie w drzewie posiadajacym poddrzewa
              ( node
                [ node (leaf) 2 (leaf) ]
                5
                [node 
                  (leaf)
                  6
                  {node (leaf) 9 (leaf) }
                ]))

(check-equal? (delete 5 t) ;przypadek gdy wartosc znajduje sie w korzeniu drzewa
              ( node
                (leaf)
                2
                [node 
                  {node (leaf) 6 (leaf) }
                  8
                  {node (leaf) 9 (leaf) }
                ]))
(check-equal? (delete 0 t) ;jesli wartosc nie znajduje sie w drzewie to zostanie ono zwrocone bez zmian
              ( node
                [ node ( leaf ) 2 ( leaf ) ]
                5
                [ node 
                  ( node ( leaf ) 6 ( leaf ) )
                  8
                  ( node (leaf) 9 ( leaf ) )
                ]))
