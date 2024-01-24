from decimal import *

# FUNKCJE ZWYKLE

def vat_faktura(lista):
    suma = 0
    for elem in lista:
        suma += elem
    return suma * 0.23

def vat_paragon(lista):
    suma = 0
    for elem in lista:
        suma += elem * 0.23
    return suma

# FUNKCJE DECIMAL

def vat_faktura_dec(lista):
    suma = 0
    for elem in lista:
        suma += elem
    return suma * Decimal('0.23')

def vat_paragon_dec(lista):
    suma = 0
    for elem in lista:
        suma += elem * Decimal('0.23')
    return suma

# TEST ZWYKLY

xs1 = [3.33] * 3
vf1 = vat_faktura(xs1)
vp1 = vat_paragon(xs1)
print(str(vf1) + " " + str(vf1))
print(vf1 == vp1) # False

# TEST DECIMAL

xs2 = [Decimal('3.33')] * 3
vf2 = vat_faktura_dec(xs2)
vp2 = vat_paragon_dec(xs2)
print(str(vf2) + " " + str(vf2))
print(vf2 == vp2) # True
