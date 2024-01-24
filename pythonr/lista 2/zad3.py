from random import randint

def uprosc_zdanie(tekst, dl_slowa, liczba_slow):
    lista = tekst.split() # dzielimy tekst na tablice slow
    lista = list(filter(lambda elem: len(elem) <= dl_slowa, lista)) # usuwanie slow za dlugich
    ileSlow = len(lista)
    while (ileSlow > liczba_slow): # usuwaj losowe slowa dopoki jest za duzo slow
        lista.pop(randint(0, ileSlow-1))
        ileSlow -= 1
    tekst = ' '.join(lista)
    return tekst

# https://polska-poezja.pl/lista-wierszy/141-adam-mickiewicz-pan-tadeusz-inwokacja
tekst = "Litwo! Ojczyzno moja! ty jesteś jak zdrowie. \
        Ile cię trzeba cenić, ten tylko się dowie, \
        Kto cię stracił. Dziś piękność twą w całej ozdobie \
        Widzę i opisuję, bo tęsknię po tobie. \
        Panno Święta, co Jasnej bronisz Częstochowy \
        I w Ostrej świecisz Bramie! Ty, co gród zamkowy \
        Nowogródzki ochraniasz z jego wiernym ludem! \
        Jak mnie dziecko do zdrowia powróciłaś cudem \
        (Gdy od płaczącej matki pod Twoję opiekę \
        Ofiarowany, martwą podniosłem powiekę \
        I zaraz mogłem pieszo do Twych świątyń progu \
        Iść za wrócone życie podziękować Bogu), \
        Tak nas powrócisz cudem na Ojczyzny łono. \
        Tymczasem przenoś moję duszę utęsknioną \
        Do tych pagórków leśnych, do tych łąk zielonych, \
        Szeroko nad błękitnym Niemnem rozciągnionych; \
        Do tych pól malowanych zbożem rozmaitem, \
        Wyzłacanych pszenicą, posrebrzanych żytem; \
        Gdzie bursztynowy świerzop, gryka jak śnieg biała, \
        Gdzie panieńskim rumieńcem dzięcielina pała, \
        A wszystko przepasane, jakby wstęgą, miedzą \
        Zieloną, na niej z rzadka ciche grusze siedzą."

print(uprosc_zdanie(tekst, 8, 10))