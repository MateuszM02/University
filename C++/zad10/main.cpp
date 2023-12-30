#include "bst.hpp"

//Mateusz Mazur

int main()
{
    cout << "(KOMUNIKAT!) Tworze nowe drzewo BST z wartosciami INT: 33, 7, 8, 2, 1, 4." << endl;
    auto *myBST = new bst<int>({33, 7, 8, 2, 1, 4});
    cout << "(KOMUNIKAT!) Wypisuje wszystkie wartosci poprzednio utworzonego drzewa" << endl;
    cout << "( OUTPUT!  ) " << *myBST << endl << endl;

    cout << "(KOMUNIKAT!) Usuwam wartosci 7 i 4. Dodaje wartosc 42." << endl;
    myBST->usunWezel(7);
    myBST->usunWezel(4);
    myBST->dodajWezel(42);

    cout << "(KOMUNIKAT!) Ponownie wypisuje drzewo." << endl;
    cout << "( OUTPUT!  ) " << *myBST << endl << endl;

    int x = 1;
    cout << "(KOMUNIKAT!) Szukam wartoœci 1, a nastêpnie 7." << endl;
    cout << "( OUTPUT!  ) " << (myBST->znajdzWezel(x) ? "Odnaleziono wartosc: " + to_string(x)
                                                    : "nie ma takiej wartosci w drzewie: " + to_string(x)) << endl;
    x = 7;
    cout << "( OUTPUT!  ) " << (myBST->znajdzWezel(x) ? "Odnaleziono wartosc: " + to_string(x)
                                                    : "nie ma takiej wartosci w drzewie: " + to_string(x)) << endl;

    delete myBST;
    return 0;
}
