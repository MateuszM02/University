//console.log( (![]+[])[+[]]  +  (![]+[])[+!+[]]  +  ([![]]+[][[]])[+!+[]+[+[]]]  +  (![]+[])[!+[]+!+[]] ); //zwraca "fail"

/*/1 czesc - (![]+[])[+[]]

console.log( [] ) //zwraca null (typ object)
console.log( +[] ) //zwraca 0
console.log( ![] ) //zwraca false
console.log( (![]+[]) ) //zwraca "false"
console.log( (![]+[])[+[]] ) //zwraca "f", bo mamy "false"[0]*/

/*/2 czesc - (![]+[])[+!+[]]

console.log( (![]+[]) ) //zwraca "false" (przypomnienie z linii 8)
console.log( !+[] ) //zwraca true
console.log( +!+[] ) //zwraca 1
console.log( (![]+[])[+!+[]] ) //zwraca "a", bo mamy "false"[1]*/

/*3 czesc - ([![]]+[][[]])[+!+[]+[+[]]]

console.log( [![]] ) //zwraca [false] typu object
console.log( [[]] ) //zwraca null
console.log( [][[]] ) //zwraca undefined
console.log( [![]]+[][[]] ) //zwraca "falseundefined"

console.log( [+[]] ) //zwraca [0] typu object
console.log( +[+[]] ) //zwraca 0
console.log( []+[+[]] ) //zwraca "0"
console.log( +[]+[+[]] ) //zwraca "00"
console.log( !+[]+[+[]] ) //zwraca "true0"
console.log( +!+[]+[+[]] ) //zwraca "10"
console.log( [+!+[]+[+[]]] ) //zwraca [10] typu object
console.log( ([![]]+[][[]])[+!+[]+[+[]]] ) //zwraca "i", bo mamy "falseundefined"[10]*/

//4 czesc - (![]+[])[!+[]+!+[]]

//console.log( (![]+[]) ) //zwraca "false" (przypomnienie z linii 8)
//console.log( +!+[] ) //zwraca 1 (przypomnienie z linii 15)
//console.log( []+!+[] ) //zwraca "true"
//console.log( +[]+!+[] ) //zwraca 1
//console.log( !+[]+!+[] ) //zwraca 2
//console.log( [!+[]+!+[]] ) //zwraca [2] typu object
//console.log( (![]+[])[!+[]+!+[]] ) //zwraca "l", bo mamy "false"[2]

/*Stad (![]+[])[+[]]  +  (![]+[])[+!+[]]  +  ([![]]+[][[]])[+!+[]+[+[]]]  +  (![]+[])[!+[]+!+[]] =
= "f" + "a" + "i" + "l" = "fail" */
