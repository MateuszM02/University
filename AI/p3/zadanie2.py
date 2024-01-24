import copy
from collections import deque

# 1. inicjalizacja klasy ----------------------------------------------------------------

class Nonogram:
    def __init__(self, r, c):
        self.rows = r # ilosc wierszy
        self.cols = c # ilosc kolumn
        self.row_blocks = [] # ilosc i dlugosc blokow w poszczegolnych wierszach
        self.column_blocks = [] # ilosc i dlugosc blokow w poszczegolnych kolumnach
        self.row_perms = [] # mozliwe wypelnienia kazdego rzedu
        self.col_perms = [] # mozliwe wypelnienia kazdej kolumny

        # plansza do gry, znaczenie wartosci pol: 
        # None - nieznane, 0 - niezamalowane, 1 - zamalowane,
        # True - zgaduje ze zamalowane, False - zgaduje ze niezamalowane
        # poczatkowo same None - wszystkie pola sa nieznane
        self.matrix = [[None for _ in range(c)] for _ in range(r)]

# 2. Sprawdzanie poprawnosci planszy ----------------------------------------------------

    def is_solved(self, rPerms, cPerms):
        """ sprawdza, czy w kazdym rzedzie istnieje tylko 1 poprawna permutacja """
        for row in rPerms: # dla kazdego rzedu
            if len(row) != 1: # niejednoznaczne rozwiazanie rzedu
                return False
        for col in cPerms: # dla kazdego rzedu
            if len(col) != 1: # niejednoznaczne rozwiazanie kolumny
                return False
        return True

    def is_correct_state(self, rPerms, cPerms):
        """ sprawdza, czy w kazdym rzedzie istnieje co najmniej 1 mozliwe rozwiazanie """
        for row in range(len(rPerms)): # dla kazdego rzedu
            if not rPerms[row]: # jesli nie istnieje poprawne rozwiazanie, zwroc falsz
                return False
        for col in range(len(cPerms)): # dla kazdej kolumny
            if not cPerms[col]: # jesli nie istnieje poprawne rozwiazanie, zwroc falsz
                return False
        return True

# 3. Wyznaczanie pol gwarantowanych -----------------------------------------------------

    def find_filled_common(self, perms):
        """ zwraca permutacje, w ktorej pola oznaczone 1 sa pewne do zamalowania
            :param perms: lista wszystkich mozliwych permutacji paska """
        common_perm = [1 for _ in range(len(perms[0]))]
        for p in perms:
            for i in range(len(common_perm)):
                common_perm[i] = common_perm[i] and p[i]
        return common_perm

    def find_empty_common(self, perms):
        """ zwraca permutacje, w ktorej pola oznaczone 0 na pewno nie sa zamalowane
            :param perms: lista wszystkich mozliwych permutacji paska """
        common_perm = [0 for _ in range(len(perms[0]))]
        for p in perms:
            for i in range(len(common_perm)):
                common_perm[i] = common_perm[i] or p[i]
        return common_perm

# 4. rozwiazywanie zadania wnioskowaniem ------------------------------------------------

    def solve_reasoning(self):
        """ eliminuj potencjalne rozwiazania do momentu gdy kazdy 
            wiersz/kolumna ma jednoznaczne rozwiazanie 
            :return: czy rozwiazanie jest ostatecznym (True) czy wymaga Backtrackingu (False)"""
        anyChange = True
        while anyChange:
            anyChange = False
            # dla kazdego wiersza, zaktualizuj jego liste potencjalnych rozwiazan
            for r in range(self.rows):
                if self.row_perms[r] == []: # nie ma rozwiazania
                    return None
                filled_common = self.find_filled_common(self.row_perms[r])
                empty_common = self.find_empty_common(self.row_perms[r])
                for c in range(len(filled_common)): # dla kazdej kolumny w tym wierszu
                    if filled_common[c] == 1: # jesli na pewno jest zapelniony
                        self.matrix[r][c] = 1
                        rdc = self.reduce_row_domain(1, r, filled_common)
                        anyChange = anyChange or rdc
                    if empty_common[c] == 0: # jesli na pewno jest pusty
                        self.matrix[r][c] = 0
                        rdc = self.reduce_row_domain(0, r, empty_common)
                        anyChange = anyChange or rdc
        
            # dla kazdej kolumny, zaktualizuj jej liste potencjalnych rozwiazan
            for c in range(self.cols):
                if self.col_perms[c] == []: # nie ma rozwiazania
                    return None
                filled_common = self.find_filled_common(self.col_perms[c])
                empty_common = self.find_empty_common(self.col_perms[c])
                for r in range(len(filled_common)): # dla kazdego wiersza w tej kolumnie
                    if filled_common[r] == 1: # jesli na pewno jest zapelniony
                        rdc = self.reduce_column_domain(1, c, filled_common)
                        anyChange = anyChange or rdc
                    if empty_common[r] == 0: # jesli na pewno jest pusty
                        rdc = self.reduce_column_domain(0, c, empty_common)
                        anyChange = anyChange or rdc
        return anyChange

