package View;

import java.awt.*;
import javax.swing.*;

// klasa do rysowania pol planszy
public class FieldView extends JComponent
{
    public static final int constDiv = Model.Board.size;
    private final int xx;
    private final int yy;
    public Model.Board.Field type;
    public boolean isSelected = false;

    public FieldView(Model.Board.Field type, int x, int y)
    {
        this.type = type;
        this.xx = x;
        this.yy = y;
    }

    @Override
    public void paintComponent(Graphics g) 
    {
        super.paintComponent(g);
        Dimension dim = this.getPreferredSize();
        int twidth = (int)dim.getWidth();
        int theight = (int)dim.getHeight();
        
        // najpierw malowanie tla pola
        if (this.type == Model.Board.Field.Outside)
            g.setColor(BoardView.CurrentColors.backgroundColor);
        else if (this.isSelected)
            g.setColor(BoardView.CurrentColors.boardColor.darker().darker());
        else
            g.setColor(BoardView.CurrentColors.boardColor);
        g.fillRect(this.xx, this.yy, twidth, theight);
        
        if (this.type != Model.Board.Field.Taken) // pole bez pionka, zakoncz malowanie
            return;
        
        int wscalar = (int)(0.1 * twidth);
        int hscalar = (int)(0.1 * theight);

        // nastepnie malowanie otoczki pionka
        g.setColor(BoardView.CurrentColors.pieceOutsideColor);
        g.fillOval(this.xx + wscalar / 2, this.yy + hscalar / 2, twidth - wscalar, theight - hscalar);

        wscalar = (int)(0.3 * twidth);
        hscalar = (int)(0.3 * theight);

        // na koncu malowanie srodka pionka
        g.setColor(BoardView.CurrentColors.pieceInsideColor);
        g.fillOval(this.xx + wscalar / 2, this.yy + hscalar / 2, twidth - wscalar, theight - hscalar);
    }

    // rozmiar pojedynczego pola
    @Override
    public Dimension getPreferredSize() 
    {
        Component parent = this.getParent();
        return new Dimension(parent.getWidth() / constDiv, 
                            parent.getHeight() / constDiv);
    }
}