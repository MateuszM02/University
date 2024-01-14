class ttt
{
    turn;
    victory;
    board;
    constructor()
    {
        this.turn = 0;
        this.board = [[" "," "," "],[" "," "," "],[" "," "," "]];
        this.victory = 0;
    }
    move(player,position)
    {
        if (this.victory != 0)
        {
            return;
        }
        let symbol = "X";
        if (player == 1)
            symbol = "O";

        if (player != this.turn)
        {
            return;
        }
        let pos = this.#formatPosition(position)
        if (pos == "fail") return;
        if (this.board[pos[0]][pos[1]] != " ")
            return;

        this.board[pos[0]][pos[1]] = symbol;
        this.turn=(this.turn+1)%2
        this.#checkBoard();
        return;
    }
    #formatPosition(position)
    {
        let x = position[0].charCodeAt(0)-'a'.charCodeAt(0);
        let y = position[1]-'1';
        if (x<0 || x > 2 || y<0 || y>2)
            return "fail";
        else return ""+x+y;
    }
    #checkBoard()
    {
        if (this.board[0][0]==this.board[0][1]&&this.board[0][1]==this.board[0][2])
        {
            if (this.board[0][0]=="X")
                this.victory=1;
            if (this.board[0][0]=="O")
                this.victory=-1;
        }
        if (this.board[1][0]==this.board[1][1]&&this.board[1][1]==this.board[1][2])
        {
            if (this.board[1][0]=="X")
                this.victory=1;
            if (this.board[1][0]=="O")
                this.victory=-1;
        }
        if (this.board[2][0]==this.board[2][1]&&this.board[2][1]==this.board[2][2])
        {
            if (this.board[2][0]=="X")
                this.victory=1;
            if (this.board[2][0]=="O")
                this.victory=-1;
        }

        if (this.board[0][0]==this.board[1][0]&&this.board[1][0]==this.board[2][0])
        {
            if (this.board[0][0]=="X")
                this.victory=1;
            if (this.board[0][0]=="O")
                this.victory=-1;
        }
        if (this.board[0][1]==this.board[1][1]&&this.board[1][1]==this.board[2][1])
        {
            if (this.board[0][1]=="X")
                this.victory=1;
            if (this.board[0][1]=="O")
                this.victory=-1;
        }
        if (this.board[0][2]==this.board[1][2]&&this.board[1][2]==this.board[2][2])
        {
            if (this.board[0][2]=="X")
                this.victory=1;
            if (this.board[0][2]=="O")
                this.victory=-1;
        }

        if (this.board[0][0]==this.board[1][1]&&this.board[1][1]==this.board[2][2])
        {
            if (this.board[0][0]=="X")
                this.victory=1;
            if (this.board[0][0]=="O")
                this.victory=-1;
        }
        if (this.board[0][2]==this.board[1][1]&&this.board[1][1]==this.board[2][0])
        {
            if (this.board[0][2]=="X")
                this.victory=1;
            if (this.board[0][2]=="O")
                this.victory=-1;
        }
    }
    getstate()
    {
        let board = this.board,
            victory = this.victory;
        return {
            'board': board,
            'victory': victory
        }
    }
}

exports.ttt = ttt;
