inputPath = 'zad2_input.txt'
outputPath = 'zad2_output.txt'

from collections import deque

# 1. Zmienne globalne -------------------------------------------------------------------

legalSpots = set() 
""" puste pola, na ktorych mozna postawic skrzynke tak, aby dalo sie ja przesunac """
illegalSpots = set()
""" puste pola, na ktorych nie mozna postawic skrzynki, bo trafi do slepego zaulka """
walls = set()
""" zbior pozycji, na ktorych znajduja sie sciany """
goals = set()
""" zbior pozycji docelowych dla skrzynek """
warehouseman = (-1, -1)
""" aktualna pozycja magazyniera """
crates = set()
""" zbior pozycji, w ktorych znajduja sie skrzynki """
optimal_sequence = list()
""" sekwencja prowadzaca do ustawienia skrzynek na pozycjach docelowych """

x_dir = [1, -1, 0, 0] # prawo, lewo, dol, gora
y_dir = [0, 0, 1, -1]

# 2. Operacje na plikach ----------------------------------------------------------------

def convert_seq_to_string(moves):
    """ zamienia liste liczb na napis oznaczajacy sekwencje """
    res = ""
    for m in moves:
        if m == 0: # prawo
            res += "R"
        elif m == 1: # lewo
            res += "L"
        elif m == 2: # dol
            res += "D"
        else: # gora
            res += "U"
    return res

def load():
    """ wczytuje dane na temat ilosci kolumn, wierszy i stanow pol """
    # zmienne globalne
    global rows, cols, warehouseman
    
    # wczytywanie danych z pliku
    input = open(inputPath, "r").read().strip().split("\n")
    rows = len(input)
    cols = len(input[0])
    for i in range(rows):
        for j in range(cols):
            if input[i][j] == '.':
                legalSpots.add((j, i))
            elif input[i][j] == 'W':
                walls.add((j, i))
            elif input[i][j] == 'K':
                legalSpots.add((j, i))
                warehouseman = (j, i)
            elif input[i][j] == 'G':
                legalSpots.add((j, i))
                goals.add((j, i))
            elif input[i][j] == 'B':
                legalSpots.add((j, i))
                crates.add((j, i))
            elif input[i][j] == '*':
                legalSpots.add((j, i))
                crates.add((j, i))
                goals.add((j, i))
            elif input[i][j] == '+':
                legalSpots.add((j, i))
                goals.add((j, i))
                warehouseman = (j, i)

# 3. Weryfikacja stanu gry --------------------------------------------------------------

def is_finished(crates_pos):
    """ sprawdza, czy osiagnelismy stan koncowy
       :param crates_pos: zbior pozycji skrzynek """
    for pos in crates_pos:
        if pos not in goals:
            return False
    return True

def is_pos_illegal(pos):
    """ sprawdza, czy dana pozycja jest mozliwa pozycja magazyniera/skrzynki """
    return pos[0] < 0 or pos[0] >= cols or pos[1] < 0 or pos[1] >= rows or pos in walls

def is_crate_dead(pos):
    """ sprawdza, czy skrzynka jest w martwej pozycji 
        :param pos: pozycja skrzynki
        :return: True jesli skrzynka jest w martwej pozycji, False w p.p."""
    if pos in illegalSpots and pos not in goals:
        return True
    return False

# Sprawdzamy, czy nowy stan nie jest martwy
def is_state_legal(warPos, cratesPos, dir):
    """ sprawdza, czy pojscie w danym kierunku nie tworzy martwego stanu
        :param warPos: pozycja magazyniera przed ruchem
        :param cratesPos: zbior pozycji skrzynek w aktualnym stanie
        :param dir: kierunek, w ktorym magazynier chce pojsc: 0-3 RLDU
        :return: False jesli nowy stan jest martwy, True w p.p. """
    
    # pozycja magazyniera po wykonaniu ruchu
    x = warPos[0] + x_dir[dir]
    y = warPos[1] + y_dir[dir]
    pos1 = (x, y)

    # sprawdzamy, czy magazynier nie probuje pojsc w sciane - martwy stan
    if pos1 in walls:
        return False

    # sprawdzamy, czy magazynier nie probuje popchnac 2 skrzynek naraz - martwy stan
    pos2 = (x + x_dir[dir], y + y_dir[dir])
    if pos1 in cratesPos and pos2 in cratesPos: # nie mozna pchac 2 skrzynek naraz
        return False
    
    # sprawdzamy, czy magazynier nie probuje popchnac skrzyni na sciane - martwy stan
    if pos1 in cratesPos and pos2 in walls:
        return False
    
    # sprawdzamy, czy magazynier nie probuje popchnac skrzyni w slepy zaulek - martwy stan
    if pos1 in cratesPos and pos2 in illegalSpots:
        return False

    return True

