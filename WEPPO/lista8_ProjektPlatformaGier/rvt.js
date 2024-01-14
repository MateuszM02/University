const rvs = require("./reversi.js").rvs;

function print()
{
    let b = a.getstate().board
    for (var i = 0; i< 8; i++)
        console.log("["+b[i][0]+"|"+b[i][1]+"|"+b[i][2]+"|"+b[i][3]+"|"+b[i][4]+"|"+b[i][5]+"|"+b[i][6]+"|"+b[i][7]+"]");

    console.log("victory: " + a.getstate().victory)
}

// metoda move(gracz, pole)
//  a1 a2 a3 a4 a5 a6 a7 a8
//  b1 b2 b3 b4 b5 b6 b7 b8
//  c1 c2 c3 c4 c5 c6 c7 c8
//  d1 d2 d3 d4 d5 d6 d7 d8
//  e1 e2 e3 e4 e5 e6 e7 e8
//  f1 f2 f3 f4 f5 f6 f7 f8
//  g1 g2 g3 g4 g5 g6 g7 g8
//  h1 h2 h3 h4 h5 h6 h7 h8

//  następuje override jeśli jakiś gracz musi wykonać drugi ruch pod rząd

let a = new rvs();
a.move(0,"f5")
a.move(1,"f6")
a.move(0,"e6")
a.move(1,"d6")
a.move(0,"f7")
a.move(1,"f4")
a.move(0,"c4")
a.move(1,"e7")
a.move(0,"d7")
a.move(1,"e8")
a.move(0,"g4")
a.move(1,"h3")
a.move(0,"h4")
a.move(1,"h5")
a.move(0,"g5")
a.move(1,"g6")
a.move(0,"h6")
a.move(1,"h7")
a.move(0,"g7")
a.move(1,"c8")
a.move(0,"d8")
a.move(1,"f8")
a.move(0,"g8")
a.move(1,"h8")
a.move(0,"g3")
a.move(1,"g2")
a.move(0,"h2")
a.move(1,"h1")
a.move(0,"g1")
a.move(1,"f3")
a.move(0,"f2")
a.move(1,"f1") //override
a.move(1,"c7")
a.move(0,"c6")
a.move(1,"c5")
a.move(0,"b6")
a.move(1,"a6")
a.move(0,"e2")
a.move(1,"e1") //override
a.move(1,"c3")
print()
