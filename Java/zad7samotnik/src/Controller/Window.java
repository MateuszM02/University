package Controller;

import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.*;

public class Window extends JFrame
{
    public static void main(String[] args) throws Exception 
    {
        new Window();
    }

    private final int WindowWidth = 600;
    private final int WindowHeight = 600;
    public static View.BoardView gamePanel;
    public static Model.Board game;
    public static JLabelController labelController;
    
    public Window() 
    {
        super("samotnik");

        Dimension ScreenSize = Toolkit.getDefaultToolkit().getScreenSize();
        int ScreenWidth = (int)ScreenSize.getWidth();
        int ScreenHeight = (int)ScreenSize.getHeight();

        // ustalanie wlasnosci okna
        // setLayout(new BorderLayout());
        setSize(WindowWidth, WindowHeight);
        setLocation((ScreenWidth - WindowWidth) / 2, (ScreenHeight - WindowHeight) / 2);
        setBackground(new Color(239, 222, 214));
        
        // Tworzenie paneli
        game = new Model.Board(true);
        gamePanel = new View.BoardView();
        labelController = new JLabelController();
        View.MenuView.Init();
        MenuController.InitEventListeners();

        // Dodanie paneli
        setJMenuBar(View.MenuView.menuBar);
        add(gamePanel, BorderLayout.CENTER);
        add(labelController, BorderLayout.SOUTH);
        setVisible(true);

        addWindowListener(new WindowAdapter() // zamykanie okna ma zapisac stan gry
        {
            @Override
            public void windowClosing(WindowEvent e) 
            {
                CloseWindow();
            }
        });
    }

    public static void CloseWindow()
    {
        if (Window.game.state == Model.Board.State.Playing)
            Controller.BoardController.SaveToFile(game);
        System.exit(0);
    }

    public static void ResetBoard(boolean english)
    {
        game = new Model.Board(english);
        //gamePanel = new View.BoardView();
        gamePanel.RepaintAll();
    }
}
