package Controller;

import javax.swing.JLabel;

public class JLabelController extends JLabel
{
    public static final String welcomeMessage = "Witaj!";
    public static final String badMoveMessage = "Ten ruch jest nielegalny";
    public static final String wonMessage = "Gratuluję wygranej!";
    public static final String lostMessage = "Brak ruchów. Przegrałeś z %d pionkami";

    public JLabelController()
    {
        this.setText(welcomeMessage);
    }
    
    public void ChangeText(String text)
    {
        this.setText(text);
    }
}
