package View;

import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;

import javax.swing.*;

// klasa do tworzenia JMenuBar
public abstract class MenuView
{
    public static JMenuBar menuBar;

    // 1. Menu Gra
    protected static JMenu optionGame;
    protected static JMenuItem suboptionNewGame;
    protected static JMenuItem suboptionClose;

    // 2. Menu Ruchy
    private static JMenu optionMoves;
    protected static JMenuItem suboptionSelectUp;
    protected static JMenuItem suboptionSelectRight;
    protected static JMenuItem suboptionSelectDown;
    protected static JMenuItem suboptionSelectLeft;
    protected static JMenuItem suboptionMoveUp;
    protected static JMenuItem suboptionMoveRight;
    protected static JMenuItem suboptionMoveDown;
    protected static JMenuItem suboptionMoveLeft;

    // 3. Menu Ustawienia
    private static JMenu optionSettings;
    private static JMenu optionType;
    private static ButtonGroup gameTypeGroup;
    public static JRadioButton britRadioButton;
    public static JRadioButton europeRadioButton;
    protected static JMenuItem suboptionBackgroundColor;
    protected static JMenuItem suboptionBoardColor;
    protected static JMenuItem suboptionInsidePieceColor;
    protected static JMenuItem suboptionOutsidePieceColor;

    // 4. Menu Pomoc
    private static JMenu optionHelp;
    protected static JMenuItem suboptionAboutGame;
    protected static JMenuItem suboptionAboutApp;
    protected static final String aboutGame = "<html> Samotnik (Peg solitaire) — gra logiczna rozgrywana " +
            "przez jedną osobę na planszy mającej 33 lub 37 pól.<br> Celem gry jest "+
            "zostawienie na planszy jak najmniejszej liczby pionków.<br> Idealnym " +
            "rozwiązaniem jest pozostawienie jednego pionka, najlepiej w centrum.<br> " +
            "Pionka bije się przeskakując go w pionie lub w poziomie.<br> Nie można "+
            "poruszać się na ukos oraz nie można bić kilku pionków w jednym ruchu. </html>";
    protected static final String aboutApp = "<html> Autor: Mateusz Mazur <br> Wersja: 1.0.0 <br>" +
            "Data powstania: 16.12.2023 <br> </html>";

    // 5. Inicjalizuje JMenuBar
    public static void Init()
    {
        // 1. Tworzenie opcji Gra
        optionGame = new JMenu("Gra");
        suboptionNewGame = new JMenuItem("Nowa gra");
        suboptionClose = new JMenuItem("Koniec");
        
        // dodawanie elementow do kategorii Gra
        optionGame.add(suboptionNewGame);
        optionGame.addSeparator();
        optionGame.add(suboptionClose);

        // 2. Tworzenie opcji Ruchy
        optionMoves = new JMenu("Ruchy");
        suboptionSelectUp = new JMenuItem("Przesuń zaznaczenie w górę", KeyEvent.VK_W);
        suboptionSelectRight = new JMenuItem("Przesuń zaznaczenie w prawo", KeyEvent.VK_D);
        suboptionSelectDown = new JMenuItem("Przesuń zaznaczenie w dół", KeyEvent.VK_S);
        suboptionSelectLeft = new JMenuItem("Przesuń zaznaczenie w lewo", KeyEvent.VK_A);
        suboptionMoveUp = new JMenuItem("Ruch w górę", KeyEvent.VK_UP);
        suboptionMoveRight = new JMenuItem("Ruch w prawo", KeyEvent.VK_RIGHT);
        suboptionMoveDown = new JMenuItem("Ruch w dół", KeyEvent.VK_DOWN);
        suboptionMoveLeft = new JMenuItem("Ruch w lewo", KeyEvent.VK_LEFT);
        
        // dodawanie do kategorii Ruchy
        optionMoves.add(suboptionSelectUp);
        optionMoves.add(suboptionSelectRight);
        optionMoves.add(suboptionSelectDown);
        optionMoves.add(suboptionSelectLeft);
        optionMoves.addSeparator();
        optionMoves.add(suboptionMoveUp);
        optionMoves.add(suboptionMoveRight);
        optionMoves.add(suboptionMoveDown);
        optionMoves.add(suboptionMoveLeft);

        // Akceleratorory dla zmiany pola
        suboptionSelectUp.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_W, ActionEvent.ALT_MASK));
        suboptionSelectRight.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_D, ActionEvent.ALT_MASK));
        suboptionSelectDown.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_S, ActionEvent.ALT_MASK));
        suboptionSelectLeft.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_A, ActionEvent.ALT_MASK));
        // Akceleratory dla wykonania ruchu
        suboptionMoveUp.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_UP, ActionEvent.ALT_MASK));
        suboptionMoveRight.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_RIGHT, ActionEvent.ALT_MASK));
        suboptionMoveDown.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_DOWN, ActionEvent.ALT_MASK));
        suboptionMoveLeft.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_LEFT, ActionEvent.ALT_MASK));

        // 3. Tworzenie opcji Ustawienia
        optionSettings = new JMenu("Ustawienia");
        optionType = new JMenu("Typ gry");
        suboptionBackgroundColor = new JMenuItem("Kolor tła");
        suboptionBoardColor = new JMenuItem("Kolor planszy");
        suboptionInsidePieceColor = new JMenuItem("Kolor wnętrza pionków");
        suboptionOutsidePieceColor = new JMenuItem("Kolor otoczki pionków");
        britRadioButton = new JRadioButton("brytyjska");
        europeRadioButton = new JRadioButton("europejska");
        
        // gra jest albo brytyjska albo europejska
        gameTypeGroup = new ButtonGroup();
        gameTypeGroup.add(britRadioButton);
        gameTypeGroup.add(europeRadioButton);
        optionType.add(britRadioButton);
        optionType.add(europeRadioButton);
        // dodawanie elementow do kategorii Ustawienia
        optionSettings.add(optionType);
        optionSettings.add(suboptionBackgroundColor);
        optionSettings.add(suboptionBoardColor);
        optionSettings.add(suboptionInsidePieceColor);
        optionSettings.add(suboptionOutsidePieceColor);

        // 4. Tworzenie opcji Pomoc
        optionHelp = new JMenu("Pomoc");
        suboptionAboutGame = new JMenuItem("O grze");
        suboptionAboutApp = new JMenuItem("O aplikacji");
        
        // dodawanie elementow do kategorii Pomoc
        optionHelp.add(suboptionAboutGame);
        optionHelp.add(suboptionAboutApp);

        // 5. Dodawanie obiektow do menu
        menuBar = new JMenuBar();
        menuBar.add(optionGame);
        menuBar.add(optionMoves);
        menuBar.add(optionSettings);
        menuBar.add(Box.createHorizontalGlue());
        menuBar.add(optionHelp);
    }
}