from enum import Enum

# Typ enum okreslajacy rodzaj formuly -------------------------------------------------------------

class TypFormuly(Enum):
    STALA = 1
    ZMIENNA = 2
    NOT = 3
    OR = 4
    AND = 5
    TYPE_ERROR = 6 # odpowiada za formuly niepoprawnego typu
    VALUE_ERROR = 7 # odpowiada za formuly, ktorych ewaluacja sie nie powiodla przez zmienne wolne lub sprzeczne wartosci

# Formula zdaniowa --------------------------------------------------------------------------------

class Formula():
    def __init__(self, typ: TypFormuly, nazwa=None, wartosc=None, lewa=None, prawa=None):
        if typ not in [TypFormuly.STALA, TypFormuly.ZMIENNA, TypFormuly.NOT, TypFormuly.OR, TypFormuly.AND]: # bledny typ formuly
            if typ != TypFormuly.VALUE_ERROR:
                typ = TypFormuly.TYPE_ERROR
        self.typ = typ
        match self.typ:
            case TypFormuly.STALA:
                self.wartosc = wartosc
            case TypFormuly.ZMIENNA:
                self.nazwa = nazwa
            case TypFormuly.NOT:
                self.wartosc = wartosc
            case TypFormuly.OR:
                self.lewa = lewa
                self.prawa = prawa
            case TypFormuly.AND:
                self.lewa = lewa
                self.prawa = prawa
    
    # oblicza wartosc funkcji --------------------------------------------------------------------- 
    def oblicz(self, zmienne: dict[str, bool]={}) -> bool | TypFormuly:
        self = self.uprosc(True) # na poczatek uprosc wyrazenie
        match self.typ:
            case TypFormuly.STALA:
                return self.wartosc
            case TypFormuly.ZMIENNA:
                if self.nazwa in zmienne: # slownik zawiera zmienna, zwroc jej wartosc
                    return zmienne[self.nazwa]
                else: # slownik nie zawiera zmiennej, zwroc formule typu value_error
                    return Formula(TypFormuly.VALUE_ERROR)
            case TypFormuly.NOT:
                self.wartosc = self.wartosc.oblicz(zmienne)
                if hasattr(self.wartosc, 'typ'): # jesli error to zwroc go
                    return self.wartosc
                self.typ = TypFormuly.STALA
                return not self.wartosc
            case TypFormuly.OR:
                lewa = self.lewa.oblicz(zmienne)
                if lewa != False: # czyli True albo Error
                    return lewa
                prawa = self.prawa.oblicz(zmienne)
                return prawa
            case TypFormuly.AND:
                lewa = self.lewa.oblicz(zmienne)
                if hasattr(lewa, 'typ'): # jesli error to zwroc go
                    return lewa
                prawa = self.prawa.oblicz(zmienne)
                if hasattr(prawa, 'typ'): # jesli error to zwroc go
                    return prawa
                return lewa and prawa
            case TypFormuly.TYPE_ERROR:
                return self
            case TypFormuly.VALUE_ERROR:
                return self
            case _: raise TypeError("Argument nie jest formula")

    # sprawdza, czy funkcja jest tautologia -------------------------------------------------------
    def tautologia(self) -> bool:
        czyTautologia = self.tautologiaPomoc() # zwraca True/False/None/error, a tylko True jest tautologia
        if hasattr(czyTautologia, 'typ'): # Error
            raise ValueError("Nie udalo sie sprawdzic, czy formula jest tautologia")
        return czyTautologia
        
    # kiedy nie jest tautologia:
    # 1. <zmienna> AND <cokolwiek>
    # 2. False AND <cokolwiek>
    # 3. False OR <zmienna>
    # 4. False OR False
    # 5. False
    # 6. <zmienna>
    # 7. analogicznie gdy mamy NOT(<cokolwiek>)

    # zwraca True jesli jest tautologia, False gdy jest kontrtautologia, 
    # None gdy zalezy od wartosci zmiennych
    def tautologiaPomoc(self) -> bool | None | TypFormuly:
        match self.typ:
            case TypFormuly.STALA:
                return self.wartosc
            case TypFormuly.ZMIENNA:
                return None
            case TypFormuly.NOT:
                czyTautologia = self.wartosc.tautologiaPomoc()
                if czyTautologia is None:
                    return None
                elif hasattr(czyTautologia, 'typ'): # jesli error to zwroc go
                    return czyTautologia
                return not czyTautologia
            case TypFormuly.OR:
                return self.tautologiaOR()
            case TypFormuly.AND:
                return self.tautologiaAND()
            case _: 
                return Formula(TypFormuly.TYPE_ERROR)

    def tautologiaOR(self) -> bool:
        lewyTyp = self.lewa.typ
        prawyTyp = self.prawa.typ

        if (lewyTyp == prawyTyp):
            match lewyTyp:
                case TypFormuly.STALA: # <stala> or <stala>
                    return self.wartosc
                case TypFormuly.ZMIENNA: # <zmienna> or <zmienna>
                    return None
                case TypFormuly.TYPE_ERROR: # zwroc error
                    return self.lewa
                case TypFormuly.VALUE_ERROR: # zwroc error
                    return self.lewa

        match lewyTyp:
            case TypFormuly.STALA: # <stala> or <nie-stala>, czyli lewa = True albo prawa musi byc tautologia
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                return self.lewa.wartosc or czyPrawaTautologia
            case TypFormuly.ZMIENNA: # <zmienna> or <nie-zmienna>, czyli prawa musi byc tautologia
                return self.prawa.tautologiaPomoc()
            case TypFormuly.NOT: # <not X> or Y, czyli jedna z nich musi byc tautologia
                czyLewaTautologia = self.lewa.tautologiaPomoc()
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyLewaTautologia, 'typ'): # jesli error to zwroc go
                    return czyLewaTautologia
                elif hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                elif None in [czyLewaTautologia, czyPrawaTautologia]:
                    return None
                return czyLewaTautologia or czyPrawaTautologia
            case TypFormuly.OR: # <X1 or X2> or Y
                czyLewaTautologia = self.lewa.tautologiaOR()
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyLewaTautologia, 'typ'): # jesli error to zwroc go
                    return czyLewaTautologia
                elif hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                elif None in [czyLewaTautologia, czyPrawaTautologia]:
                    return None
                return czyLewaTautologia or czyPrawaTautologia
            case TypFormuly.AND: # <X1 and X2> or Y
                czyLewaTautologia = self.lewa.tautologiaAND()
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyLewaTautologia, 'typ'): # jesli error to zwroc go
                    return czyLewaTautologia
                elif hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                elif None in [czyLewaTautologia, czyPrawaTautologia]:
                    return None
                return czyLewaTautologia or czyPrawaTautologia
            case TypFormuly.TYPE_ERROR:
                return self.lewa
            case TypFormuly.VALUE_ERROR:
                return self.lewa
            case _: 
                return Formula(TypFormuly.TYPE_ERROR)
    
    def tautologiaAND(self) -> bool:
        lewyTyp = self.lewa.typ
        prawyTyp = self.prawa.typ

        if (lewyTyp == prawyTyp):
            match lewyTyp:
                case TypFormuly.STALA: # <stala> and <stala>
                    return self.wartosc
                case TypFormuly.ZMIENNA: # <zmienna> and <zmienna>
                    return False
                case TypFormuly.TYPE_ERROR: # zwroc error
                    return self.lewa
                case TypFormuly.VALUE_ERROR: # zwroc error
                    return self.lewa

        match lewyTyp:
            case TypFormuly.STALA: # <stala> and <nie-stala>, czyli lewa = True i prawa musi byc tautologia
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                return self.lewa.wartosc and czyPrawaTautologia
            case TypFormuly.ZMIENNA: # <zmienna> and <nie-zmienna>, czyli nie moze byc tautologia
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                return None
            case TypFormuly.NOT: # <not X> and Y, czyli obie musza byc tautologia
                czyLewaTautologia = self.lewa.tautologiaPomoc()
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyLewaTautologia, 'typ'): # jesli error to zwroc go
                    return czyLewaTautologia
                elif hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                elif None in [czyLewaTautologia, czyPrawaTautologia]:
                    return None
                return czyLewaTautologia and czyPrawaTautologia
            case TypFormuly.OR: # <X1 or X2> and Y
                czyLewaTautologia = self.lewa.tautologiaOR()
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyLewaTautologia, 'typ'): # jesli error to zwroc go
                    return czyLewaTautologia
                elif hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                elif None in [czyLewaTautologia, czyPrawaTautologia]:
                    return None
                return czyLewaTautologia and czyPrawaTautologia
            case TypFormuly.AND: # <X1 and X2> and Y
                czyLewaTautologia = self.lewa.tautologiaAND()
                czyPrawaTautologia = self.prawa.tautologiaPomoc()
                if hasattr(czyLewaTautologia, 'typ'): # jesli error to zwroc go
                    return czyLewaTautologia
                elif hasattr(czyPrawaTautologia, 'typ'): # jesli error to zwroc go
                    return czyPrawaTautologia
                elif None in [czyLewaTautologia, czyPrawaTautologia]:
                    return None
                return czyLewaTautologia and czyPrawaTautologia
            case TypFormuly.TYPE_ERROR:
                return self.lewa
            case TypFormuly.VALUE_ERROR:
                return self.lewa
            case _: 
                return Formula(TypFormuly.TYPE_ERROR)

    # upraszcza postac formuly
    def uprosc(self, rekurencja=False):
        match self.typ:
            case TypFormuly.STALA:
                return self
            case TypFormuly.ZMIENNA:
                return self
            case TypFormuly.NOT:
                if type(self.wartosc) == Formula:
                    self.wartosc = self.wartosc.uprosc(True)
                    if self.wartosc.typ == TypFormuly.STALA: # dla postaci NOT(True/False)
                        self = self.wartosc # usun NOT
                        self.wartosc = not self.wartosc # negacja wyrazenia
                return self
            case TypFormuly.OR:
                if (self.lewa.typ == TypFormuly.STALA): # true/false or <cos> == true/<cos>
                    if self.lewa.wartosc: # true or <cos> == true
                        return self.lewa
                    else: # false or <cos> == <cos>
                        return self.prawa
                elif (self.prawa.typ == TypFormuly.STALA): # <cos> or true/false == true/<cos>
                    if self.prawa.wartosc: # <cos> or true == true
                        return self.prawa
                    else: # <cos> or false == <cos>
                        return self.lewa
                else:
                    if rekurencja:
                        self.lewa = self.lewa.uprosc(True)
                        self.prawa = self.prawa.uprosc(True)
                        self = self.uprosc()
                    return self
            case TypFormuly.AND:
                if (self.lewa.typ == TypFormuly.STALA): # true/false and <cos> == <cos>/false
                    if self.lewa.wartosc: # true and <cos> == <cos>
                        return self.prawa
                    else: # false and <cos> == false
                        return self.lewa
                elif (self.prawa.typ == TypFormuly.STALA): # <cos> and true/false == <cos>/false
                    if self.prawa.wartosc: # <cos> and true == <cos>
                        return self.lewa
                    else: # <cos> and false == false
                        return self.prawa
                else:
                    if rekurencja:
                        self.lewa = self.lewa.uprosc(True)
                        self.prawa = self.prawa.uprosc(True)
                        self = self.uprosc()
                    return self
            case _: raise TypeError("Zly typ")

    # zamienia funkcje z postaci obiektu do napisu ------------------------------------------------
    def __str__(self) -> str:
        # zakladam, ze nawet znajac wartosc zmiennej mamy wypisac jej nazwe
        match self.typ:
            case TypFormuly.STALA:
                if self.wartosc:
                    return 'True'
                return 'False'
            case TypFormuly.ZMIENNA:
                return self.nazwa
            case TypFormuly.NOT:
                napis = self.wartosc.__str__()
                return "NOT(" + napis + ")"
            case TypFormuly.OR:
                lewyNapis = self.lewa.__str__()
                prawyNapis = self.prawa.__str__()
                return "(" + lewyNapis + " OR " + prawyNapis + ")"
            case TypFormuly.AND:
                lewyNapis = self.lewa.__str__()
                prawyNapis = self.prawa.__str__()
                return "(" + lewyNapis + " AND " + prawyNapis + ")"
            case _: raise TypeError("Zly typ")
    
    def __add__(w1, w2): # alternatywa
        return Or(w1, w2)
    
    def __mul__(w1, w2): # koniunkcja
        return And(w1, w2)
    
# Rodzaje formul ----------------------------------------------------------------------------------

class Stala:
    def __new__(cls, wartosc: bool) -> Formula:
        return Formula(TypFormuly.STALA, wartosc=wartosc)

class Zmienna:
    def __new__(cls, nazwa: str) -> Formula:
        return Formula(TypFormuly.ZMIENNA, nazwa=nazwa)

class Not:
    def __new__(cls, formula: Formula) -> Formula:
        return Formula(TypFormuly.NOT, wartosc=formula)

class Or:
    def __new__(cls, lewa: Formula, prawa: Formula) -> Formula:
        return Formula(TypFormuly.OR, lewa=lewa, prawa=prawa)

class And:
    def __new__(cls, lewa: Formula, prawa: Formula) -> Formula:
        return Formula(TypFormuly.AND, lewa=lewa, prawa=prawa)