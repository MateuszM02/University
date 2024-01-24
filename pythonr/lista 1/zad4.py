# zakladam, ze kolo ma srednice 1

from math import sqrt, pi
from random import uniform

def dist(x, y): # jesli <= 1 to rzut wewnatrz okregu
    return sqrt(x*x+y*y)

def calc_PI(ltwo, cltwt): # oblicza przyblizenie pi
    return 4*ltwo/cltwt

def throw(): # symuluje pojedynczy rzut lotka w tarcze
    return uniform(-1, 1), uniform(-1, 1)

def sim(count, epsilon=0):
    ltwo = 0
    myPi = 0
    for cltwt in range(1, count+1):
        x, y = throw()
        d = dist(x, y)
        if d <= 1.0: # wewnatrz okregu
            ltwo += 1
        myPi = calc_PI(ltwo, cltwt) # przyblizenie pi
        print(myPi)
        if (abs(myPi - pi) <= epsilon): # przyblizenie jest wystarczajaco dobre, zwroc je
            return myPi
    return myPi # wykonano oczekiwana ilosc symulacji, zwroc ostatnie przyblizenie

sim(1024)