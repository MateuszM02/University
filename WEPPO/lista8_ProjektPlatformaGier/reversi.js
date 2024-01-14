class rvs
{
    turn;
    victory;
    board;
    override;
    constructor()
    {
        this.turn = 0;
        this.board = [[" "," "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "," "],
                      [" "," "," ","O","X"," "," "," "],
                      [" "," "," ","X","O"," "," "," "],
                      [" "," "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "," "],
                      [" "," "," "," "," "," "," "," "]];
        this.override=-1;
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

        if (player != this.turn && player != this.override)
        {
            return;
        }
        let pos = this.#formatPosition(position);
        let result = this.#checkPosition(pos,symbol,true);
        if (result)
        {
            if (this.override == -1)
            {
                this.turn = (this.turn+1)%2;
            }
        }
        this.#checkWin();
        return;
    }
    #checkWin()
    {
        this.override = -1;
        let cx = 0;
        let co = 0;
        let can_x_move = false;
        let can_o_move = false;
        for (var i = 0; i<8; i++)
        {
            for (var j = 0; j<8; j++)
            {
                if (this.board[i][j] == "X") cx+=1;
                if (this.board[i][j] == "O") co+=1;
                let pos_string = ""+i+j;
                let res_a = this.#checkPosition(pos_string,"X",false);
                let res_b = this.#checkPosition(pos_string,"O",false);
                if (res_a == true) can_x_move = true;
                if (res_b == true) can_o_move = true;
            }
        }
        if (can_x_move && this.turn == 0) return;
        if (can_o_move && this.turn == 1) return;
        if (can_x_move || can_o_move)
        {
            if (can_o_move) this.override = 1;
            else this.override = 0;
            return;
        }
        if (cx > co)
        {
            this.victory=1;
            return;
        }
        if (co > cx)
        {
            this.victory=-1;
            return;
        }
    }
    #formatPosition(position)
    {
        let x = position[0].charCodeAt(0)-'a'.charCodeAt(0);
        let y = position[1]-'1';
        if (x<0 || x > 8 || y<0 || y>8)
            return "fail";
        else return ""+x+y;
    }

    #checkPosition(position,symbol,fill)
    {
        let x = position[0];
        let y = position[1];
        if (this.board[x][y] != " ")
            return false;
        let success = false;
        //x +y
        if (y<6)
        {
            y++;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                y++;
                while (y<8)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            y++;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                y++;
                            }
                            success = true;
                            break;
                        }
                    y++;
                }
            }
        }
        y = position[1];
        //x -y
        if (y>2)
        {
            y--;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                y--;
                while (y>-1)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            y--;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                y--;
                            }
                            success = true;
                            break;
                    }
                    y--;
                }
            }
        }
        y = position[1];
        //+x y
        if (x<6)
        {
            x++;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                x++;
                while (x<8)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            x++;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                x++;
                            }
                            success = true;
                            break;
                        }
                    x++;
                }
            }
        }
        x = position[0];
        //-x y
        if (x>2)
        {
            x--;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                x--;
                while (x>-1)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            x--;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                x--;
                            }
                            success = true;
                            break;
                        }
                    x--;
                }
            }
        }
        x = position[0];
        //+x +y
        if (y<6 && x<6)
        {
            y++;
            x++;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                y++;
                x++;
                while (y<8 && x<8)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            y++;
                            x++;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                y++;
                                x++;
                            }
                            success = true;
                            break;
                        }
                    y++;
                    x++;
                }
            }
        }
        x = position[0];
        y = position[1];
        //+x -y
        if (y>2 && x<6)
        {
            y--;
            x++;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                y--;
                x++;
                while (y>-1 && x<8)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            y--;
                            x++;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                y--;
                                x++;
                            }
                            success = true;
                            break;
                        }
                    y--;
                    x++;
                }
            }
        }
        x = position[0];
        y = position[1];
        //-x +y
        if (x>2 && y<6)
        {
            x--;
            y++;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                x--;
                y++;
                while (x>-1 && y<8)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            x--;
                            y++;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                x--;
                                y++;
                            }
                            success = true;
                            break;
                        }
                    x--;
                    y++;
                }
            }
        }
        x = position[0];
        y = position[1];
        //-x -y
        if (x>2 && y>2)
        {
            x--;
            y--;
            if (this.board[x][y] != " " && this.board[x][y] != symbol)
            {
                x--;
                y--;
                while (x>0 && y>0)
                {
                    if (this.board[x][y] == symbol)
                        {
                            let x = position[0];
                            let y = position[1];
                            x--;
                            y--;
                            while (this.board[x][y] != symbol && fill)
                            {
                                this.board[x][y] = symbol;
                                x--;
                                y--;
                            }
                            success = true;
                            break;
                        }
                    x--;
                    y--;
                }
            }
        }
        if (success && fill)
            this.board[position[0]][position[1]] = symbol;
        return success;
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

exports.rvs = rvs;
