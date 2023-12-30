=begin -------------------------------------------------------------------------------------------------

Programowanie Obiektowe
Zadanie 3, lista 8
Mateusz Mazur

=end ---------------------------------------------------------------------------------------------------

class Jawna
    def initialize(napis)
        @napis = napis
        @tablicaZnakow = napis.split('')
    end
    
    def to_s
        print @napis
    end
    
    def zaszyfruj(key)
        @code = ''
        @tablicaZnakow.each { |c|
            @code = @code + key[c]
        }
        Zaszyfrowane.new(@code)
    end
        
end

class Zaszyfrowane
    def initialize(napis)
        @napis = napis
        @tablicaZnakow = napis.split('')
    end
    
    def to_s
        print @napis
    end
    
    def odszyfruj(key)
        kluczOdwrocony = key.invert
        @decode = ''
        @tablicaZnakow.each { |c|
            @decode = @decode + kluczOdwrocony[c]
        }
        Jawna.new(@decode)
    end
end

klucz =   { 
                'a' => 'b',
                'b' => 'r',
                'r' => 'y',
                'y' => 'u',
                'u' => 'a'
            }
 
#Tworzy obiekt klasy Jawna
obiekt = Jawna.new("ruby")
 
#Szyfrujemy - obiekt 'obiekt' i zapisujemy wynik (czyli obiekt klasy Zaszyfrowane) do 'napis'
napis = obiekt.zaszyfruj(klucz)
 
#Wypisujemy napis (czyli wywolujemy metode to_s z klasy Zaszyfrowane)
napis.to_s
print "\n"
#Odszyfrujemy, od razu wypisujac (czyli wywolujemy metode to_s z klasy Jawna)
napis.odszyfruj(klucz).to_s


