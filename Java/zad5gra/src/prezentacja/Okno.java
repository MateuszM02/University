package prezentacja;

import rozgrywka.Gra;

import java.awt.*;
import java.awt.event.*;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JOptionPane;

public class Okno extends Frame
{
    //#region event listenery
    private WindowListener sluchaczZamykaniaOkna = new WindowAdapter()
    {
        @Override
        public void windowClosing(WindowEvent ev)
        {
            Okno.this.dispose();
        }
    };

    private AdjustmentListener sluchaczSuwakaZakresu = new AdjustmentListener()
    {
        @Override
        public void adjustmentValueChanged (AdjustmentEvent e)
        {
            gra.setZakres(sbrZakres.getValue());
            labelZakres.setText(String.format("Zakres liczb: 0-%d", gra.getZakres()));
        }
    };

    private ActionListener sluchaczGuzikaPrzerwy = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e) {
            WidokPrzerwy();
        }
        
    };

    private MouseListener sluchaczGuzikaWyslij = new MouseListener() 
    {
        @Override
        public void mouseClicked(MouseEvent e) {
            double wynik = gra.wyslijTyp(poleLicznik.getText(), poleMianownik.getText());
            if (Double.isNaN(wynik)) // zly typ danych wejsciowych
            {
                JOptionPane.showMessageDialog(null, "Podano niepoprawne dane!");
                return;
            }
            gra.IncLicznik(); // zwieksz ilosc prob z dobrym typem danych
            sbrProby.setValue(sbrProby.getValue() + 1);
            
            if (wynik == 0) // poprawny typ
            {
                WidokKoncaGry();
                JOptionPane.showMessageDialog(null, gra.wiadomosc(wynik));
                return;
            }
            else if(gra.getLicznik() >= gra.getMaxIloscProb()) // przegrana przez wykorzystanie ilosci prob
            {
                WidokKoncaGry();
                String msg = String.format("Przegrana - wykorzystano limit prob! Prawidlowym wynikiem bylo %s", gra.GET_RESULT());
                JOptionPane.showMessageDialog(null, msg);
                return;
            }

            // zly typ ale poprawne dane wejsciowe -> przekaz informacje za malo/duzo
            JOptionPane.showMessageDialog(null, gra.wiadomosc(wynik));

            double wartosc = Double.parseDouble(poleLicznik.getText()) / 
                             Double.parseDouble(poleMianownik.getText());
            if (wynik < 0) // za maly typ - dolny limit zwieksza sie
            {
                gra.setMinWartosc(wartosc);
                labelMin.setText(String.format("Min: %f", gra.getMinWartosc()));
            }
            else if (wynik > 0) // za duzy typ - gorny limit zmniejsza sie
            {
                gra.setMaxWartosc(wartosc);
                labelMax.setText(String.format("Max: %f", gra.getMaxWartosc()));
            }
        }

        @Override
        public void mousePressed(MouseEvent e) {}
        @Override
        public void mouseReleased(MouseEvent e) {}

        @Override
        public void mouseEntered(MouseEvent e) {
            guzikWyslijPropozycje.setLabel(String.format("Wyślij wartosc %f", wartoscLabeli()));
        }

        @Override
        public void mouseExited(MouseEvent e) {
            guzikWyslijPropozycje.setLabel("Wyślij"); 
        }
    };

    private ActionListener sluchaczNowejGry = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e) {
            gra.start(sbrZakres.getValue());
            sbrProby.setMaximum(gra.getMaxIloscProb()); // ustal max wartosc suwaka na ilosc prob
            WidokStartuGry();
        }
    };

    private ActionListener sluchaczPoddaniaSie = new ActionListener() 
    {
        @Override
        public void actionPerformed(ActionEvent e) 
        {
            WidokKoncaGry();
            String msg = String.format("Prawidlowym wynikiem bylo %s", gra.GET_RESULT());
            JOptionPane.showMessageDialog(null, msg);
        }
    };
    
    private ActionListener sluchaczZamykaniaOknaGuzikiem = new ActionListener() 
    {
            @Override
            public void actionPerformed(ActionEvent e) {
            Okno.this.dispose();
        }
    };

    AdjustmentListener SluchaczNielegalnejZmiany = new AdjustmentListener () {
        @Override
        public void adjustmentValueChanged (AdjustmentEvent e) {
            ((Scrollbar)e.getSource()).setValue(gra.getLicznik()); // cofnij zmiane
        }
    };

    //#endregion

    // #region kontrolki do okna
    Gra gra;
    Label labelLicznik = new Label("Podaj licznik: ");
    TextField poleLicznik = new TextField();
    Button guzikWyslijPropozycje = new Button("Wyślij");
    Scrollbar sbrProby;
    Label labelMin;
    
    Label labelMianownik = new Label("Podaj mianownik: ");
    TextField poleMianownik = new TextField();
    Button guzikPrzerwijGre = new Button("Przerwij grę");
    Scrollbar sbrZakres;
    Label labelMax;
    
    Panel panelGlowny = new Panel(new GridLayout(2, 4, 10, 10));
    Panel panelDolny = new Panel(new FlowLayout());
    Label labelZakres;
    Button guzikZacznijGre = new Button("Nowa gra");
    Button guzikPoddajSie = new Button("Poddaj sie");
    Button guzikZamknijOkno = new Button("Zamknij grę");
    //#endregion

    //#region inicjalizacja okna
    void InicjalizujPanel()
    {
        panelGlowny.add(labelLicznik);
        panelGlowny.add(DodajKlej(poleLicznik));
        panelGlowny.add(guzikWyslijPropozycje);
        panelGlowny.add(sbrProby);
        panelGlowny.add(labelMin);

        panelGlowny.add(labelMianownik);
        panelGlowny.add(DodajKlej(poleMianownik));
        panelGlowny.add(guzikPrzerwijGre);
        panelGlowny.add(sbrZakres);
        panelGlowny.add(labelMax);

        sbrProby.addAdjustmentListener(SluchaczNielegalnejZmiany); // suwak tylko do wgladu a nie do zmiany
        sbrZakres.addAdjustmentListener(sluchaczSuwakaZakresu);
        panelDolny.add(labelZakres);
        panelDolny.add(guzikZacznijGre);
        panelDolny.add(guzikPoddajSie);
        panelDolny.add(guzikZamknijOkno);
    }

    Component DodajKlej(Component inner)
    {
        return DodajKlej(inner, new Dimension(500, 200));
    }
    Component DodajKlej(Component inner, Dimension maxSize)
    {
        Panel pomoc = new Panel();
        pomoc.setLayout(new BoxLayout(pomoc, BoxLayout.Y_AXIS));
        inner.setMaximumSize(maxSize);
        pomoc.add(Box.createVerticalGlue());
        pomoc.add(inner);
        pomoc.add(Box.createVerticalGlue());
        return pomoc;
    }

    // konstruktor -------------------------------------------------------
    public Okno()
    {
        super("zgadywanie liczby wymiernej");
        int szerOkna = 500;
        int wysOkna = 500;
        Dimension rozmiarEkranu = Toolkit.getDefaultToolkit().getScreenSize();
        int szerEkranu = (int)rozmiarEkranu.getWidth();
        int wysEkranu = (int)rozmiarEkranu.getHeight();
        this.gra = new Gra();

        // wylaczanie na poczatku gry
        poleLicznik.setEnabled(false);
        poleMianownik.setEnabled(false);
        guzikWyslijPropozycje.setEnabled(false);
        guzikPrzerwijGre.setEnabled(false);
        guzikPoddajSie.setEnabled(false);

        // ustalanie wlasnosci scrollbarow
        sbrProby = new Scrollbar(Scrollbar.VERTICAL, 0, 1, 0, 10);
        sbrProby.setBackground(Color.WHITE);
        sbrProby.setForeground(Color.GRAY);
        sbrProby.setEnabled(false);

        sbrZakres = new Scrollbar(Scrollbar.VERTICAL, 0, 1, 5, 21);
        sbrZakres.setBackground(Color.WHITE);
        sbrZakres.setForeground(Color.GRAY);

        // ustalanie wartosci labeli
        labelMin = new Label(String.format("Min: %f", gra.getMinWartosc()));
        labelMax = new Label(String.format("Max: %f", gra.getMaxWartosc()));
        labelZakres = new Label(String.format("Zakres liczb: 0-%d", gra.getZakres()));

        // ustalanie wlasnosci okna
        setLayout(new BorderLayout());
        setSize(szerOkna,wysOkna);
        setLocation((szerEkranu - szerOkna) / 2, (wysEkranu - wysOkna) / 2);
        setBackground(new Color(239, 222, 214));
       
        // dodawanie akcji
        addWindowListener(sluchaczZamykaniaOkna);
        guzikWyslijPropozycje.addMouseListener(sluchaczGuzikaWyslij);
        guzikPrzerwijGre.addActionListener(sluchaczGuzikaPrzerwy);
        guzikZacznijGre.addActionListener(sluchaczNowejGry);
        guzikPoddajSie.addActionListener(sluchaczPoddaniaSie);
        guzikZamknijOkno.addActionListener(sluchaczZamykaniaOknaGuzikiem);

        // dodawanie kontrolek do okna
        add(panelGlowny, BorderLayout.CENTER);
        add(panelDolny, BorderLayout.SOUTH);
        InicjalizujPanel();
        setVisible(true);
    }
    //#endregion

    // #region zmienianie widocznosci kontrolek w zaleznosci od stanu gry

    boolean czyPrzerwa = false;
    void WidokStartuGry()
    {
        czyPrzerwa = false;
        poleLicznik.setEnabled(true);
        guzikWyslijPropozycje.setEnabled(true);
        poleMianownik.setEnabled(true);
        guzikPrzerwijGre.setEnabled(true);
        
        sbrProby.setValue(0); // na poczatku gry ilosc prob to 0
        labelMin.setText(String.format("Min: %f", 0.0));
        labelMax.setText(String.format("Max: %f", 1.0));

        sbrZakres.setEnabled(false);
        sbrProby.setEnabled(true);
        guzikZacznijGre.setEnabled(false);
        guzikPoddajSie.setEnabled(true);
        //guzikZamknijOkno.setEnabled(true);
    }

    void WidokPrzerwy()
    {
        czyPrzerwa = !czyPrzerwa;
        poleLicznik.setEnabled(!czyPrzerwa);
        guzikWyslijPropozycje.setEnabled(!czyPrzerwa);
        poleMianownik.setEnabled(!czyPrzerwa);
        //guzikPrzerwijGre.setEnabled(!czyPrzerwa);
        
        guzikPrzerwijGre.setLabel(czyPrzerwa ? "Wznów grę" : "Przerwij grę");

        //sbrZakres.setEnabled(false);
        //guzikZacznijGre.setEnabled(true);
        //guzikPoddajSie.setEnabled(true);
        //guzikZamknijOkno.setEnabled(true);
    }

    void WidokKoncaGry()
    {
        czyPrzerwa = false;
        poleLicznik.setEnabled(false);
        guzikWyslijPropozycje.setEnabled(false);
        poleMianownik.setEnabled(false);
        guzikPrzerwijGre.setEnabled(false);

        guzikPrzerwijGre.setLabel("Przerwij grę");

        sbrZakres.setEnabled(true);
        sbrProby.setEnabled(false);
        guzikZacznijGre.setEnabled(true);
        guzikPoddajSie.setEnabled(false);
        //guzikZamknijOkno.setEnabled(true);
    }
    //#endregion

    // #region funkcje pomocnicze
    
    double wartoscLabeli() // wartosc liczby wpisanej przez uzytkownika
    {
        try
        {
            double licznik = Double.parseDouble(poleLicznik.getText());
            double mianownik = Double.parseDouble(poleMianownik.getText());
            if (mianownik == 0)
                return Double.NaN;
            return licznik / mianownik;
        }
        catch(Exception e)
        {
            return Double.NaN;
        }
    }
    //#endregion
}