def delegalize_spot(spot):
    legalSpots.remove(spot)
    illegalSpots.add(spot)

def find_illegal_spots():
    """ weryfikuje kazda mozliwa pozycje skrzynki i delegalizuje te, 
        ktore sa martwymi stanami"""
    toDelegalize = set()
    # znajdz nielegalne pozycje
    for pos in legalSpots: # weryfikujemy kazda mozliwa pozycje skrzynek
        if pos in goals: # pozycja docelowa zawsze jest dobra pozycja
            continue
        illegal_dirs = [] # kierunki, ktore blokuja skrzynke
        for dir in range(4): # sprawdz kazdy kierunek
            new_pos = (pos[0] + x_dir[dir], pos[1] + y_dir[dir])
            if is_pos_illegal(new_pos):
                illegal_dirs.append(dir)
        if len(illegal_dirs) > 2:
            toDelegalize.add(pos)
        elif len(illegal_dirs) == 2:
            if 0 in illegal_dirs or 1 in illegal_dirs: # prawo/lewo
                if 2 in illegal_dirs or 3 in illegal_dirs: # dol/gora
                    toDelegalize.add(pos)
    # zdelegalizuj zle pozycje
    for pos in toDelegalize:
        delegalize_spot(pos)

# 4. Przeszukiwanie stanow gry ----------------------------------------------------------

def Move(warPos, cratesPos, sequence, dir):
    """ Wykonuje ruch magazyniera w podanym kierunku
        :param warPos: pozycja magazyniera przed ruchem
        :param cratesPos: zbior pozycji skrzynek przed ruchem
        :param sequence: sekwencja ruchow magazyniera wymagana do osiagniecia tego stanu
        :param dir: kierunek, w ktorym magazynier wykona ruch
        :return: nowy stan gry po wykonaniu ruchu """
    
    # wykonaj ruch magazynierem
    x = warPos[0] + x_dir[dir]
    y = warPos[1] + y_dir[dir]
    newPos = (x, y) # nowa pozycja magazyniera

    # popchnij 1 skrzynke jesli jest na nowym polu magazyniera
    if newPos in cratesPos:
            cratesPos.remove(newPos)
            cratesPos.add((x + x_dir[dir], y + y_dir[dir])) # przesun skrzynke
    
    # dodaj ten ruch do sekwencji
    sequence = sequence + [dir]

    # zwroc nowy stan
    return newPos, cratesPos, sequence

def BFS():
    states_checked = 0
    done = set() # zbior odwiedzonych stanow
    queue = deque() # stany do przejrzenia
    queue.append((warehouseman, crates, optimal_sequence)) # dodaj aktualny stan do przejrzenia
    done.add(str((warehouseman, crates))) # zaznacz aktualny stan jako sprawdzony

    while queue: # wykonujemy BFS dopoki nie znajdziemy rozwiazania
        states_checked += 1
        cur = queue.popleft() # wez pierwszy stan z kolejki
        warPos = cur[0] # pozycja magazyniera w tym stanie
        cratesPos = cur[1].copy() # pozycje skrzyni w tym stanie
        sequence = list(cur[2]) # sekwencja, ktora trzeba bylo wykonac, aby dotrzec do tego stanu

        if is_finished(cratesPos):
            print(len(sequence))
            output = open(outputPath, "w")
            output.write(convert_seq_to_string(sequence))
            output.close()
            return states_checked

        for i in range(4): # dla kazdego kierunku
            can_go = is_state_legal(warPos, cratesPos, i) # sprawdz, czy mozna pojsc w tym kierunku
            if can_go: # jesli tak
                new_state = Move(warPos, cratesPos.copy(), list(sequence), i) # pojdz tam i stworz nowy stan
                newWarPos = new_state[0] # nowa pozycja magazyniera
                newCratesPos = new_state[1].copy() # nowe pozycje skrzynek
                newSequence = list(new_state[2]) # nowa sekwencja
                if str((newWarPos, newCratesPos)) not in done: # jesli ten stan nie zostal juz odwiedzony
                    done.add(str((newWarPos, newCratesPos)))
                    queue.append((newWarPos, newCratesPos, newSequence))
    return states_checked

# 5. wywolanie funkcji ------------------------------------------------------------------

load() # wczytanie danych z pliku
find_illegal_spots() # znajdz, ktore pozycje skrzynek zawsze tworza martwy stan
BFS()