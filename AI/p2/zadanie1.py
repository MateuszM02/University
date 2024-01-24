inputPath = 'zad_input.txt'
outputPath = 'zad_output.txt'
filled = '#'
empty = '.'

# wypisz w konsoli rozwiazanie
def draw():
    output = open(outputPath, "w")
    for i in range(rows):
        for j in range(cols):
            if monogram[i][j] == 1:
                #print(filled, end=" ")
                output.write(filled + " ")
            else:
                #print(empty, end=" ")
                output.write(empty + " ")
        #print()
        output.write('\n')
    output.close()

# zmien wartosc pola na przeciwna
def change(row, col, newValue):
    if(monogram[row][col] == newValue): # nie rob zmian identycznosciowych
        return
    monogram[row][col] = newValue # wiersz
    monogram[rows+col][row] = newValue # kolumna
    if(newValue == 1):
        row_empty[row] -= 1
        column_empty[col] -= 1
    if(row_empty[row] == 0):
        fill_zeros(row)
    elif(column_empty[col] == 0):
        fill_zeros(rows+col)

# sprawdza, czy wiersz lub kolumna tablicy jest poprawna
def is_not_good(arr, specs):
    blocks = list(map(int, specs.split()))
    n = len(arr)
    cur = 0
    for i in range(n):
        if(arr[i] == 1):
            cur += 1
            if(cur > blocks[0]):
                return False
        else:
            if(cur == 0):
                continue
            if(cur != blocks[0]):
                return False
            cur = 0
            blocks.pop(0)
    if(cur > 0):
        return cur == blocks[0]
    return len(blocks) == 0

# sprawdza, czy wiersze sa poprawne
def are_rows_good():
    for i in range(rows): # dla kazdego wiersza
        if is_not_good(monogram[i], spec[i]):
            return False
    return True

# sprawdza, czy kolumny sa poprawne
def are_cols_good():
    for i in range(cols): # dla kazdej kolumny
        if is_not_good(monogram[rows+i], spec[rows+i]):
            return False
    return True

# oblicza najwczesniejsze mozliwe indeksy poczatku blokow
def calcP(blocks):
    p = [0 for _ in range(len(blocks))]
    for i in range(1, len(blocks)):
        p[i] = p[i-1] + blocks[i-1] + 1
    return p

# oblicza najpozniejsze mozliwe indeksy konca blokow
def calcK(blocks, k0):
    k = [0 for _ in range(len(blocks))]
    k[0] = k0
    for i in range(1, len(blocks)):
        k[i] = k[i-1] + blocks[i] + 1
    return k

# zwraca pierwszy indeks >= begin, ktorego wartosc jest rowna goodValue
def find_first_good(index, begin, IsItRow, goodValueF):
    row = index if IsItRow else 0
    col = 0 if IsItRow else index-rows
    if(IsItRow):
        for c in range(begin, cols): # dla kazdej kolumny w wierszu
            if(goodValueF(monogram[row][c])):
                return begin
            else:
                begin += 1
    else:
        for r in range(begin, rows): # dla kazdego wiersza w kolumnie
            if(goodValueF(monogram[r][col])):
                return begin
            else:
                begin += 1

# wyzeruj wszystkie pola, ktore nie naleza do zadnego przedzialu
def remove_empty_intervals(intervals, index):
    last = 0
    current = 0
    for i in range(1, len(intervals)): # dla kazdego przedzialu
        current = intervals[i][0] # poczatek aktualnego przedzialu
        last = intervals[i-1][1] # koniec poprzedniego przedzialu
        for j in range(last+1, current): # wyzeruj kazde pole pomiedzy
            if(index < rows): # to jest rzad
                change(index, j, 0)
            else:
                change(j, index-rows, 0) # to jest kolumna
    return intervals

# zwieksza indeks poczatkowy przedzialow, jesli pierwsza wartosc jest niepoprawna
def move_interval_start(xs, index, n, IsItRow):
    b0 = 0
    begin = 0
    while(begin < n):
        begin = find_first_good(index, b0, IsItRow, lambda x : x != 0)
        if(begin is None):
            return xs
        elif(b0 != begin): # jakies pole jest wyzerowane
            for i in range(len(xs)): # dla kazdego bloku
                xs[i] = (max(xs[i][0], begin), xs[i][1]) # przesun poczatek
        begin += 1
        b0 = begin
    return xs

# zwieksza indeks poczatkowy przedzialow, jesli pierwsza wartosc jest niepoprawna
def move_interval_end(intervals, blocks, index, n, IsItRow):
    start = find_first_good(index, 0, IsItRow, lambda x : x == 1)
    if(start is None): # nie ma jedynek w rzedzie/kolumnie
        return intervals
    for i in range(len(intervals)): # dla kazdego przedzialu
        if(intervals[i][0] > start or intervals[i][1] < start): # poza przedzialem
            return intervals
        koniec = blocks[i] - 1
        for j in range(max(0, start), min(koniec+1, n)): # gwarantowane pola
            if(IsItRow and monogram[index][j] is None):
                change(index, j, 1)
                heuristic[index] += 1
            elif(not IsItRow and monogram[j][index-rows] is None):
                change(j,index-rows,1)
                heuristic[index] += 1
    return intervals

