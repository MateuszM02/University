
//FOR-EACH--------------------------------------------
function forEach( a, f ) { //zamienia wartosci elementow in-place
    for (let index = 0; index < a.length; index++) {
        f(a[index])
    }
}

//MAP-------------------------------------------------
function map1( a, f ) { //tworzy nowa tablice w przeciwienstwie do forEach
    let a2 = []
    for (let index = 0; index < a.length; index++) {
        a2.push(f(a[index]))
    }
    return a2
}

//FILTER----------------------------------------------
function filter1( a, f ) { //takze tworzy nowa tablice jak map1
    let a2 = []
    for (let index = 0; index < a.length; index++) {
        if (f(a[index]))
            a2.push(a[index])
    }
    return a2
}

//WYNIKI WYWOLAN POSTACI (FUNCTION ...)---------------
var a = [1,2,3,4]

let fe = forEach(a, function(x) { return x * 2 })
console.log("a po forEach: " + a)
console.log("Typ zwracany przez forEach: " + fe)

let m = map1(a, function(x) { return x * 2 })
console.log("a po map (nie zmienia sie): " + a)
console.log("m - kopia a: " + m)

let fl = filter1(a, function(x) { return x <= 4 })
console.log("filter na a: " + fl)
console.log("a po filter (nie zmienia sie): " + a)

//WYNIKI WYWOLAN FUNKCJI STRZALKOWYCH-----------------

var b = [1, 2, 3, 4]

forEach( b, _ => { _ *= 2 } ) // zmienia b na [2,4,6,8] ale zwraca undefined
//forEach(a, function(x) { return x * 2 })

map1( b, _ => _ * 2 ) //zwraca [2,4,6,8], ale b pozostaje niezmienione
//map1(a, function(x) { return x * 2 })

filter1( b, _ => _ <= 4 ) // zwraca [1,2] ale b pozostaje niezmienione
//filter1(a, function(x) { return x <= 4 })
