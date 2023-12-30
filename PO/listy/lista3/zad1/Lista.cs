using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    public class Lista<T>
    {
        public class Zbior //klasa przechowujaca dane
        {
            public T wartosc;
            public Zbior previous;
            public Zbior next;
            public Zbior(T elem)
            {
                this.wartosc = elem;
                this.next = null;
                this.previous = null;
            }
        }
        public Zbior first; //pierwszy element listy
        public Zbior last; //ostatni element listy

        public Lista()
        {
            first = null;
            last = null;
        }
        //metody
        public void push_front(T elem) //dodaje element na poczatek listy
        {
            Zbior pudelko = new Zbior(elem); //stworz obiekt na dane
            this.first = pudelko; //ustal obiekt jako pierwszy element listy
            if (this.first == null) //jesli lista jest pusta
            {
                this.last = pudelko; //ustal obiekt jako ostatni element listy
            }
            else
            {
                pudelko.next = this.first; //ustal, ze lista jest nastepnikiem obiektu
            }
        }
        public void push_back(T elem)
        {
            Zbior pudelko = new Zbior(elem); //stworz obiekt na dane
            this.last = pudelko; //ustal obiekt jako ostatni element listy
            if (this.first == null) //jesli lista jest pusta
            {
                this.first = pudelko; //ustal obiekt jako pierwszy element listy
            }
            else
            {
                pudelko.previous = this.last; //ustal, ze lista jest poprzednikiem obiektu
            }
        }
        public T pop_front()
        {
            if (this.first == null) //jesli lista jest pusta
            {
                return default; //to nie ma czego usuwac
            }
            else
            {
                T zwracana = this.first.wartosc;
                if(this.first.next == null) //jesli lista zawiera 1 element
                {
                    this.first = null;
                    this.last = null;
                }
                else
                {
                    this.first = this.first.next; //ustal drugi element listy jako pierwszy
                    this.first.previous = null; //ustal poprzednik pierwszego elementu na null
                }
                return zwracana;
            }
        }
        public T pop_back()
        {
            if (this.first == null) //jesli lista jest pusta
            {
                return default; //to nie ma czego usuwac
            }
            else
            {
                T zwracana = this.last.wartosc;
                if (this.first.next == null) //jesli lista zawiera 1 element
                {
                    this.first = null;
                    this.last = null;
                }
                else
                {
                    this.last = this.last.previous; //ustal przedostatni element listy jako ostatni
                    this.last.next = null; //ustal nastepnik ostatniego elementu na null
                }
                return zwracana;
            }
        }
        bool is_empty()
        {
            if (first == null) return true;
            else return false;
        }
    }
}
