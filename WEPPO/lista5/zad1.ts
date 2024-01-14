/* 
instalacja kompilatora TypeScript: npm install -g typescript
kompilacja i uruchamianie pliku w TypeScript: ts-node zad1.ts
kompilacja z TypeScript do JavaScript: tsc zad1.ts (tworzy to nowy plik zad1.js, jesli jeszcze nie istnieje)
niejawna kompilacja w trybie watch: tsc -w
na biezaco aktualizuje ona zmiany w zarowno w pliku .ts jak i .js
tryb watch opuszcza sie za pomoca CTRL + C

roznica miedzy 'tsc' a 'ts-node'
'tsc' kompiluje plik .ts do pliku .js BEZ uruchamiania go
'ts-node' kompiluje ORAZ uruchamia plik .ts BEZ konwersji do .js 
*/

console.log("'tsc' doesn't write it but 'ts-node' does");
console.log("after breakpoint");

//przyklad z wykladu translacji danych .ts -> .js
enum Direction { //wersja w .ts
    Left, 
    Right,
    Up,
    Down
}    

// jest przetlumaczona do .js jako:
var Direction;
(function (Direction) {
    Direction[Direction["Left"] = 0] = "Left";
    Direction[Direction["Right"] = 1] = "Right";
    Direction[Direction["Up"] = 2] = "Up";
    Direction[Direction["Down"] = 3] = "Down";
})(Direction || (Direction = {}));
