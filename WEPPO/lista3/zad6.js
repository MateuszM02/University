//iterator-------------------------------------------------
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

var foo = { //iterator nieskonczony
    [Symbol.iterator] : fib
}

console.log("WYNIKI ITERATORA: ")
for ( var f of foo )
{
    console.log(f)
    if (f > 1000) //dla celow prezentacyjnych limit
    {
        break
    }
}

//generator------------------------------------------------
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

var goo = { //generator nieskonczony
    [Symbol.iterator] : fibG
}

for ( var f of goo )
{
    console.log(f)
    if (f > 1000) //dla celow prezentacyjnych limit
    {
        break
    }
}