# tworzy przedzialy, w ktorych znajduja sie kolejne bloki wiersza/kolumny
def create_intervals(index, blocks):
    # zmienne
    s = sum(blocks) # suma dlugosci blokow
    b = len(blocks) # ilosc blokow
    IsItRow = index < rows
    n = cols if IsItRow else rows # dlugosc wiersza/kolumny

    # znajdz poczatki i konce przedzialow
    p = calcP(blocks)
    k = calcK(blocks, n+blocks[0]-s-b)
    xs = list(zip(p, k))

    # zaktualizuj poczatki przedzialow na podstawie wyzerowanych pol
    xs = move_interval_start(xs, index, n, IsItRow)
    xs = move_interval_end(xs, blocks, index, n, IsItRow)

    # wyzeruj pola, ktore sa pomiedzy przedzialami
    xs = remove_empty_intervals(xs, index)
    return xs

# wypelnia zerami wszystkie niezamalowane pola
def fill_zeros(index):
    IsItRow = index < rows
    if(IsItRow):
        for c in range(cols):
            if(monogram[index][c] != 1):
                change(index, c, 0)
    else:
        for r in range(rows):
            if(monogram[r][index-rows] != 1):
                change(r, index-rows, 0)

# zamalowuje pola danego wiersza/kolumny
def fill_correct(index, specs):
    IsItRow = index < rows
    n = cols if IsItRow else rows # dlugosc wiersza/kolumny
    heuristic[index] = -1 # oznacz jako sprawdzona
    blocks = list(map(int, specs[index].split())) # dlugosci blokow
    
    # przedzialy kolejnych blokow
    intervals = create_intervals(index, blocks)
    0
    for i in range(len(blocks)): # dla kazdego bloku
        L = intervals[i][1] - intervals[i][0] + 1 # dlugosc przedzialu
        start = L + intervals[i][0] - blocks[0]
        koniec = intervals[i][0] + blocks[0] - 1
        for j in range(max(0, start), min(koniec+1, n)): # gwarantowane pola
            if(IsItRow and monogram[index][j] is None):
                change(index, j, 1)
                heuristic[index] += 1
            elif(not IsItRow and monogram[j][index-rows] is None):
                change(j,index-rows,1)
                heuristic[index] += 1

# wyznacza priorytet danego wiersza/kolumny
def calc_heuristic(index, specs):
    block = specs[index].split()
    sum = 0#len(block) - 1
    for j in range(len(block)):
        sum += int(block[j])
    return sum

# inicjalizuje heurystyke ktora okresla, w ktorym rzedzie jest najwieksza szansa na zmiane
def init_heuristic():
    global heuristic
    heuristic = [calc_heuristic(i,spec) for i in range(rows+cols)]

# tworzy ustawienie poczatkowe
def create_monogram():
    global monogram, row_empty, column_empty
    init_heuristic()
    row_empty = [heuristic[i] for i in range(rows)] # ile pol w danym wierszu ma nieznana wartosc
    column_empty = [heuristic[i+rows] for i in range(cols)] # ^ w danej kolumnie ^
    monogram = [[None for _ in range(cols)] for _ in range(rows)] # na poczatku uzupelnij wiersze zerami
    mono_vert = [] # dla kolumn

    for i in range(cols):
        to_add = []
        for row in monogram:
            to_add.append(row[i])
        mono_vert.append(to_add)
    monogram.extend(mono_vert) # przepisz to samo z perspektywy kolumn

# wczytuje dane na temat ilosci kolumn, wierszy i wypelnionych pol
def load():
    global rows, cols, spec
    input = open(inputPath, "r").read().split("\n")
    x = input[0].split(" ")
    rows = eval(x[0])
    cols = eval(x[1])
    for line in input[1:]:
        spec.append(line)

# wybiera indeks optymalnego wiersza/kolumny do poprawy
def optimal_index():
    max_value = -1
    index = -1
    for i in range(rows): # dla wierszy
        if(row_empty[i] > 0 and heuristic[i] > max_value):
            index = i
            max_value = heuristic[i]
    for i in range(cols): # dla kolumn
        if(column_empty[i] > 0 and heuristic[rows+i] > max_value):
            index = rows+i
            max_value = heuristic[rows+i]
    return index

# glowna funkcja - wybiera wiersze i kolumny do zmiany oraz decyduje, kiedy dac znak do wylosowania planszy od nowa
def run():
    indexOfBadRow = optimal_index()

    while indexOfBadRow != -1: # dopoki istnieje niepoprawny wiersz (nie znaleziono rozwiazania)
        fill_correct(indexOfBadRow, spec)
        indexOfBadRow = optimal_index() # jesli wszystkie rzedy sa poprawne, zwroc -1 i zakoncz petle

    return 0

# zmienne globalne
spec = [] # ilosc wypelnionych wierszy i kolumn
load() # wczytaj dane
create_monogram() # tworzy plansze do gry
res = run() # rozpocznij uzupelnianie planszy

# po uzupelnieniu planszy
print("\n\n")
print(spec) # wypisz ilosc wypelnionych wierszy i kolumn
draw() # wypisz uzupelniona plansze
