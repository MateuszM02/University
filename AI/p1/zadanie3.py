import random

class Deck:
    def __init__(self):
        self.suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
        self.BlotkarzValues = ["2", "3", "4", "5", "6", "7", "8", "9", "10"] # opcje Blotkarza
        self.FigurantValues = ["Ace", "Jack", "Queen", "King"] # opcje Figuranta
        self.BlotkarzWins = 0 # ilosc zwyciestw Blotkarza
        self.FigurantWins = 0 # ilosc zwyciestw Figuranta
        self.reset()
                
    def shuffleB(self): # przetasuj karty Blotkarza
        random.shuffle(self.forBlotkarz)

    def shuffleF(self): # przetasuj karty Figuranta
        random.shuffle(self.forFigurant)
        
    def deal_cardB(self): # dobierz karte Blotkarzowi
        if len(self.forBlotkarz) == 0:
            return None
        return self.forBlotkarz.pop()
    
    def deal_cardF(self): # dobierz karte Figurantowi
        if len(self.forFigurant) == 0:
            return None
        return self.forFigurant.pop()
        
    def reset(self, RemoveCardPred=None): #cardsToRemove=[]): # rozpocznij od nowa gre
        self.forBlotkarz = []
        self.forFigurant = []
        for suit in self.suits: # dla kazdego koloru
            for value in self.BlotkarzValues: # dodaj opcje dla Blotkarza
                self.forBlotkarz.append([value, suit])
            for value in self.FigurantValues: # dodaj opcje dla Figuranta
                self.forFigurant.append([value, suit])

        if RemoveCardPred is not None: # usuwamy karty, ktore spelniaja warunek
            self.forBlotkarz = [card for card in self.forBlotkarz if not RemoveCardPred(card)]

        self.shuffleB()
        self.shuffleF()

    # FUNKCJE POMOCNICZE DO UKLADOW KART ################################################

    def SameColor(self, hand): # sprawdza, czy wszystkie karty sa tego samego koloru
        color = hand[0][1] == hand[1][1] == hand[2][1] == hand[3][1] == hand[4][1]
        return color

    def FiveInARow(self, hand, blot): # sprawdza, czy 5 kart jest kolejnych (tylko Blotkarz)
        if(not blot):
            return False
        indexes = []
        for i in range(5):
            indexes.append(int(hand[i][0]))
        indexes.sort()
        straight = True
        for i in range(1, 5):
            straight = straight and (indexes[i] - indexes[i-1] == 1)
        return straight

    # FUNKCJE SPRAWDZAJACE, CZY DANY GRACZ MA JAKIS UKLAD KART ##########################

    def IsPoker(self, hand, blot): # 1. sprawdza, czy karty tworza pokera (tylko Blotkarz)
        return blot and self.SameColor(hand) and self.FiveInARow(hand, blot)

    def IsQuad(self, hand, _): # 2. Sprawdza, czy 4 karty sa takie same
        hand.sort(key = lambda x: x[0])
        result = hand[1][0] == hand[2][0] == hand[3][0] # 3 srodkowe elementy posortowanej listy sa rowne
        result = result and (hand[0][0] == hand[1][0] or hand[4][0] == hand[1][0]) # przynajmniej 1 skrajny tez jest rowny
        return result

    def IsFull(self, hand, blot): # 3. sprawdza, czy istnieja trojka i para (tylko Blotkarz)
        if(not blot):
            return False
        hand.sort(key = lambda x: x[0])
        result = hand[0][0] == hand[1][0] # 1 i 2 musza byc rowne w posortowanej tablicy
        result = result and hand[3][0] == hand[4][0] # 4 i 5 tez
        result = result and (hand[1][0] == hand[2][0] or hand[2][0] == hand[3][0]) # 3 element musi byc rowny 2 lub 4
        return result
    
    def IsFlush(self, hand, blot): # 4. sprawdza, czy 5 kart jest tego samego koloru i nie nastepujacych po sobie (tylko Blotkarz)
        return blot and self.SameColor(hand) and not self.FiveInARow(hand, blot)

    def IsStraight(self, hand, blot): # 5. sprawdza, czy 5 kart jest kolejnych i co najmniej 2 roznych kolorow (tylko Blotkarz)
        return blot and not self.SameColor(hand) and self.FiveInARow(hand, blot)

    def IsThree(self, hand, _): # 6. sprawdza, czy 3 karty sa takie same
        hand.sort(key = lambda x: x[0])
        result = hand[0][0] == hand[1][0] == hand[2][0] # opcja 1,2,3
        result = result or (hand[1][0] == hand[2][0] == hand[3][0]) # opcja 2,3,4
        result = result or (hand[2][0] == hand[3][0] == hand[4][0]) # opcja 3,4,5
        return result
    
    def IsTwoPair(self, hand, _): # 7. sprawdza, czy istnieja 2 pary
        hand.sort(key = lambda x: x[0])
        pair12 = hand[0][0] == hand[1][0]
        if pair12: # opcje 1,2 & 3,4 oraz 1,2 & 4,5
            pair34 = hand[2][0] == hand[3][0] # opcja 1,2 & 3,4
            return pair34 or (hand[3][0] == hand[4][0]) # opcja 1,2 & 4,5
        else: # opcja 2,3 & 4,5
            return (hand[1][0] == hand[2][0]) and (hand[3][0] == hand[4][0])
        
    def IsOnePair(self, hand, _): # 8. sprawdza, czy istnieje para identycznych wartosci
        hand.sort(key = lambda x: x[0])
        result = hand[0][0] == hand[1][0] # opcja 1,2
        result = result or hand[1][0] == hand[2][0] # opcja 2,3
        result = result or hand[2][0] == hand[3][0] # opcja 3,4
        result = result or hand[3][0] == hand[4][0] # opcja 4,5
        return result
    
    # FUNKCJE ODPOWIEDZIALNE ZA ROZGRYWKE ################################

    def AnyoneHasState(self, b, f, state): # sprawdzamy, czy ktorys z graczy ma podany uklad
        if(state(f, False)): # czy figurant wygral
            return False
        if(state(b, True)): # czy blotkarz wygral
            return True
        return None # zaden z nich nie mial podanego ukladu

    def DidBlotkarzWin(self, Blotkarz, Figurant):
        # mozliwe uklady w kolejnosci od najlepszych do najgorszych
        f = [self.IsPoker, self.IsQuad, self.IsFull, self.IsFlush, self.IsStraight, self.IsThree, self.IsTwoPair, self.IsOnePair]
        for i in range(8):
            result = self.AnyoneHasState(Blotkarz, Figurant, f[i])
            if(result != None): # jesli ktos mial ten uklad, zwroc wynik
                return result
        return False # jesli maja ten sam uklad, to wygrywa Figurant, bo ma wyzsze karty

    def PlayGame(self, cardsToRemove=None): # losuje karty dla graczy i sprawdza, czy Blotkarz wygral
        self.reset(cardsToRemove) # tasujemy karty
        Blotkarz = []
        Figurant = []
        for _ in range(5): # rozdajemy graczom po 5 kart
            Blotkarz.append(deck.deal_cardB())
            Figurant.append(deck.deal_cardF())
        return self.DidBlotkarzWin(Blotkarz, Figurant) # sprawdzamy, kto wygral
    
    def Simulate(self, times, cardsToRemove=None): # rozgrywa times gier
        self.BlotkarzWins = 0 # ilosc zwyciestw Blotkarza
        self.FigurantWins = 0 # ilosc zwyciestw Figuranta
        for _ in range(times):
            BlotkarzWon = self.PlayGame(cardsToRemove) # zagraj gre
            if(BlotkarzWon):
                self.BlotkarzWins += 1
            else:
                self.FigurantWins += 1
        print("Blotkarz won " + str(self.BlotkarzWins) + " times")

##########################################################################

deck = Deck()
# testy posortowane rosnaco wzgledem ilosci zwyciestw Blotkarza
deck.Simulate(1000, lambda x: x[1] == 'Hearts') # bez Kierow
deck.Simulate(1000, lambda x: x[1] == 'Clubs' or x[1] == 'Spades') # bez Trefli i Win
deck.Simulate(1000) # wszystkie karty
deck.Simulate(1000, lambda x: x[0] == '2') # bez 2
deck.Simulate(1000, lambda x: int(x[0]) < 7) # tylko 7,8,9,10
deck.Simulate(1000, lambda x: int(x[0]) < 8) # tylko 8,9,10
deck.Simulate(1000, lambda x: int(x[0]) < 9) # tylko 9,10
deck.Simulate(1000, lambda x: x[1] != 'Spades') # tylko Wino (zawsze kolor)