# 5. redukcja ilosci potencjalnych rozwiazan (wnioskowanie) -----------------------------

    def reduce_row_domain(self, type, index, common_perm): 
        """ zmniejsza ilosc potencjalnych rozwiazan
            :param type: typ czesci wspolnej: 0 - empty, 1 - filled
            :param index: na ktorym indeksie czesc wspolna byla szukana 
            :param common_perm: permutacja zawierajaca informacje o czesci wspolnej
            :return: czy doszlo do jakiegokolwiek zawezenia dziedzin """

        anyChange = False
        for col in range(self.cols): # dla kazdej kolumny
            temp = []
            if common_perm[col] == type: # jesli kolumna nalezy do czesci wspolnej
                for j in range(len(self.col_perms[col])): # dla kazdego wiersza w tej kolumnie
                    if self.col_perms[col][j][index] == type: # jesli tez nalezy do czesci wspolnej
                        temp.append(self.col_perms[col][j])
                if(not anyChange and temp != self.col_perms[col]):
                    anyChange = True
                self.col_perms[col] = temp # zaktualizuj czesc wspolna tej kolumny
        return anyChange

    def reduce_column_domain(self, type, index, common_perm): 
        """ zmniejsza ilosc potencjalnych rozwiazan
            :param type: typ czesci wspolnej: 0 - empty, 1 - filled
            :param index: na ktorym indeksie czesc wspolna byla szukana 
            :param common_perm: permutacja zawierajaca informacje o czesci wspolnej
            :return: czy doszlo do jakiegokolwiek zawezenia dziedzin """

        anyChange = False
        for row in range(self.rows): # dla kazdego wiersza
            temp = []
            if common_perm[row] == type: # jesli wiersz nalezy do czesci wspolnej
                for j in range(len(self.row_perms[row])): # dla kazdej kolumny w tym wierszu
                    if self.row_perms[row][j][index] == type: # jesli tez nalezy do czesci wspolnej
                        temp.append(self.row_perms[row][j])
                if(not anyChange and temp != self.row_perms[row]):
                    anyChange = True
                self.row_perms[row] = temp # zaktualizuj czesc wspolna tego wiersza
        return anyChange

# 5. redukcja ilosci potencjalnych rozwiazan (backtracking) -----------------------------

    def find_unknown(self):
        unknown = []
        for r in range(self.rows): # dla kazdego wiersza
            for c in range(self.cols): # dla kazdej kolumny
                if self.matrix[r][c] == None:
                    unknown.append((r, c))
        return unknown

    def exclude(self, solutions, x, y, goodValue, is_cols=False):
        """
        usun z dziedziny te rozwiazania, ktore na polu (x, y) maja inna wartosc niz goodValue
        """
        if is_cols:
            # permutacje x-tej kolumny, y wiersz
            return [col for col in solutions[x] if col[y] == goodValue]
        else:
            # permutacje y wiersza, k-tej kolumny
            return [row for row in solutions[y] if row[x] == goodValue]

