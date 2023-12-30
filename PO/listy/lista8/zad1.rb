=begin -------------------------------------------------------------------------------------------------

Programowanie Obiektowe
Zadanie 1, lista 8
Mateusz Mazur

=end ---------------------------------------------------------------------------------------------------

class Integer
    def czynniki
        def tab
            Array.new(self) {|x| if self % (x+1) == 0 then (x+1) end}
        end
        return tab.delete_if {|x| x == nil}
    end
    
    def ack(y)
        if self == 0 then y + 1
        elsif y == 0 then (self-1).ack(1)
        else (self-1).ack(self.ack(y-1))
        end
    end
    def doskonala
        def tab
            Array.new(self.czynniki)
        end
        return self == tab.sum - self
    end
    def cyfranaslowo
        case self
        when 0 then "zero"
        when 1 then "jeden"
        when 2 then "dwa"
        when 3 then "trzy"
        when 4 then "cztery"
        when 5 then "piec"
        when 6 then "szesc"
        when 7 then "siedem"
        when 8 then "osiem"
        when 9 then "dziewiec"
        else "blad!"
        end
    end
    def slownie
        def ilecyfr
            if(self >= 10) then Math.log10(self).floor + 1
            else 1
            end
        end
        def tablicacyfr
            Array.new(ilecyfr) {|x| (self.remainder (10.pow( ilecyfr - x ))) / 10.pow(ilecyfr - x - 1)}
        end
        def zamiana
            tablicacyfr.map {|x| x.cyfranaslowo}.join(" ")
        end
        return zamiana
    end
end

=begin -------------------------------------------------------------------------------------------------
przyklady do kazdej funkcji
=end ---------------------------------------------------------------------------------------------------

print "Dzielniki 6: "
print 6.czynniki
print "\nDzielniki 13: "
print 13.czynniki
print "\nDzielniki 2022: "
print 2022.czynniki

print "\n\nCzy 6 jest doskonala? "
print 6.doskonala
print "\nCzy 22 jest doskonala? "
print 22.doskonala
print "\nCzy 28 jest doskonala? "
print 28.doskonala
print "\nCzy 45 jest doskonala? "
print 45.doskonala

print "\n\n0 slownie: "
print 0.slownie
print "\n82 slownie: "
print 82.slownie
print "\n112 slownie: "
print 112.slownie
print "\n2137 slownie: "
print 2137.slownie

=begin -------------------------------------------------------------------------------------------------
ack(1,1) = ack(0, ack(1,0)) = ack(0, ack(0,1)) = ack(0,2) = 3
=end ---------------------------------------------------------------------------------------------------
print "\n\nWartosc ack(1,1): " 
print 1.ack(1)
print "\nWartosc ack(2,1): "
print 2.ack(1)
print "\nWartosc ack(3,8): "
print 3.ack(8)
