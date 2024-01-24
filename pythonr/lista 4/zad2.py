import time

def czyDoskonala(n):
    dzielniki = []
    i = 1
    while i*i <= n:
        if n % i == 0:
            dzielniki.append(i)
        i+=1
    return n == sum(dzielniki)

def doskonale_imperatywna(n):
    lista = []
    x = 2
    while (x <= n):
        if czyDoskonala(x):
            lista.append(x)
        x += 1
    return lista

def doskonale_skladana(n):
    lista = [x for x in range(2, n + 1) if czyDoskonala(x)]
    return lista

def doskonale_funkcyjna(n):
    return list(filter(czyDoskonala, range(2, n + 1)))

limit = 25_000

t = time.time()
doskonale_imperatywna(limit)
print(time.time() - t)

t = time.time()
doskonale_skladana(limit)
print(time.time() - t)

t = time.time()
doskonale_funkcyjna(limit)
print(time.time() - t)