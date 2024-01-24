class Kryptoarytm:
    def __init__(self, s1, s2, s3, op):
        self.slowo1 = s1
        self.slowo2 = s2
        self.slowoWynik = s3
        self.operator = self.opToFun(op)
        self.rozneLitery = self.znajdzLitery()
        self.ileLiter = len(self.rozneLitery)
        self.iteratorWartosciLiter = self.generatorWartosciLiter()
        self.wartosciLiter = next(self.iteratorWartosciLiter)
        self.slownikLiter = {}

    # zwraca funkcje rownowazna danemu operatorowi ------------------------------------------------
    def opToFun(self, op):
        match op:
            case '+': return lambda x, y: x + y
            case '-': return lambda x, y: x - y
            case '*': return lambda x, y: x * y
            case '/': return lambda x, y: x / y
            case _: return lambda x, y: x / 0 # zly operator ma wywolywac blad

    # generator kolejnych wartosci liter ----------------------------------------------------------
    def generatorWartosciLiter(self):
        indeksZmiany = self.ileLiter - 1
        self.wartosciLiter = [0 for _ in range(self.ileLiter)]
        self.wartosciLiter[indeksZmiany] = -2 # aby pierwszy next zwrocil [0] * ileLiter
    
        # szukamy kazdych kolejnych wartosci liter
        while indeksZmiany >= 0:
            if self.wartosciLiter[indeksZmiany] == 9:
                while indeksZmiany >= 0 and self.wartosciLiter[indeksZmiany] == 9:
                    indeksZmiany -= 1
            if indeksZmiany < 0: # znaleziono juz wszystkie mozliwosci
                self.wartosciLiter = None
            else: # przejdz do kolejnych wartosci
                self.wartosciLiter[indeksZmiany] += 1
                for i in range(indeksZmiany + 1, self.ileLiter):
                    self.wartosciLiter[i] = 0
                indeksZmiany = self.ileLiter - 1
            yield self.wartosciLiter
        while True: # po znalezeniu wszystkich mozliwych kombinacji wartosci liter zawsze zwraca None
            yield None

    # zwraca liste roznych liter ktore istieja w ktoryms ze slow x,y,z ----------------------------
    def znajdzLitery(self):
        rozneLitery = set()
        for litera in self.slowo1:
            rozneLitery.add(litera)
        for litera in self.slowo2:
            rozneLitery.add(litera)
        for litera in self.slowoWynik:
            rozneLitery.add(litera)
        return list(rozneLitery)

    def tlumacz(self, slowo: str):
        suma = 0
        dlugosc = len(slowo)
        for i in range(dlugosc):
            suma += 10**i * self.slownikLiter[slowo[dlugosc - i - 1]]
        return suma

    def porownaj(self):
        wartosc1 = self.tlumacz(self.slowo1)
        wartosc2 = self.tlumacz(self.slowo2)
        wynik = self.tlumacz(self.slowoWynik)
        return self.operator(wartosc1, wartosc2) == wynik

    # sprawdza czy dane rozwiazanie jest poprawnym rozwiazaniem kryptoarytmu ----------------------
    def czyPoprawneRozwiazanie(self):
        if self.wartosciLiter == None:
            return None
        self.slownikLiter = {}
        for i in range(self.ileLiter):
            self.slownikLiter[self.rozneLitery[i]] = self.wartosciLiter[i]
        return self.porownaj()

    # znajduje pierwsze rozwiazanie kryptoarytmu dla wartosci liter nie mniejszych niz podane -----
    def znajdzNastepneRozwiazanie(self):
        next(self.iteratorWartosciLiter)
        popr = self.czyPoprawneRozwiazanie()
        while (popr is not None) and (not popr):
            next(self.iteratorWartosciLiter)
            popr = self.czyPoprawneRozwiazanie()

    # zwraca kolejne rozwiazania kryptoarytmu -----------------------------------------------------
    def generatorRozwiazan(self):
        while self.wartosciLiter is not None: # szukamy kazdego kolejnego rozwiazania
            self.znajdzNastepneRozwiazanie()
            yield self.wartosciLiter

    def znajdzWszystkieRozwiazania(self): # FIX
        it = self.generatorRozwiazan()
        rozw = next(it, None)        
        while rozw is not None:
            rozw = next(it, None)
            print(self.slownikLiter)

# test --------------------------------------------------------------------------------------------

slowo1 = "kioto"
slowo2 = "osaka"
slowo3 = "tokio"
operator = "+"

gra = Kryptoarytm(slowo1, slowo2, slowo3, operator)
gra.znajdzWszystkieRozwiazania()