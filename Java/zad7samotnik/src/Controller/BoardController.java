package Controller;

import java.io.*;

public abstract class BoardController
{
    // 1. Czy pole o wspolrzednych (x, y) jest legalnym polem na planszy --------------------------
    public static boolean InitSpotExists(boolean english, int x, int y)
    {
        double distFromCenter = Math.pow(x - 3, 2) + Math.pow(y - 3, 2);
        boolean distLE10 = distFromCenter <= 10;
        if (!english) // wersja Europejska - wystarczy ze dystans od srodka jest <= 10
            return distLE10;
        // wersja Angielska - oprocz tego dystans musi byc rozny od 8
        return distLE10 && distFromCenter != 8;
    }
    
    // 2. Zwraca pole board[x][y] jesli nalezy do planszy lub null w p.p. -------------------------
    public static Model.Board.Field BoardAt(Model.Board game, int x, int y)
    {
        try 
        {
            Model.Board.Field temp = game.board[x][y];
            return temp;
        } 
        catch (Exception e) 
        { 
            return Model.Board.Field.Outside;
        }
    }

    // 3. Sprawdza, czy mozna wykonac dany ruch ---------------------------------------------------
    private static boolean IsLegalMove(Model.Board game, int xold, int yold, int xnew, int ynew)
    {
        int xdist = Math.abs(xold - xnew);
        int ydist = Math.abs(yold - ynew);
        // nielegalny ruch - nie jest to przeskoczenie ponad 1 polem
        if (xdist + ydist != 2 || xdist == 1)
            return false;
        // nielegalny ruch - pole poczatkowe nie istnieje lub nie zawiera pionka
        else if (BoardAt(game, xold, yold) != Model.Board.Field.Taken)
            return false;
        // nielegalny ruch - pole docelowe nie istnieje lub zawiera pionek
        else if (BoardAt(game, xnew, ynew) != Model.Board.Field.Empty)
            return false;
        // pozostaje sprawdzic, czy pole pomiedzy jest zajete
        int xmid = (int)((double)xnew / 2.0 + (double)xold / 2.0);
        int ymid = (int)((double)ynew / 2.0 + (double)yold / 2.0);
        return BoardAt(game, xmid, ymid) == Model.Board.Field.Taken;
    }

    // 4. Sprawdza czy istnieje jakikolwiek ruch z tego pola
    private static boolean CanMove(Model.Board game, int x, int y)
    {
        if (game.board[x][y] != Model.Board.Field.Taken) // nie mozna wykonac ruchu z pola bez pionka
            return false;
        return (IsLegalMove(game, x, y, x, y - 2)) // mozliwy ruch w gore
            || (IsLegalMove(game, x, y, x + 2, y)) // mozliwy ruch w prawo
            || (IsLegalMove(game, x, y, x, y + 2)) // mozliwy ruch w dol
            || (IsLegalMove(game, x, y, x - 2, y)); // mozliwy ruch w lewo
    }

    // 5. Wykonuje ruch i zwraca true jesli jest on mozliwy, false w p.p. -------------------------
    public static boolean MakeMove(Model.Board game, int xold, int yold, int xnew, int ynew)
    {
        if (!IsLegalMove(game, xold, yold, xnew, ynew))
            return false;
        // znalezienie pola pomiedzy (xold, yold) a (xnew, ynew)
        int xmid = (int)((double)xnew / 2.0 + (double)xold / 2.0);
        int ymid = (int)((double)ynew / 2.0 + (double)yold / 2.0);
        // wykonanie ruchu
        game.board[xold][yold] = Model.Board.Field.Empty;
        game.board[xmid][ymid] = Model.Board.Field.Empty;
        game.board[xnew][ynew] = Model.Board.Field.Taken;
        return true;
    }

    // 6. Sprawdza, czy gra sie zakonczyla --------------------------------------------------------
    public static boolean IsFinished(Model.Board game)
    {
        int piecesCount = 0;

        for (int y = 0; y < Model.Board.size; y++) // rzad 
        {
            for (int x = 0; x < Model.Board.size; x++) // kolumna
            {
                if ( game.board[x][y] == Model.Board.Field.Taken )
                    piecesCount++;
                if ( CanMove(game, x, y) )
                    return false;
            }
        }
        // nie ma zadnego ruchu, gra sie zakonczyla
        if (piecesCount == 1 && game.board[3][3] == Model.Board.Field.Taken) // wygrana
            game.state = Model.Board.State.Won;
        else // przegrana
            game.state = Model.Board.State.Lost;
        return true;
    }

    // 7. Serializacja ----------------------------------------------------------------------------
    public static void SaveToFile(Model.Board game)
    {
        try 
        {
            File file = new File(Model.Board.filename);
            FileOutputStream fileOut = new FileOutputStream(file);
            ObjectOutputStream out = new ObjectOutputStream(fileOut);

            // TODO Serializacja?
            out.writeObject(game);
            out.close();
            fileOut.close();
        } 
        catch (Exception e) 
        {
            System.out.println("Wystapil blad podczas zapisywania obiektu klasy Game: " + e.getMessage());
        }
    }

    // 8. Deserializacja --------------------------------------------------------------------------
    public static Model.Board GetFromFile() 
    {
        try 
        {
            File file = new File(Model.Board.filename);
            FileInputStream fileIn = new FileInputStream(file);
            ObjectInputStream in = new ObjectInputStream(fileIn);

            // TODO Deserializacja ???
            Model.Board game = (Model.Board) in.readObject();
            
            in.close();
            fileIn.close();

            // usuniecie pliku po udanym odczycie
            file.delete();

            return game; // udalo sie odczytac dane z pliku
        }
        catch (Exception e) 
        {
            return null; // nie udalo sie odczytac danych z pliku
        }
    }
}