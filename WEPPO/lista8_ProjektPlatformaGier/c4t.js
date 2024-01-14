var c4 = require("./connect4").c4;

function print()
{
    var b;
    b = a.getstate().board[0]
    console.log("["+b[0]+"|"+b[1]+"|"+b[2]+"|"+b[3]+"|"+b[4]+"|"+b[5]+"|"+b[6]+"]")
    b = a.getstate().board[1]
    console.log("["+b[0]+"|"+b[1]+"|"+b[2]+"|"+b[3]+"|"+b[4]+"|"+b[5]+"|"+b[6]+"]")
    b = a.getstate().board[2]
    console.log("["+b[0]+"|"+b[1]+"|"+b[2]+"|"+b[3]+"|"+b[4]+"|"+b[5]+"|"+b[6]+"]")
    b = a.getstate().board[3]
    console.log("["+b[0]+"|"+b[1]+"|"+b[2]+"|"+b[3]+"|"+b[4]+"|"+b[5]+"|"+b[6]+"]")
    b = a.getstate().board[4]
    console.log("["+b[0]+"|"+b[1]+"|"+b[2]+"|"+b[3]+"|"+b[4]+"|"+b[5]+"|"+b[6]+"]")
    b = a.getstate().board[5]
    console.log("["+b[0]+"|"+b[1]+"|"+b[2]+"|"+b[3]+"|"+b[4]+"|"+b[5]+"|"+b[6]+"]")
    console.log("victory: "+a.getstate().victory)
}

// metoda move(gracz,kolumna)

let a = new c4;
a.move(0,5)
a.move(1,0)
a.move(0,1)
a.move(1,1)
a.move(0,2)
a.move(1,3)
a.move(0,2)
a.move(1,2)
a.move(0,3)
a.move(1,3)
a.move(0,5)
a.move(1,3)
print()
