def slowSudan(n, x, y):
    if (n == 0):
        return x + y
    elif (y == 0):
        return x
    ss = slowSudan(n, x, y-1)
    return slowSudan(n-1, ss, ss + y)

def sudan(n0, x0, y0):
    tab = {} # tablica memoizacyjna
    def memSudan(n, x, y):
        if (n == 0):
            return x + y
        elif (y == 0):
            return x
        # przeszukanie tablicy z memoizacja
        if (n, x, y) not in tab: # nie wyliczono jeszcze tej wartosci, wykonaj rekurencje
            ss = memSudan(n, x, y-1)
            tab[(n, x, y)] = memSudan(n-1, ss, ss + y)
        return tab[(n, x, y)]
    return memSudan(n0, x0, y0)

print(sudan(2, 1, 2))