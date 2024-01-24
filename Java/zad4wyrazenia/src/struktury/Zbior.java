package struktury;

public interface Zbior 
{
    /**
     *  Wyszukuje parę z zadanym kluczem k; metoda zwraca null, gdy nie znajdzie pary o podanym kluczu
     */
    Para szukaj(String k);
    /**
     * Wstawia do zbioru nową parę p; gdy para o podanym kluczu już jest w zbiorze, 
     * metoda dokonuje aktualizacji wartości w znalezionej parze
     */
    void wstaw(Para p);
    /** 
     * Usuwa ze zbioru parę o zadanym kluczu k; gdy pary o 
     * podanym kluczu nie ma w zbiorze metoda nic nie robi
    */
    void usun(String k);
    /**
     * Usuwa wszystkie pary ze zbioru; po tej operacji zbiór staje się pusty 
     */
    void czysc();
    /**
     * podaje ile jest wszystkich par w zbiorze
     */
    int ile();
}
