import math, time

# 1. IMPERATYWNA ----------------------------------------------------------------------------------

def czyPierwszaImperatywna(n):
    if (n < 2):
        return False
    for dzielnik in range(2, math.floor(math.sqrt(n) + 1)):
        if n % dzielnik == 0:
            return False
    return True

def pierwsze_imperatywna(n):
    lista = []
    x = 2
    while (x <= n):
        if czyPierwszaImperatywna(x):
            lista.append(x)
        x += 1
    return lista

# 2. SKLADANA -------------------------------------------------------------------------------------

def czyPierwszaSkladana(n):
    return n == 2 or n == 3 or all(n % dzielnik != 0 for dzielnik in range(2, math.floor(math.sqrt(n))+1))

def pierwsze_skladana(n):
    lista = [x for x in range(2, n + 1) if czyPierwszaSkladana(x)]
    return lista

# 3. FUNKCYJNA ------------------------------------------------------------------------------------

def czyPierwszaFunkcyjna(n):
    return len(list(filter(lambda dzielnik: n % dzielnik == 0 and n != 2, range(2,math.floor(math.sqrt(n))+1)))) == 0

def pierwsze_funkcyjna(n):
    return list(filter(czyPierwszaFunkcyjna, range(2, n + 1)))

# 4. Porownanie -----------------------------------------------------------------------------------

limit = 50_000

t = time.time()
pierwsze_imperatywna(limit)
print(time.time() - t) # 0,33 sekundy

t = time.time()
pierwsze_skladana(limit)
print(time.time() - t) # 4,38 sekundy

t = time.time()
pierwsze_funkcyjna(limit)
print(time.time() - t) # 5,01 sekund