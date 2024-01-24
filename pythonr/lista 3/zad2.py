from collections import deque
import numbers

# CZESC 1 - konwersja -----------------------------------------------------------------------------

def konwersja(wyrazenie_infiksowe):
    wyrazenie_ONP = deque() # wyrazenie_infiksowe w postaci ONP
    stos = deque() # stos pomocniczy do operatorow
    op1 = ['+', '-'] # operatory o nizszym priorytecie
    op2 = ['*', '/', '%'] # operatory o wyzszym priorytecie
    op3 = ['^'] # operatory o najwyzszym priorytecie

    for symbol in wyrazenie_infiksowe:
        if (isinstance(symbol, numbers.Number)): # jest liczba, dodaj na koniec wyniku
            wyrazenie_ONP.append(symbol)
        elif symbol == '(':
            stos.append('(')
        elif symbol == ')':
            for _ in range(len(stos)):
                if stos[-1] == '(':
                    stos.pop()
                    break
                wyrazenie_ONP.append(stos.pop())
        elif symbol in op1: # '+', '-'
            for _ in range(len(stos)):
                if stos[-1] == '(':
                    break
                wyrazenie_ONP.append(stos.pop())
            stos.append(symbol)
        elif symbol in op2: # '*', '/', '%'
            for _ in range(len(stos)):
                if (stos[-1] not in op2) and (stos[-1] not in op3):
                    break
                wyrazenie_ONP.append(stos.pop())
            stos.append(symbol)
        elif symbol in op3: # '^'
            stos.append(symbol)
    for _ in range(len(stos)):
        wyrazenie_ONP.append(stos.pop())
    return list(wyrazenie_ONP)

# testy do konwersji

op1 = ['(', 2, '+', 3, ')', '*', 4]
kop1 = konwersja(op1)
assert kop1 == [2, 3, '+', 4, '*']

op2 = [12, '+', 5, '*', '(', 4, '*', 3, '+', 2, '/', 1, ')']
kop2 = konwersja(op2)
assert kop2 == [12, 5, 4, 3, '*', 2, 1, '/', '+', '*', '+']

op3 = [2, '^', 5, '*', 3]
kop3 = konwersja(op3)
assert kop3 == [2, 5, '^', 3, '*']

op4 = [2, '^', '(', 1, '+', 2, '*', 3, ')']
kop4 = konwersja(op4)
assert kop4 == [2, 1, 2, 3, '*', '+', '^']

# CZESC 2 - oblicz --------------------------------------------------------------------------------

def parser(b, a, op): # zwraca wynik b op a
    operatory = ['+', '-', '*', '/', '%', '^'] # operatory
    dodaj = lambda x, y: x + y
    odejmij = lambda x, y: x - y
    pomnoz = lambda x, y: x * y
    podziel = lambda x, y: x / y
    reszta = lambda x, y: x % y
    potega = lambda x, y: x**y
    funkcje = [dodaj, odejmij, pomnoz, podziel, reszta, potega]
    indeks = operatory.index(op)
    return funkcje[indeks](b, a)

def oblicz(wyrazenie_onp):
    stos = deque() # stos pomocniczy do liczb

    for symbol in wyrazenie_onp:
        if (isinstance(symbol, numbers.Number)): # jest liczba, dodaj na koniec stosu
            stos.append(symbol)
        else: # jest operatorem
            a = stos.pop()
            b = stos.pop()
            wynik = parser(b, a, symbol) 
            stos.append(wynik)
    return stos.pop()

# testy do obliczen

wyn1 = oblicz(kop1)
assert wyn1 == 20

wyn2 = oblicz(kop2)
assert wyn2 == 82

wyn3 = oblicz(kop3)
assert wyn3 == 96

wyn4 = oblicz(kop4)
assert wyn4 == 128