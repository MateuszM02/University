//obiekt czlowiek z 3 polami
let czlowiek = {
    imie: "Jan",
    nazwisko: "Kowalski",
    wiek: 42,
}

//roznica miedzy . a []
console.log(czlowiek.wiek) //42
console.log(czlowiek['wiek']) //tez 42, ale trzeba podac argument wewnatrz [] jako string
    //console.log(czlowiek.'wiek') //blad!
    //console.log(czlowiek[wiek]) //blad!

//typ argumentu [] obiektu inny niz string
    //console.log(czlowiek[wiek]) //dla liczby jest blad Uncaught ReferenceError: wiek is not defined
//console.log(czlowiek[czlowiek]) //dla innego obiektu nie ma bledu, ale wynikiem jest undefined

let weekend = ['sobota', 'niedziela']
//typ argumentu [] tablicy inny niz liczba
//console.log(weekend['Jan']) //dla napisu mamy znowu undefined
//console.log(weekend[czlowiek]) //dla obiektu mamy rowniez undefined

weekend['invalid_index'] = 'naPewnoNiePoniedzialek' //zostanie to zignorowane
weekend.forEach(element => {
    console.log(element)
});

/* 
Czy i jak zmienia się zawartość tablicy jeśli zostanie do niej dopisana właściwość pod kluczem, który nie jest liczbą?
    Nie zmienia sie, jest taka wartosc ignorowana

Czy można ustawiać wartość atrybutu length tablicy na inną wartość niż liczba elementów w tej tablicy? 
    TAK, nawet na wartosci ujemne, ale jest to niezalecana praktyka
Co się dzieje jeśli ustawia się wartość mniejszą niż liczba elementów?
    Tablica jest zmniejszana do podanego rozmiaru, a ostatnie jej elementy usuwane
A co jeśli ustawia się wartość większą niż liczba elementów? 
    parametr .length zmienia sie, ale realna ilosc elementow nie, wiec odwolujac sie do indeksow teoretycznie dodanych otrzymujemy undefined
*/
let rodzajeZajec = ['wyklad', 'cwiczenia', 'pracownia', 'repetytorium', 'seminarium'] //rodzajeZajec.length = 5
rodzajeZajec.length = 10 //zwiekszamy .length z 5 do 10

/*console.log("nowa dlugosc tablicy: " + rodzajeZajec.length) //wypisze 10
console.log("6 element tablicy rodzajeZajec: " + rodzajeZajec[5]) //undefined
rodzajeZajec.forEach(element => {
    console.log(element) //wypisze 5 elementow pomimo zmiany wartosci .length
});*/

rodzajeZajec.length = 3 //zmniejszamy .length z 10 do 3
/*
console.log("nowa dlugosc tablicy: " + rodzajeZajec.length) //wypisze 3
console.log("4 element tablicy rodzajeZajec: " + rodzajeZajec[3]) //undefined, pomimo, ze wczesniej byla tam wartosc 'repetytorium'
rodzajeZajec.forEach(element => {
    console.log(element) //wypisze 3 elementy bez 2 ostatnich, ktore zostaly usuniete przy zmianie .length na 3
});*/
