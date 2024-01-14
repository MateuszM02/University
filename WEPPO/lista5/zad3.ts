
// FOR-EACH --------------------------------------------------------------
function forEach<T>( a: T[],  f: (t: T) => void) : void { //zamienia wartosci elementow in-place
    for (let index = 0; index < a.length; index++) {
        f(a[index])
    }
}

// MAP -------------------------------------------------------------------
function map1<T>( a: T[], f: (t: T) => T ) : T[] { //tworzy nowa tablice w przeciwienstwie do forEach
    let a2 = []
    for (let index = 0; index < a.length; index++) {
        a2.push(f(a[index]))
    }
    return a2
}

// FILTER ----------------------------------------------------------------
function filter1<T>( a: T[], f: (t: T) => boolean ) : T[] { //takze tworzy nowa tablice jak map1
    let a2 = []
    for (let index = 0; index < a.length; index++) {
        if (f(a[index]))
            a2.push(a[index])
    }
    return a2
}

// rozne typy danych -----------------------------------------------------
var a = [1,2,3,4]
var b = ['weppo', 'algebra', 'python', 'analiza numeryczna']

// Funkcje dla typu number -----------------------------------------------

let fe = forEach(a, function(x) { console.log( x * 2 ) })

let m = map1(a, function(x) { return x * 2 })
console.log("a po map (nie zmienia sie): " + a)
console.log("m - zmodyfikowana kopia a: " + m)

let fl = filter1(a, function(x) { return x <= 2 })
console.log("filter na a: " + fl)
console.log("a po filter (nie zmienia sie): " + a)

// Funkcje dla typu string -----------------------------------------------

fe = forEach(b, function(x) { console.log( x ) })

let m2 = map1(b, function(x) { return x += "_map" })
console.log("b po map (nie zmienia sie): " + b)
console.log("m2 - zmodyfikowana kopia b: " + m2)

let fl2 = filter1(b, function(x) { return x[0] <= 'c' })
console.log("filter na b: " + fl2)
console.log("b po filter (nie zmienia sie): " + b)
