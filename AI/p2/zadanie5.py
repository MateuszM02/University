inputPath = 'zad_input.txt'
outputPath = 'zad_output.txt'

import heapq

# 1. Zmienne globalne -------------------------------------------------------------------

walls = set()
goals = set()
possible_pos = set()
distances = list() # odleglosci z kazdego pola do najblizszego celu
MULTIPLIER = 1.5 # do zadania 6 z heurystyka niedopuszczalna

# 2. Funkcje inicjalizujace wartosci ----------------------------------------------------

# wczytuje dane na temat ilosci kolumn, wierszy i stanow pol
def load():
    # zmienne globalne
    global rows, cols
    
    # wczytywanie danych z pliku
    with open(inputPath, "r") as file:
        input = [line.strip() for line in file.readlines() if line.strip()]
    rows = len(input)
    cols = len(input[0])
    for i in range(rows):
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

# oblicza szacowany koszt dotarcia z tego pola do najblizszego celu
def FindCostToClosest(pos):
        global distances
        q = []
        visited = set()
        visited.add(pos)

        heapq.heappush(q, (0, pos))
        while q:
            dist, curr_pos = heapq.heappop(q)
            x, y = curr_pos[0], curr_pos[1]

            if (x, y) in goals:
                return dist

            neighbours = [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]

            for pos in neighbours:
                x, y = pos
                if pos not in visited and (x, y) not in walls:
                    visited.add(pos)
                    heapq.heappush(q, (dist + 1, pos))

# dla kazdego pola oblicza szacowany koszt dotarcia z niego do najblizszego celu
def InitDistances():
    global distances
    distances = [[None for _ in range(cols)] for _ in range(rows)]
    for i in range(rows):
        for j in range(cols):
            if (j, i) not in walls:
                distances[i][j] = FindCostToClosest((j, i))

# 3. Weryfikacja rozwiazania ------------------------------------------------------------

# sprawdza, czy komandos na pewno doszedl do celu
def IsFinalState(possible_pos):
    for position in possible_pos:
        if position not in goals:
            return False
    return True

# Aktualizujemy mozliwe pozycje komandosa po wykonaniu ruchu
def FindNewPositions(possible_pos, dir):
    new_pos = set()
    x_dir = [1, -1, 0, 0] # prawo, lewo, gora, dol
    y_dir = [0, 0, 1, -1]
    for pos in possible_pos:
            x = pos[0] + x_dir[dir]
            y = pos[1] + y_dir[dir]
            if (x,y) not in walls:
                new_pos.add((x,y))
            else:
                new_pos.add(pos)
    return new_pos

# 4. Rozwiazanie algorytmem A* ----------------------------------------------------------

# najwiekszy koszt w potencjalnych polach komandosa
def CalcHeuristic(possible_pos, distances, seq_length):
    biggest = 0
    for pos in possible_pos:
        biggest = max(biggest, distances[pos[1]][pos[0]])
    return MULTIPLIER * biggest + seq_length

def A_Star():
    global walls, goals, possible_pos, distances
    char_moves = ['R', 'L', 'D', 'U']
    visited = set()
    q = []
    
    # ustalanie optymalnego kierunku
    hCost = CalcHeuristic(possible_pos, distances, 0)
    heapq.heappush(q, (hCost, possible_pos, '')) # koszt heurystyki, potencjalne pozycje i sekwencja
    
    ITER = 0
    while q:
        ITER += 1
        state = heapq.heappop(q) # wez z kopca stan z najmniejszym kosztem
        possible_pos = state[1] # potencjalne pozycje komandosa
        sequence = state[2] # sekwencja wykonana aby otrzymac ten stan

        if str(possible_pos) in visited: # ten stan zostal juz odwiedzony
            continue
        visited.add(str(possible_pos)) # dodaj stan do odwiedzonych

        if IsFinalState(possible_pos): # komandos doszedl do celu
            return sequence
        
        # dla kazdego kierunku: prawo, lewo, dol, gora
        for i in range(4):
            new_pos = FindNewPositions(possible_pos, i)
            new_seq = sequence + char_moves[i]
            hCost = CalcHeuristic(new_pos, distances, len(new_seq))
            heapq.heappush(q, (hCost, new_pos, new_seq)) # dodaj kazdy kierunek do kopca
    return 'L'

# 5. Wywolanie programu -----------------------------------------------------------------

load() # wczytanie danych z pliku
InitDistances() # oszacuj koszt dotarcia z kazdego pola do najblizszego celu
shortest_path = A_Star() # 17

with open(outputPath, "w") as wr:
        wr.write(shortest_path)