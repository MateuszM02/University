//wersja iteracyjna (jak ostatnio)
function iter_Fib(n)
{
    let act = 1;
    let prev = 1;
    while(n > 1)
    {
        let temp = act;
        act += prev;
        prev = temp;
        n--;
    }
    return act;
}

//wersja rekurencyjna (jak ostatnio)
function rec_Fib(n)
{
    if(n <= 1) return 1
    else return rec_Fib(n - 1) + rec_Fib(n - 2)
}

//memoizacja
function memoize(fn) {
    var cache = {}
    return function(n) {
        if ( n in cache ) {
            return cache[n]
        } else {
            var result = fn(n)
            cache[n] = result
            return result
        }
    }
}

//rekurencja z memoizacja
function MezFib(n)
{
    if(n <= 1) return 1
    else return MezFib(n - 1) + MezFib(n - 2)
}

let start = 35
let koniec = 40

//wersja rekurencyjna z memoizacja
var MezFib = memoize(MezFib) //dynamiczne przeksztalcanie funkcji

//porownanie
for (let index = start; index <= koniec; index++) {
    console.log("\nn = " + index)
    timePassed(index, "ITERACJA", iter_Fib)
    timePassed(index, "REKURENCJA Z MEMOIZACJA - PIERWSZE WYWOLANIE", MezFib)
    timePassed(index, "REKURENCJA Z MEMOIZACJA - KAZDE KOLEJNE", MezFib)
    timePassed(index, "REKURENCJA", rec_Fib)
}

function timePassed(i, str, f)
{
    console.log(str)
    console.time()
    f(i)
    console.timeEnd()
}
