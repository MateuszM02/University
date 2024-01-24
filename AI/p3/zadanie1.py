inputPath = "zad_input.txt"
outputPath = "zad_output.txt"

from itertools import combinations
from zadanie2 import Nonogram

# 1. operacje na plikach ----------------------------------------------------------------

# tlumaczy specyfikacje w postaci napisu liczb na tablice liczb, np. '3 2' -> [3, 2]
def StrToIntList(s):
    xs = s.split(" ") # rozbicie napisu na liste liczb w postaci napisowej
    xs = [int(elem) for elem in xs] # konwersja liczb napisowych na inty
    return xs

# wczytuje dane na temat ilosci kolumn, wierszy i wypelnionych pol
def load():
    input = open(inputPath, "r").read().strip().split("\n")
    x = input[0].split(" ")
    r = eval(x[0])
    c = eval(x[1])
    game = Nonogram(r, c)
    for rowSpec in input[1:r+1]: # dla kazdej linii specyfikacji blokow wierszow
        game.row_blocks.append(StrToIntList(rowSpec))
    for colSpec in input[r+1:]: # dla kazdej linii specyfikacji blokow kolumn
        game.column_blocks.append(StrToIntList(colSpec))
    return game

# wypisz w konsoli rozwiazanie
def draw(game):
    with open(outputPath, 'w') as file:
        out = ''
        for r in range(game.rows):
            for c in range(game.cols):
                if game.matrix[r][c] == 1: 
                    out += '#'
                else:
                    out += '.'
            out += '\n'
        file.write(out)

# 2. Inicjalizacja wartosci poczatkowych ------------------------------------------------

def init_perms(game):
    # tworzy mozliwe permutacje kazdego wiersza i kolumny
    for r in range(game.rows):
        possibilities = create_possibilities(game.cols - sum(game.row_blocks[r]), game.row_blocks[r])
        game.row_perms.append(possibilities)
    for c in range(game.cols):
        possibilities = create_possibilities(game.rows - sum(game.column_blocks[c]), game.column_blocks[c])
        game.col_perms.append(possibilities)

def are_blocks_separated(start_indexes):
    """ sprawdza, czy kolejne bloki sa ulozone jeden po drugim
        :param start_indexes: lista  """
    for i in range(1, len(start_indexes)):
        if start_indexes[i] - start_indexes[i - 1] == 1: 
            return False
    return True

def create_possibilities(empty_count, blocks):
    """ tworze wszsytkie mozliwosc wiersza lub kolumny 
        :param empty_count: liczba pustych miejsc w pasku
        :param blocks: opis blokow np. [2, 3] """
    
    blocks_count = len(blocks) # ilosc blokow
    length = empty_count + sum(blocks) # minimalna odleglosc od poczatku 1 bloku do konca ostatniego
    res = []
    for empty_spaces in combinations(range(empty_count + blocks_count), blocks_count):
        if are_blocks_separated(empty_spaces):
            res.append(normalize(empty_spaces, blocks, length))
    return res

def normalize(start_indexes, blocks, length):
    """ tworzy mozliwe rozwiazanie paska
        :param start_indexes: lista poczatkow kolejnych blokow
        :param blocks: lista blokow w pasku
        :param length: odleglosc od poczatku 1 bloku do konca ostatniego
        :return: mozliwe rozwiazanie paska """
    perm = [] # mozliwe ustawienie w danym pasku
    start = 0

    # dla kazdego bloku w pasku
    for i in range(len(start_indexes)):
        # wypelnij zerami pierwszych start pol
        while start < start_indexes[i]:
            perm.append(0)
            start += 1

        # wypelnij jedynkami kolejne n pol
        perm = perm + [1]*blocks[i]   
        start = start_indexes[i] + 1
    
    # wypelnij zerami pozostale pola na koncu
    while length > len(perm):
        perm.append(0)
    return perm

# 4. Wywolanie programu -----------------------------------------------------------------

game = load() # zaladuj dane z pliku
init_perms(game) # znajdz wszystkie mozliwe rozwiazania w kazdym wierszu/kolumnie
solved = game.solve_reasoning() # znajdz poprawne rozwiazanie korzystajac tylko z wnioskowania
if not solved:
    # znajdz poprawne rozwiazanie korzystajac tylko z nawrotow
    game.solve_backtracking(game.row_perms, game.col_perms, game.find_unknown(), game.matrix)
draw(game) # wypisz do pliku poprawne rozwiazanie