# 6. aktualizuje dziedziny (backtracking) -----------------------------------------------

    # zwraca True jesli da sie wywnioskowac wartosc pola (y, x) oraz zapisuje ja do matrix[y][x]
    def fix(self, x, y, rPerms, cPerms, matrix):
        firstPermValue = rPerms[y][0][x]  # x-ta kolumna, y-ty wiersz, pierwsza permutacja
        rowPermsCount = len(rPerms[y]) # ilosc permutacji danego wiersza
        
        # w kazdej permutacji rzedu wartosc pola jest taka sama
        if all(rPerms[y][k][x] == firstPermValue for k in range(rowPermsCount)):
            matrix[y][x] = firstPermValue  # ustal wartosc tego pola
            # usun te permutacje kolumn, ktore maja w tym polu inna wartosc
            cPerms[x] = self.exclude(cPerms, x, y, firstPermValue, True)
            return True
        
        # pole nie jest jednoznaczne dla wiersza - powtorz dla kolumm
        firstPermValue = cPerms[x][0][y]  # y-th column in x-th row (mirrored)
        colPermsCount = len(cPerms[x]) # ilosc permutacji danej kolumny
        
        # w kazdej permutacji rzedu wartosc pola jest taka sama
        if all(cPerms[x][k][y] == firstPermValue for k in range(colPermsCount)):
            matrix[y][x] = firstPermValue # ustal wartosc tego pola
            # usun te permutacje wierszy, ktore maja w tym polu inna wartosc
            rPerms[y] = self.exclude(rPerms, x, y, firstPermValue, False)
            return True
        
        # nic sie nie udalo wywnioskowac
        return False

    def eliminate_good_pixel(self, rPerms, cPerms, unknown_pos, matrix_l):
        """
        z listy niepewnych pol usun te, ktore beda niezamalowane i zwroc zaktualizowana liste
        """
        # petle wykonujemy tak dlugo, az przez cala petle nic nie wywnioskujemy
        while True:
            exit_loop = True
            updated_unknow_pos = deque()
            for i in range(len(unknown_pos)):
                y, x = unknown_pos[i]

                if self.fix(x, y, rPerms, cPerms, matrix_l): # pole ma jednoznaczna wartosc
                    exit_loop = False  # nadajemy polu ta wartosc i aktualizujemy dziedziny

                    # sprawdz, czy dodanie wartosci pola do rozwiazania nie psuje go
                    if not rPerms[y]:
                        return False, deque()
                    if not cPerms[x]:
                        return False, deque()
                else:
                    updated_unknow_pos.append((y, x))  # nadal nieznana wartosc pola

            unknown_pos = updated_unknow_pos

            if exit_loop:
                return True, updated_unknow_pos

# 7. rozwiazanie planszy backtrackingiem ------------------------------------------------

    def solve_backtracking(self, rPerms, cPerms, unknown_pos, matrix):
        """ rozwiazuje plansze do gry nonogram za pomoca backtrackingu """
        # sprzecznosc - zle przewidzielismy wartosc ktoregos pola
        if not self.is_correct_state(rPerms, cPerms):
            return False, []
        
        # usun ze zbioru pol niepewnych te, ktore na pewno beda niezamalowane
        result, updated_unknown_pos = self.eliminate_good_pixel(rPerms, cPerms, unknown_pos, matrix)
        if not result: # rozwiazanie okazalo sie zle
            return False, []
        
        # istnieja pola, ktorych wartosci nie znamy
        if updated_unknown_pos:
            # wybierz pierwsze z lewej gory pole, ktorego wartosci nie znamy
            y, x = updated_unknown_pos.popleft()

            # kopie dziedzin, gdy pole (x, y) jest zamalowane
            rPermsFilled = copy.copy(rPerms)
            cPermsFilled = copy.copy(cPerms)

            # kopie dziedzin, gdy pole (x, y) jest niezamalowane
            rPermsEmpty = copy.copy(rPerms)
            cPermsEmpty = copy.copy(cPerms)

            matrix[y][x] = True # zaloz, ze pole (x, y) jest zamalowane (True)
            # usun te dziedziny, ktore nie maja wartosci True na polu (x, y) 
            cPermsFilled[x] = self.exclude(cPerms, x, y, 1, True)
            rPermsFilled[y] = self.exclude(rPerms, x, y, 1, False)

            # dokonaj backtrackingu przy zalozeniu, ze (x, y) jest zamalowane (True)
            UPCopy = copy.deepcopy(updated_unknown_pos)
            result, updated_matrix = self.solve_backtracking(rPermsFilled, cPermsFilled, UPCopy, copy.copy(matrix))
            
            # dla zamalowanego pola backtracking sie udal - zwroc wynik
            if result:
                return True, updated_matrix

            # backtracking sie nie udal dla zamalowanego pola (True)
            # skoro tak, to ustal to pole jako niezamalowane (False)
            matrix[y][x] = False

            # usun te dziedziny, ktore nie maja wartosci False na polu (x, y) 
            cPermsEmpty[x] = self.exclude(cPermsEmpty, x, y, 0, True)
            rPermsEmpty[y] = self.exclude(rPermsEmpty, x, y, 0, False)

            result, updated_matrix = self.solve_backtracking(rPermsEmpty, cPermsEmpty, UPCopy, copy.copy(matrix))

            # dla niezamalowanego pola backtracking sie udal - zwroc wynik
            if result:
                return True, updated_matrix

            # zarowno zamalowanie jak niezamalowanie pola daje zly wynik -
            # blad popelniono wczesniej, cofnij sie
            return False, []

        # znaleziono rozwiazanie
        return True, matrix