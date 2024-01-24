package Controller;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public abstract class MenuController extends View.MenuView 
{
    public static void InitEventListeners()
    {
        // 1. Gra
        suboptionNewGame.addActionListener(NewGame);
        suboptionClose.addActionListener(Close);
        
        // mnemoiki elementow kategorii Gra
        optionGame.setMnemonic(KeyEvent.VK_G);
        suboptionNewGame.setMnemonic(KeyEvent.VK_N);
        suboptionClose.setMnemonic(KeyEvent.VK_C);

        // 2. Ruchy
        suboptionSelectUp.addActionListener(SelectedField);
        suboptionSelectRight.addActionListener(SelectedField);
        suboptionSelectDown.addActionListener(SelectedField);
        suboptionSelectLeft.addActionListener(SelectedField);
        suboptionMoveUp.addActionListener(SelectedMove);
        suboptionMoveRight.addActionListener(SelectedMove);
        suboptionMoveDown.addActionListener(SelectedMove);
        suboptionMoveLeft.addActionListener(SelectedMove);

        // 3. Ustawienia
        suboptionBackgroundColor.addActionListener(BackgroundColorChooser);
        suboptionBoardColor.addActionListener(BoardColorChooser);
        suboptionInsidePieceColor.addActionListener(PieceInsideColorChooser);
        suboptionOutsidePieceColor.addActionListener(PieceOutsideColorChooser);
        
        // 4. Pomoc
        suboptionAboutGame.addActionListener(ShowAboutDialog);
        suboptionAboutApp.addActionListener(ShowAboutDialog);
    }
    
    // 5. Gra On-clicks
    private static ActionListener NewGame = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e) 
        {
            //Controller.Window.game = new Model.Board(britRadioButton.isSelected()); // rozpocznij nowa gre
            //Controller.Window.gamePanel = new View.BoardView(); // i zaktualizuj widok planszy
            
            Window.ResetBoard(britRadioButton.isSelected());
            britRadioButton.setEnabled(false);
            europeRadioButton.setEnabled(false);
        }
    };

    private static ActionListener Close = new ActionListener()
    {
        @Override
        public void actionPerformed(ActionEvent e) 
        {
            Window.CloseWindow();
        }
    };

    // 6. Ruchy On-clicks
    public static ActionListener SelectedField = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Object sender = e.getSource();
            int xold = Window.game.selectedX;
            int yold = Window.game.selectedY;
            if (sender == suboptionSelectUp && yold > 0)
                View.BoardView.SelectPiece(xold, yold, xold, yold-1);
            else if (sender == suboptionSelectRight && xold < Model.Board.size - 1)
                View.BoardView.SelectPiece(xold, yold, xold+1, yold);
            else if (sender == suboptionSelectDown && yold < Model.Board.size - 1)
                View.BoardView.SelectPiece(xold, yold, xold, yold+1);
            else if (sender == suboptionSelectLeft && xold > 0)
                View.BoardView.SelectPiece(xold, yold, xold-1, yold);
            else
                throw new IllegalAccessError("Blad w MenuPanel/SelecteedMove!");
        }    
    };

    public static ActionListener SelectedMove = new ActionListener()
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Object sender = e.getSource();
            int xold = Window.game.selectedX;
            int yold = Window.game.selectedY;
            if (sender == suboptionMoveUp)
                View.BoardView.MakeMoveGUI(xold, yold, xold, yold-2);
            else if (sender == suboptionMoveRight)
                View.BoardView.MakeMoveGUI(xold, yold, xold+2, yold);
            else if (sender == suboptionMoveDown)
                View.BoardView.MakeMoveGUI(xold, yold, xold, yold+2);
            else if (sender == suboptionMoveLeft)
                View.BoardView.MakeMoveGUI(xold, yold, xold-2, yold);
            else
                throw new IllegalAccessError("Blad w MenuPanel/SelecteedMove!");
        }    
    };

    // 7. Ustawienia On-clicks

    private static ActionListener BackgroundColorChooser = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Color color = JColorChooser.showDialog(
                null, "Wybierz kolor tła", View.BoardView.CurrentColors.backgroundColor);
            View.BoardView.CurrentColors.backgroundColor = color;
            
            // zaktualizuj kolory obiektow
            Window.gamePanel.paintAll(Window.gamePanel.getGraphics());
        }    
    };

    private static ActionListener BoardColorChooser = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Color color = JColorChooser.showDialog(
                null, "Wybierz kolor planszy", View.BoardView.CurrentColors.boardColor);
            View.BoardView.CurrentColors.boardColor = color;
            
            // zaktualizuj kolory obiektow
            Window.gamePanel.paintAll(Window.gamePanel.getGraphics());
        }    
    };

    private static ActionListener PieceInsideColorChooser = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Color color = JColorChooser.showDialog(
                null, "Wybierz kolor wnętrza pionka", View.BoardView.CurrentColors.pieceInsideColor);
            View.BoardView.CurrentColors.pieceInsideColor = color;

            // zaktualizuj kolory obiektow
            Window.gamePanel.paintAll(Window.gamePanel.getGraphics());
        }    
    };

    private static ActionListener PieceOutsideColorChooser = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Color color = JColorChooser.showDialog(
                null, "Wybierz kolor otoczki pionka", View.BoardView.CurrentColors.pieceOutsideColor);
            View.BoardView.CurrentColors.pieceOutsideColor = color;

            // zaktualizuj kolory obiektow
            Window.gamePanel.paintAll(Window.gamePanel.getGraphics());
        }    
    };

    // 8. Pomoc On-clicks
    private static ActionListener ShowAboutDialog = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e)
        {
            Object sender = e.getSource();
            if (sender == suboptionAboutGame)
            {    
                JOptionPane.showMessageDialog(null, 
                    aboutGame, "O grze", JOptionPane.INFORMATION_MESSAGE);
            }
            else if (sender == suboptionAboutApp)
            {
                JOptionPane.showMessageDialog(null, 
                    aboutApp, "O Aplikacji", JOptionPane.INFORMATION_MESSAGE);
            }
        }    
    };
}
