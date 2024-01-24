package struktury;

import java.util.Arrays;

public class ZbiorTablicowy implements Zbior, Cloneable
{
    private Para[] zbior;
    private int zapelnienie;
    private final int rozmiar;

    public ZbiorTablicowy(int rozmiar)
    {
        this.zbior = new Para[rozmiar];
        this.zapelnienie = 0;
        this.rozmiar = rozmiar;
    }

    @Override
    public ZbiorTablicowy clone() throws CloneNotSupportedException
    {
        ZbiorTablicowy nowyZbior = (ZbiorTablicowy)super.clone();
        nowyZbior.zbior = Arrays.copyOf(this.zbior, this.rozmiar);
        for(int i = 0; i < nowyZbior.zapelnienie; i++) // klonujemy kazdy element
            nowyZbior.zbior[i] = this.zbior[i].clone();
        return nowyZbior;
    }

    public Para szukaj(String k)
    {
        for(int i = 0; i < this.zapelnienie; i++)
        {
            if (this.zbior[i].klucz == k)
                return this.zbior[i];
        }
        return null;
    }

    public void wstaw(Para p)
    {
        for(int i = 0; i < this.zapelnienie; i++)
        {
            if (this.zbior[i].klucz == p.klucz)
            {
                this.zbior[i].setWartosc(p.getWartosc());
                return;
            }
        }
        if (this.zapelnienie == this.rozmiar)
            throw new IllegalStateException("Nie mozna wstawiac elementu do zapelnionej tablicy");
        this.zbior[this.zapelnienie] = p;
        this.zapelnienie++;
    }

    int znajdz_indeks(String k)
    {
        for(int i = 0; i < this.zapelnienie; i++)
        {
            if (this.zbior[i].klucz == k)
                return i;
        }
        return -1;
    }

    public void usun(String k)
    {
        int indeks = znajdz_indeks(k);
        if (indeks < 0) // nic nie usuwamy, bo szukany element nie znajduje sie w tablicy
            return;
        for(int i = indeks; i < this.zapelnienie-1; i++)
        {
            this.zbior[i] = this.zbior[i+1];
        }
        this.zbior[this.zapelnienie-1] = null;
        this.zapelnienie--;
    }

    public void czysc()
    {
        for(int i = 0; i < this.zapelnienie; i++)
        {
            this.zbior[i] = null;
        }
        this.zapelnienie = 0;
    }

    public int ile()
    {
        return this.zapelnienie;
    }
}
