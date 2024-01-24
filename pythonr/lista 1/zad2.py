def is_palindrom(text: str):
    text = text.lower()
    n = len(text)
    i = 0; j = n-1 # porownujemy ze soba poczatek i koniec
    while i < j:
        if (text[i] == text[j]): # jesli poczatek jest rowny koncowi, przesun je do "srodka"
            i += 1; j -= 1
        else:
            bad = [' ', ',','.','!', "?", ":", ";"]
            if (text[i] in bad): # lewy koniec jest znakiem specjalnym, ignorujemy go
                i += 1
            elif (text[j] in bad): # prawy koniec jest znakiem specjalnym, ignorujemy go
                j -= 1
            else: # oba konce sa dozwolonymi, roznymi znakami, zatem ciag nie jest palindromem
                return False
    return True

assert is_palindrom("KaJak")
assert not is_palindrom("kajmak")
assert is_palindrom("kA ja;K")