const ttt = {
    game: require("./tictactoe.js").ttt,
    name: "Tic Tac Toe",
    short: "ttt"
};
const cn4 = {
    game: require("./connect4.js").c4,
    name: "Connect Four",
    short: "cn4"
};
const rvs = {
    game: require("./reversi.js").rvs,
    name: "Reversi",
    short: "rvs"
};

let games = [];
games.push(ttt);
games["ttt"] = ttt;
games.push(cn4);
games["cn4"] = cn4;
games.push(rvs);
games["rvs"] = rvs;

exports.games = games;
