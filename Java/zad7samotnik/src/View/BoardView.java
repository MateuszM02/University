package View;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public class BoardView extends JPanel
{
    public class CurrentColors
    {
        public static Color backgroundColor = new Color(204, 200, 180); // kolor pustych pol poza plansza
        public static Color boardColor = new Color(133, 86, 66); // kolor pol (brazowy)
        public static Color pieceInsideColor = new Color(77, 168, 212); // wewnetrzny kolor pionkow na polach zajetych
        public static Color pieceOutsideColor = Color.BLUE; // zewnetrzny kolor pionkow na polach zajetych
        public static Color selectedFieldColor = Color.DARK_GRAY;
    }

    private static FieldView boardGUI[][];

    private boolean repaintAll = false;
    public void RepaintAll() 
    { 
        repaintAll = true;
        repaint();
    }

    // 1. Inicjalizuje JPanel ---------------------------------------------------------------------
    public BoardView()
    {
        super(new GridLayout(Model.Board.size, Model.Board.size));

        boardGUI = new FieldView[Model.Board.size][Model.Board.size];

        // dodawanie pionkow na planszy
        for (int y = 0; y < Model.Board.size; y++) // rzad
        {
            for (int x = 0; x < Model.Board.size; x++) // kolumna
            {
                Model.Board.Field type = Controller.Window.game.board[x][y];
                boardGUI[x][y] = new FieldView(type, x, y);
                add(boardGUI[x][y]);
            }
        }
        boardGUI[Controller.Window.game.selectedX][Controller.Window.game.selectedY].isSelected = true;
        setVisible(true);

        // kliknieto ktores z pol
        addMouseListener(new MouseAdapter() 
        {
            @Override
            public void mouseReleased(MouseEvent e) 
            {
                int clicked_x = Model.Board.size * e.getX() / getWidth();
                int clicked_y = Model.Board.size * e.getY() / getHeight();
                ClickedAt(clicked_x, clicked_y);
            }
        });
    }

    @Override
    public void paintComponent(Graphics g)
    {
        if ( repaintAll )
        {
            super.paintComponent(g);
            repaintAll = false;
            Model.Board newGame = Controller.Window.game;
            int fieldCount = Model.Board.size;
            
            for(int y = 0; y < fieldCount; y++)
            {
                for(int x = 0; x < fieldCount; x++)
                {
                    boardGUI[x][y].type = newGame.board[x][y];
                    boardGUI[x][y].isSelected = false;
                    boardGUI[x][y].repaint();
                }
            }
            boardGUI[newGame.selectedX][newGame.selectedY].isSelected = true;
            boardGUI[newGame.selectedX][newGame.selectedY].repaint();
        }
    }

    @Override
    public Dimension getPreferredSize() 
    {
        return new Dimension(getWidth(), getHeight());
    }

    // 2. Okresla akcje po kliknieciu pola na planszy (ignoruje klikniecie pol poza plansza) ------
    public static void ClickedAt(int xnew, int ynew)
    {
        Model.Board.Field type = Controller.BoardController.BoardAt(Controller.Window.game, xnew, ynew);
        if (type == Model.Board.Field.Taken) // pole z pionkiem, zaznacz je
        {
            SelectPiece(Controller.Window.game.selectedX, Controller.Window.game.selectedY, xnew, ynew);
        } 
        else if ( type == Model.Board.Field.Empty ) // wykonaj ruch na puste pole
        {
            MakeMoveGUI(Controller.Window.game.selectedX, Controller.Window.game.selectedY, xnew, ynew);
        }
    }

    // 3. Odznacza dotychczas zaznaczone pole i zaznacza nowe -------------------------------------
    public static void SelectPiece(int xold, int yold, int xnew, int ynew)
    {
        // odznacz stare pole
        boardGUI[xold][yold].isSelected = false;
        boardGUI[xold][yold].repaint();

        // zaznacz nowe pole
        boardGUI[xnew][ynew].isSelected = true;
        boardGUI[xnew][ynew].repaint();

        // ustal nowe zaznaczone pole i powiadom uzytkownika o zmianie pionka
        Controller.Window.game.selectedX = xnew;
        Controller.Window.game.selectedY = ynew;
        Controller.Window.labelController.ChangeText("Wybrano pionka.");
    }

    // 4. Wykonuje ruch i zmienia grafike ---------------------------------------------------------
    public static void MakeMoveGUI(int xold, int yold, int xnew, int ynew)
    {
        boolean isLegalMove = Controller.BoardController.MakeMove( 
            Controller.Window.game, xold, yold, xnew, ynew);
        if (!isLegalMove)
        {
            Controller.Window.labelController.ChangeText("Nie można wykonać takiego ruchu!");
            return;
        }
        Controller.Window.labelController.ChangeText("Wykonano poprawny ruch.");
        // znalezienie pola pomiedzy
        int xmid = (int)((double)xnew / 2.0 + (double)xold / 2.0);
        int ymid = (int)((double)ynew / 2.0 + (double)yold / 2.0);
        // stare pole nie ma pionka
        boardGUI[xold][yold].type = Model.Board.Field.Empty;
        boardGUI[xold][yold].isSelected = false;
        boardGUI[xold][yold].repaint();
        // nowe pole ma pionek
        boardGUI[xnew][ynew].type = Model.Board.Field.Taken;
        boardGUI[xnew][ynew].isSelected = true;
        boardGUI[xnew][ynew].repaint();
        // pole pomiedzy nie ma pionka
        boardGUI[xmid][ymid].type = Model.Board.Field.Empty;
        boardGUI[xmid][ymid].repaint();
        // zaktualizuj lokalizacje zaznaczonego pola
        Controller.Window.game.selectedX = xnew;
        Controller.Window.game.selectedY = ynew;
        // sprawdz, czy istnieje nastepny ruch
        if (Controller.BoardController.IsFinished(Controller.Window.game))
        {    
            Controller.Window.labelController.ChangeText("Przegrałeś!");
            MenuView.britRadioButton.setEnabled(true);
            MenuView.europeRadioButton.setEnabled(true);
        }
    }
}
