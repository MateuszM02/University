//iterator - taki sam jak w zadaniu 6 ---------------------
function fib() {
    var _fib_last = 1
    var _fib_last2 = 1
    return {
        next : function() {
            let temp = _fib_last
            _fib_last += _fib_last2
            _fib_last2 = temp
            return {
                value : _fib_last,
                done : false //nieskonczony iterator
            }
        }
    }
}

//generator - taki sam jak w zadaniu 6 --------------------
function *fibG() {
    var _fib_last = 1
    var _fib_last2 = 1
    while (true) //nieskonczony generator
    {
        let temp = _fib_last
        _fib_last += _fib_last2
        _fib_last2 = temp
        yield _fib_last
    }
}

//funkcja zwracajaca n pierwszych wynikow------------------

function* take(it, top) {
    for (let index = 0; index < top; index++) {
        let v = it.next(); //zapamietujemy pare (value, done)
        if (v.done) //zabezpieczenie na wypadek, gdyby ktos chcial wziac ze skonczonego iteratora wiecej elementow, niz w nim jest
        {
            break
        } 
        yield v.value
    }
}

// zwroc dokladnie 10 wartosci z potencjalnie
// "nieskonczonego" iteratora/generatora
console.log("ITERATOR Z 10 POCZATKOWYMI WARTOSCIAMI: ")
for (let num of take( fib(), 10 ) ) {
    console.log(num)
}

//identycznie dla generatora:
console.log("GENERATOR Z 10 POCZATKOWYMI WARTOSCIAMI: ")
for (let num of take( fibG(), 10 ) ) {
    console.log(num)
}
