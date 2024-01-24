def max_sublist_sum(lista):
    if len(lista) == 0:
        return 0
    bestSum = lista[0]
    curSum = curBegin = bestBegin = bestEnd = 0
    for i in range(len(lista)):
        if curSum + lista[i] < 0: # podlista o ujemnej sumie; ustalamy aktualny poczatek za jej koncem
            curSum = 0
            curBegin = i + 1
        else: # w p.p. aktualizujemy sume podlisty
            curSum += lista[i]
        if curSum > bestSum: # najlepsza dotychczasowa suma
            if bestSum > 0:
                bestSum = curSum
                bestBegin = curBegin
                bestEnd = i
            elif bestSum < lista[i]: # nowa najwieksza suma jest 1 liczba ujemna
                bestSum = lista[i]
                bestBegin = bestEnd = i
    return bestBegin, bestEnd

# testy
xs1 = [2, 1, 3, 7]
xs2 = [2, 1, 3, -7, 5, 4]
xs3 = [21, -15, -10, -20, 37]
onlyNegative = [-93, -26, -64, -16, -70, -32, -44, -64, -36, -84] 

assert max_sublist_sum(xs1) == (0, 3)
assert max_sublist_sum(xs2) == (4, 5)
assert max_sublist_sum(xs2[:5]) == (0, 2) # bez 4
assert max_sublist_sum(xs3) == (4, 4)
assert max_sublist_sum(xs3[:4]) == (0, 0) # bez 37
assert max_sublist_sum(xs3[1:4]) == (1, 1) # bez 21, 37: [-15, -10, -20] -> -10 (1, 1)
# dla tablicy tylko liczb ujemnych optymalna podlista jest 1 najwiekszy element (tu: -16)
assert max_sublist_sum(onlyNegative) == (3, 3)