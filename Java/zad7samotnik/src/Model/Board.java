package Model;

import java.io.*;

public class Board implements Serializable
{
    // stan pola na planszy
    public enum Field
    {
        Outside, // poza plansza, element tla
        Empty, // nalezy do planszy, ale nie ma na nim pionka
        Taken // nalezy do planszy i jest na nim pionek
    }

    // Stan aktualnej gry
    public enum State 
    {
        Playing, // w trakcie gry
        Won, // wygrana
        Lost // przegrana
    }

    public static final int size = 7;
    public static final String filename = "solitaire.ser";

    public State state;
    public Field[][] board;
    public boolean isEnglish;
    public int selectedX;
    public int selectedY;

    public Board()
    {
        this(true);
    }
    public Board(boolean english)
    {
        Board lastGame = Controller.BoardController.GetFromFile();
        if ( lastGame != null ) // zainicjalizuj z pliku jesli istnieje
        {
            this.isEnglish = lastGame.isEnglish;
            this.state = lastGame.state;
            this.selectedX = lastGame.selectedX;
            this.selectedY = lastGame.selectedY;
            this.board = lastGame.board;
            return;
        }
        isEnglish = english;
        state = State.Playing;
        selectedX = 2;
        selectedY = 3;
        board = new Field[size][size];
        for (int y = 0; y < size; y++) // rzad
        {
            for (int x = 0; x < size; x++) // kolumna
            {
                if ( Controller.BoardController.InitSpotExists(isEnglish, x, y) )
                    board[x][y] = Field.Taken;
                else
                    board[x][y] = Field.Outside;   
            }    
        }
        board[3][3] = Field.Empty;
    }
}