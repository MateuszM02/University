# zakladam, ze komitet wyborczy musi byc partia a nie koalicja, dla ktorych prog to 8%

def dHondt(results, spots):
    count = len(results) # ilosc partii
    votes = [0]*count # ile glosow zdobyla kazda partia
    cur_div = [1]*count # aktualny dzielnik kazdej partii w metodzie d'Hondta

    # usuwamy z puli partie ponizej progu 5%
    voteCount = sum(results)
    required = voteCount / 20 # tyle glosow trzeba aby sie kwalifikowac
    for i in range(count):
        if (results[i] < required): # partia pod progiem
            results[i] = 0

    # przydzielanie miejsc metoda d'Hondta
    for _ in range(spots):
        best_index = 0 # indeks partii ktorej przydzielimy ten glos
        best_result = -1 # results / cur_div tej partii
        for i in range(count): # dla kazdej partii wylicz results / cur_div
            res = results[i] / cur_div[i]
            if (res > best_result):
                best_index = i
                best_result = res
        votes[best_index] += 1
        cur_div[best_index] += 1
    return votes

parties = [1000, 500, 250, 200, 50]
print(dHondt(parties, 15))