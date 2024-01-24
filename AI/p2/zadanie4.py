inputPath = 'zad4_input.txt'
outputPath = 'zad4_output.txt'

import collections
import random

# Zmienne globalne

walls = set()
goals = set()
possible_pos = set()
optimal_sequence = []

def convert_seq_to_string(moves):
    res = ""
    for m in moves:
        if m == 0:
            res += "R"
        elif m == 1:
            res += "L"
        elif m == 2:
            res += "D"
        else:
            res += "U"

    return res

# sprawdza, czy osiagnelismy stan koncowy
def is_finished(possible):
    for pos in possible:
        if pos not in goals:
            return False
    return True

# wczytuje dane na temat ilosci kolumn, wierszy i stanow pol
def load():
    # zmienne globalne
    global rows, cols
    
    # wczytywanie danych z pliku
    input = open(inputPath, "r").read().split("\n")
    rows = len(input)
    cols = len(input[0])
    for i in range(rows-1):
        for j in range(cols):
            if input[i][j] == '#':
                walls.add((j, i))
            elif input[i][j] == 'G':
                goals.add((j, i))
            elif input[i][j] == 'S':
                possible_pos.add((j, i))
            elif input[i][j] == 'B':
                possible_pos.add((j, i))
                goals.add((j, i))

# Sprawdzamy stany po wykonaniu ruchu
def CheckNewStates(possible_pos, dir):
    new_pos = set()
    x_dir = [1, -1, 0, 0] # prawo, lewo, gora, dol
    y_dir = [0, 0, 1, -1]
    for pos in possible_pos:
            x = pos[0] + x_dir[dir]
            y = pos[1] + y_dir[dir]
            if (x,y) not in walls and y >= 0 and y < rows-1:
                new_pos.add((x,y))
            else:
                new_pos.add(pos)
    return new_pos

def BFS(possible, sequence):
    done = set() # zbior odwiedzonych stanow
    queue = collections.deque() # stany do przejrzenia
    queue.append((possible, sequence)) # dodaj aktualny stan do przejrzenia
    done.add(str(possible)) # zaznacz aktualny stan jako sprawdzony
    min_leng_pos = len(possible) # ilosc pozycji w najmniejszym dotychczasowym stanie

    while True: # wykonujemy BFS dopoki nie znajdziemy rozwiazania
        cur = queue.popleft() # wez pierwszy stan z kolejki
        possible = cur[0] # mozliwe pozycje w tym stanie
        sequence = cur[1] # sekwencja, ktora trzeba bylo wykonac, aby dotrzec do tego stanu

        if is_finished(possible):
            print(len(sequence))
            output = open(outputPath, "w")
            output.write(convert_seq_to_string(sequence))
            output.close()
            return 0

        for i in range(4): # dla kazdego kierunku
            new_pos = CheckNewStates(possible, i) # zdobadz nowe pozycje po pojsciu w tym kierunku
            if str(new_pos) not in done: # jesli ten stan nie zostal juz odwiedzony
                if len(new_pos) < min_leng_pos: # sprawdz, czy jest on najmniejszy ze wszystkich dotychczasowych
                    done = set() # zrestartowanie odwiedzonych stanow
                    queue.clear() # usuniecie stanow z kolejki, bo sa one gorsze od aktualnego
                    min_leng_pos = len(new_pos)
                done.add(str(new_pos))
                queue.append((new_pos, sequence + [i]))
        
# minimalizuje ilosc stanow przed wywolaniem BFSa
def MinimizeStates():
    global possible_pos, optimal_sequence
    best_length = 21372137 # dlugosc najmniejszego stanu
    best_state = set() # najmniejszy stan
    best_sequence = list() # sekwencja prowadzaca do najmniejszego stanu
    
    tests = 5000 # ile razy bedziemy szukac losowej sekwencji
    seq_length = 50 # dlugosc kazdej sekwencji testowej
    since_improvement = 0 # ile testow temu udalo sie znalezc dotychczas optymalne rozwiazanie
    limit = 50 # po ilu testow bez poprawy ma zakonczyc testowanie

    for _ in range(tests):
        cur_state = possible_pos.copy()
        cur_sequence = list()

        # znalezienie losowej sekwencji
        for _ in range(seq_length):
            rndMove = random.randint(0, 3) # losowy kierunek
            cur_state = CheckNewStates(cur_state, rndMove)
            cur_sequence.append(rndMove)
        
        # sprawdzenie, czy jest ona optymalna
        if(len(cur_state) < best_length):
            best_length = len(cur_state)
            best_state = cur_state
            best_sequence = cur_sequence
            since_improvement = 0
        else:
            since_improvement += 1
            if(since_improvement > limit): # jesli od dawna nie poczyniono postepu
                break
    possible_pos = best_state # wybierz najlepszy stan
    optimal_sequence = best_sequence#[0:best_last_changed] # oraz jego sekwencje

load() # wczytanie danych z pliku
MinimizeStates() # ile ruchow
BFS(possible_pos, optimal_sequence)