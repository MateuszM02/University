var Foo = (function() {
    let size //prywatna zmienna
    function Bar() {
        console.log(`Pole kwadratu o boku ${size} wynosi ${Qux()}`);
    }

    function Qux() { //prywatna funkcja wyliczajaca pole kwadratu
        if (size > 0)
            return size * size
        else 
            return 0
    }

    function Foo(n) 
    {
        if (n)  size = n
        else    size = 0
    }

    // Domyslnie kazda skladowa jest prywatna, zatem aby
    // upublicznic ja, nalezy dodac ja do prototypu nastepujacym sposobem:
    // Foo.prototype.[nazwa] = [nazwa]
    Foo.prototype.Bar = Bar;    // metoda publiczna
    //Foo.prototype.Qux = Qux; // metoda prywatna

    return Foo;
}());

console.log(Object.getPrototypeOf(Foo)); // to jest funkcja (na razie z pustym prototypem {})

var foo = new Foo(5); // przypisanie funkcji konstruktorowej do foo
console.log(Object.getPrototypeOf(foo)); // zwraca { Bar: [Function: Bar] }
console.log(Object.getPrototypeOf(foo.Bar));    // zwraca [Function] (na razie z pustym prototypem {})
// console.log(Object.getPrototypeOf(foo.Qux)); // to zwróciłoby błąd, bo Qux jest prywatna
foo.Bar();
// foo.Qux(); // poniewaz Qux nie jest dodana do prototypu Foo, to ma wartosc undefined w tym miejscu
