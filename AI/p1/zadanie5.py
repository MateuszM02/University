import re
import random

filled = '#'
empty = '.'

# wypisz w konsoli rozwiazanie
def draw():
    filepath = "zad5_output.txt"
    output = open(filepath, "w")
    for i in range(rows):
        for j in range(cols):
            if monogram[i][j] == 0:
                print(empty, end=" ")
                output.write(empty + " ")
            else:
                print(filled, end=" ")
                output.write(filled + " ")
        print()
        output.write('\n')
    output.close()

# zmien wartosc pola na przeciwna
def change(row, col):
    if  monogram[row][col] == 0:
        monogram[row][col] = 1 # wiersz
        monogram[rows+col][row] = 1 # kolumna
    else:
        monogram[row][col] = 0 # wiersz
        monogram[rows+col][row] = 0 # kolumna

# sprawdza, czy wiersz lub kolumna tablicy jest poprawna
def is_not_good(arr, specs):
    s = "^0*" + "1"*specs + "0*$" # na poczatku i na koncu moze byc dowolna ilosc zer, a w srodku ma byc specs jedynek
    return re.search(s, ''.join(str(e) for e in arr)) is None

# sprawdza, czy kolumny sa poprawne
def are_cols_good():
    for i in range(cols):
        if is_not_good(monogram[rows+i], spec[rows+i]):
            return False
    return True

# wybiera losowy rzad, ktory jest zle uzupelniony
def random_bad_row_index():
    bad_rows = []

    for i in range(rows): # dla kazdego rzedu
        if is_not_good(monogram[i], spec[i]): # jesli nie zawiera odpowiedniej ilosci jedynek
            bad_rows.append(i) # dodaj do listy zlych rzedow

    if len(bad_rows) > 0: # jesli istnieja jakies zle rzedy, wybierz losowo jeden z nich
        return bad_rows[random.randint(0, len(bad_rows)-1)]
    else:
        return -1

# wybiera losowa kolumne, ktora jest zle uzupelniona
def random_bad_col_index():
    bad_cols = []
    for i in range(rows, rows+cols): # dla kazdej kolumny
        if is_not_good(monogram[i], spec[i]): # jesli nie zawiera odpowiedniej ilosci jedynek
            bad_cols.append(i) # dodaj do listy zlych kolumn
    if len(bad_cols) > 0: # jesli istnieja jakies zle kolumny, wybierz losowo jedna z nich
        return bad_cols[random.randint(0, len(bad_cols)-1)]
    else:
        return -1

# wylicz o ile jedynek za malo/duzo zawiera wiersz/kolumna
def count_not_good(arr, sp):
    min = 0
    for i in range(len(arr)):
        if(arr[i] == 1):
            min += 1
    return abs(min - sp)

# wyszukuje optymalna kolumne do zmiany, ktore w najwiekszym stopniu poprawi sytuacje
def opt_col_to_change(index):
    minToFix = 2*len(monogram[index])+1 # minimalna ilosc pol do zmiany aby kolumna i wiersz sie zgadzaly
    opt_col = -1 # indeks kolumny, ktora najlepiej zmienic
    for i in range(len(monogram[index])): # dla kazdej kolumny w wierszu
        change(index, i)
        currToFix = count_not_good(monogram[index], spec[index]) + count_not_good(monogram[rows+i], spec[rows+i])
        if currToFix < minToFix:
            minToFix = currToFix
            opt_col = i

        change(index, i)
    return opt_col

# glowna funkcja - wybiera wiersze i kolumny do zmiany oraz decyduje, kiedy dac znak do wylosowania planszy od nowa
def run():
    count = 0
    indexOfBadRow = random_bad_row_index()

    while indexOfBadRow != -1: # dopoki istnieje niepoprawny wiersz (nie znaleziono rozwiazania)
        if count % 5 == 0:
            change(random.randint(0, rows-1), random.randint(0, cols-1))
        else: # szukamy najlepszego pola do zmiany
            opt_col = opt_col_to_change(indexOfBadRow)
            change(indexOfBadRow, opt_col)

        indexOfBadRow = random_bad_row_index() # jesli wszystkie rzedy sa poprawne, zwroc -1 i zakoncz petle
        count += 1
        if count > rows*cols*5: # jesli przekroczono limit zmian, wylosuj nowa plansze poczatkowa
            return -1

    return 0

# tworzy losowe ustawienie poczatkowe
def random_monogram():
    global monogram
    monogram = [[random.randint(0, 1) for _ in range(cols)] for _ in range(0, rows)] # na poczatku uzupelnij wiersze calkowicie losowo
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
    filepath = "zad5_input.txt"
    input = open(filepath, "r").read().split("\n")
    x = input[0].split(" ")
    rows = eval(x[0])
    cols = eval(x[1])
    for line in input[1:]:
        spec.append(eval(line))

# zmienne globalne
spec = [] # ilosc wypelnionych wierszy i kolumn
load() # wczytaj dane
monogram = [] # plansza do gry
random_monogram() # wygeneruj losowa plansze do gry
res = run() # rozpocznij uzupelnianie planszy

# dopoki nie otrzymamy poprawnej planszy, losuj nowe plansze i w nie graj
while not are_cols_good():
    draw()
    print()
    random_monogram() # losowanie nowej planszy
    res = run() # rozpocznij uzupelnianie planszy
    while res == -1: # dopoki nie rozwiazemy planszy odpowiednio szybko
        random_monogram() # losuj nowa plansze
        res = run() # zagraj od nowa

# po uzupelnieniu planszy
print("\n\n")
print(spec) # wypisz ilosc wypelnionych wierszy i kolumn
draw() # wypisz uzupelniona plansze