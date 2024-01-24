# Krok 1. Wczytanie listy slow

#dict = 'polish_words.txt'
dict = 'words_for_ai1.txt'
with open(dict, 'r', encoding='utf-8') as f:
    S = set(word.strip() for word in f)

# Krok 2. Wczytanie ciagu znakow

with open('zad2_input.txt', 'r', encoding='utf-8') as f:
    lines = [line.strip() for line in f]

# Krok 3. Szukanie optymalnego podzialu

def findWords(text, S):
    n = len(text)
    allWords = []
    # Szukamy wszystkich slow rozpoczynajacych sie od danej litery
    for i in range(n):
        iWords = []
        for j in range(i, n):
            word = text[i:j+1]
            if word in S:
                iWords.append(word)
        allWords.append(iWords)

    # dynamiczne wyszukiwanie najlepszego ciagu slow
    bestWord = [''] * n # najlepszy ciag slow
    bestValue = [] # suma kwadratow najlepszych slow
    for begin in range(n):
        bestValue.append(0)
    for begin in range(n): # dla kazdej pozycji begin szukamy najlepszego ciagu, ktory da sie utworzyc z liter od 0 do begin
        for i in range(len(allWords[begin])): # dla kazdego slowa, ktore zaczyna sie od tej litery
            word = allWords[begin][i]
            ValueSoFar = len(word) ** 2 + bestValue[begin] # oblicz wartosc slowa - kwadrat jego dlugosci
            for next in range(begin+len(word)-1, n): # ustalamy, ze poki co ciag ten jest optymalny dla kazdego k >= begin + len(word)
                if(len(word) > 1 and ValueSoFar > bestValue[next]):
                    bestValue[next] = ValueSoFar
                    bestWord[next] = bestWord[begin] + ' ' + word
    return bestWord[n-1]

# Krok 4 Wywolanie szukania optymalnego podzialu

with open('zad2_output.txt', 'w', encoding='utf-8') as f:
    for line in lines:
        reconstructed = findWords(line, S)
        f.write(reconstructed + '\n')
