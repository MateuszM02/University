from formula import Formula, Stala, Zmienna, Not, Or, And

# Funkcje tworzace zmienne testowe --------------------------------------------------------------------------

f1 = lambda: Or(Not(Zmienna("x")), And(Zmienna("y"), Stala(True))) # (not x) or (y and True) == nie-tautologia
f2 = lambda: And(Zmienna("x"), Stala(False)) # x and False == False
f3 = lambda: Or(Zmienna("x"), Stala(True)) # x or True == True
f4 = lambda: Or(Or(Zmienna("x"), Stala(False)), Or(Zmienna("y"), Stala(True))) # (x or False) or (y or True)
f5 = lambda: And(Not(Stala(False)), Or(Zmienna("y"), Stala(True))) # (not False) and (y or True) == True
f6 = lambda: Not(And(Stala(True), Zmienna("y"))) # not (True and y) == nie-tautologia
f7 = lambda: Zmienna("a") # Or(Zmienna("a"), Not(Zmienna("a")))
# (true and x) or ((x and y) or z) -> x or ((x and y) or z) == x or z, nie-tautologia
f8 = lambda: Or(And(Stala(True), Zmienna("x")), Or(And(Zmienna("x"), Zmienna("y")), Zmienna('z')))

f1add = Formula.__add__(Not(Zmienna("x")), And(Zmienna("y"), Stala(True))) # rownowazne f1
f2mul = Formula.__mul__(Zmienna("x"), Stala(False)) # rownowazne f2

# Testy tautologia --------------------------------------------------------------------------------

def testy_tautologia():
    t1 = f1().tautologia()
    t2 = f2().tautologia()
    t3 = f3().tautologia()
    t4 = f4().tautologia()
    t5 = f5().tautologia()
    t6 = f6().tautologia()
    t7 = f7().tautologia()
    t8 = f8().tautologia()

    assert not t1
    assert not t2
    assert t3
    assert t4
    assert t5
    assert not t6
    assert not t7
    assert not t8

# Testy __str__ -----------------------------------------------------------------------------------

def testy_str():
    s1 = f1().__str__()
    s2 = f2().__str__()
    s3 = f3().__str__()
    s4 = f4().__str__()
    s5 = f5().__str__()
    s6 = f6().__str__()
    s7 = f7().__str__()
    s8 = f8().__str__()

    assert s1 == '(NOT(x) OR (y AND True))'
    assert s2 == '(x AND False)'
    assert s3 == '(x OR True)'
    assert s4 == '((x OR False) OR (y OR True))'
    assert s5 == '(NOT(False) AND (y OR True))'
    assert s6 == 'NOT((True AND y))'
    assert s7 == 'a'
    assert s8 == '((True AND x) OR ((x AND y) OR z))'

# Testy uprosc i __str__ --------------------------------------------------------------------------

def testy_uprosc():
    u1 = f1().uprosc(True).__str__() # (not x) or (y and True) -> (not x) or y
    u2 = f2().uprosc(True).__str__() # x and False -> False
    u3 = f3().uprosc(True).__str__() # x or True -> True
    u4 = f4().uprosc(True).__str__() # (x or False) or (y or True) -> x or True -> True
    u5 = f5().uprosc(True).__str__() # (not False) and (y or True) -> True and True -> True
    u6 = f6().uprosc(True).__str__() # not (True and y) -> not y
    u7 = f7().uprosc(True).__str__() # a -> a
    u8 = f8().uprosc(True).__str__() # (true and x) or ((x and y) or z) -> x or ((x and y) or z)

    assert u1 == '(NOT(x) OR y)'
    assert u2 == 'False'
    assert u3 == 'True'
    assert u4 == 'True'
    assert u5 == 'True'
    assert u6 == 'NOT(y)'
    assert u7 == 'a'
    assert u8 == '(x OR ((x AND y) OR z))'

# Testy oblicz ------------------------------------------------------------------------------------

def testy_oblicz():
    o1 = f1().oblicz({'x': True, 'y': True}) # (not x) or y -> False or True -> True
    o2 = f1().oblicz({'x': True, 'y': False}) # (not x) or y -> False or False -> False
    o3 = f6().oblicz({'y': True}) # not (True and y) -> not y -> False
    o4 = f7().oblicz({'a': True}) # a -> True
    o5 = f8().oblicz({'x': True, 'y': False, 'z': False}) # x or ((x and y) or z) -> True
    o6 = f8().oblicz({'x': False, 'y': False, 'z': True}) # x or ((x and y) or z) -> False or (False or True) -> True
    o7 = f8().oblicz({'x': False, 'y': False, 'z': False}) # x or ((x and y) or z) -> False or (False or False) -> False
    o8 = f8().oblicz({'x': True}) # x or ((x and y) or z) -> True or (y or z) -> True

    assert o1
    assert not o2
    assert not o3
    assert o4
    assert o5
    assert o6
    assert not o7
    assert o8

# Testy oblicz z niepoprawnymi formulami ----------------------------------------------------------

def testy_oblicz_zle():
    b1 = f1().oblicz() # (not x) or y
    b2 = f1().oblicz() # (not x) or y
    b3 = f6().oblicz() # not (True and y) -> not y
    b4 = f7().oblicz() # a
    b5 = f8().oblicz() # x or ((x and y) or z)
    b6 = f8().oblicz({'x': False, 'y': False}) # x or ((x and y) or z)

    assert b1.typ.name == 'VALUE_ERROR'
    assert b2.typ.name == 'VALUE_ERROR'
    assert b3.typ.name == 'VALUE_ERROR'
    assert b4.typ.name == 'VALUE_ERROR'
    assert b5.typ.name == 'VALUE_ERROR'
    assert b6.typ.name == 'VALUE_ERROR'

# wywolanie testow --------------------------------------------------------------------------------

testy_tautologia()
testy_str()
testy_uprosc()
testy_oblicz()
testy_oblicz_zle()