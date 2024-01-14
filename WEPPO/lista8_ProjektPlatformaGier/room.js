class room
{
    name;
    room_ID;
    ID_first;
    ID_second;
    games;
    game_name;
    game_short;
    current_game;
    players;

    constructor(games,name,id)
    {
        this.name = name;
        this.games = games;
        this.room_ID = id;
        this.players = 0;
    }

    newgame(game_short)
    {
        this.game_short = game_short;
        this.game_name = this.games[game_short].name;
        this.current_game = new this.games[game_short].game;
    }

    getstate()
    {
        return {
            board: this.current_game.getstate().board,
            name: this.game_name
        };
    }


}

exports.room =  room;
