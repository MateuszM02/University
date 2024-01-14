const ttt = require("./tictactoe.js").ttt;

function print()
{
    let b = a.getstate().board
    console.log(b[0])
    console.log(b[1])
    console.log(b[2])
    console.log("victory: " + a.getstate().victory)
}

// metoda move(gracz, pole)
//  a1 a2 a3
//  b1 b2 b3
//  c1 c2 c3

let a = new ttt();
a.move(0,"b3")
a.move(1,"b2")
a.move(0,"a3")
a.move(1,"a2")
a.move(0,"c1")
a.move(1,"c2")
print()
