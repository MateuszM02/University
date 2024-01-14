//memoizacja
function memoize(fn: Function) {
    let cache: number[] = [];
    return function(n: number) {
        if ( n in cache) {
            return cache[n]
        } else {
            var result = fn(n);
            cache[n] = result;
            return result;
        }
    }
}

//rekurencja z memoizacja
//function MezFib(n: number) : number - NIE DZIALA, bo nie mozemy nadpisac funkcji w linijce 24
var MezFib = function(n: number) : number
{
    if(n <= 1) return 1
    else return MezFib(n - 1) + MezFib(n - 2)
}

//zapelnianie cache
MezFib = memoize(MezFib);

console.log("45 liczba Fibonacciego: " + MezFib(45));
console.log("45 liczba Fibonacciego: " + MezFib(45));
