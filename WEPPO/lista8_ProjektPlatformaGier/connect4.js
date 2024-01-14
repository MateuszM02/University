class c4
{
    turn;
    victory;
    board;
    #height;
    constructor()
    {
        this.turn=0;
        this.board = [[" "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "]];
        this.victory=0;
        this.#height = Array(7).fill(5);
    }
    move(player,position)
    {
        if (this.victory != 0)
        {
            return;
        }
        if (player != this.turn)
        {
            return;
        }
        if (position < 0 || position > 6)
        {
            return;
        }
        if (this.#height[position] < 0)
        {
            return;
        }
        let symbol = "X";
        if (player == 1)
            symbol = "O";
        this.board[this.#height[position]][position] = symbol;
        this.#checkBoard()
        this.#height[position]--;
        this.turn=(this.turn+1)%2;
        return;
    }
    #checkBoard()
    {
        for (var i = 0; i<6; i++)
        {
            for (var j=0; j<4; j++)
            {
                if (this.board[i][j]==this.board[i][j+1]&&this.board[i][j+1]==this.board[i][j+2]&&this.board[i][j+2]==this.board[i][j+3])
                {
                    if (this.board[i][j] == "X")
                    {
                        this.victory = 1;
                    }
                    if (this.board[i][j] == "O")
                    {
                        this.victory = -1;
                    }
                }
            }
        }
        for (var i = 0; i<3; i++)
        {
            for (var j=0; j<7; j++)
            {
                if (this.board[i][j]==this.board[i+1][j]&&this.board[i+1][j]==this.board[i+2][j]&&this.board[i+2][j]==this.board[i+3][j])
                {
                    if (this.board[i][j] == "X")
                    {
                        this.victory = 1;
                    }
                    if (this.board[i][j] == "O")
                    {
                        this.victory = -1;
                    }
                }
            }
        }
        for (var i = 0; i<3; i++)
        {
            for (var j=0; j<4; j++)
            {
                if (this.board[i][j]==this.board[i+1][j+1]&&this.board[i+1][j+1]==this.board[i+2][j+2]&&this.board[i+2][j+2]==this.board[i+3][j+3])
                {
                    if (this.board[i][j] == "X")
                    {
                        this.victory = 1;
                    }
                    if (this.board[i][j] == "O")
                    {
                        this.victory = -1;
                    }
                }
            }
        }
        for (var i = 0; i<3; i++)
        {
            for (var j=0; j<4; j++)
            {
                if (this.board[i+3][j]==this.board[i+2][j+1]&&this.board[i+2][j+1]==this.board[i+1][j+2]&&this.board[i+1][j+2]==this.board[i][j+3])
                {
                    if (this.board[i+3][j] == "X")
                    {
                        this.victory = 1;
                    }
                    if (this.board[i+3][j] == "O")
                    {
                        this.victory = -1;
                    }
                }
            }
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

exports.c4 = c4;
