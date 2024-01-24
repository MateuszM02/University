import sqlalchemy as db
from sqlalchemy.orm import relationship, validates, declarative_base, sessionmaker
from re import match
import sys
from os.path import basename

engine = db.create_engine("sqlite:///zad1.db", echo = False)
Session = sessionmaker(bind = engine)
Base = declarative_base()

class Stala:
    tabZnajomi = "znajomi"
    tabKsiazki = "ksiazki"
    helpTekst = "--help"
    dodajTekst = "--dodaj"
    zmienTekst = "--zmien"
    wypozyczTekst = "--wypozycz"
    oddajTekst = "--oddaj"
    pokazTekst = "--pokaz"
    nazwaPliku = basename(__file__)

# 1. Klasa znajomego wypozyczajacego ksiazki ------------------------------------------------------

class Znajomy(Base):
    __tablename__ = Stala.tabZnajomi
    id = db.Column("id", db.Integer, primary_key = True)
    imie = db.Column("imie", db.String)
    nazwisko = db.Column("nazwisko", db.String)
    email = db.Column("email", db.String)
    # lista ksiazek, ktory znajomy wypozyczyl (one-to-many)
    wypozyczyl = relationship("Ksiazka", back_populates = "wypozyczajacy")
    
    @validates("email")
    def validate_email(self, _, email):
        goodEmail = match("^.+@.+\\.[a-zA-Z]{2,3}$", email) != None
        assert goodEmail, "Email musi byc postaci {AAA...}@{AAA...}.AA[A]"
        return email
    
    def __init__(self, id: db.Integer, imie: db.String, nazwisko: db.String, email: db.String, wypozyczyl = []):
        self.id = id
        self.imie = imie
        self.nazwisko = nazwisko
        self.email = email
        self.wypozyczyl = wypozyczyl

    # zamienia liste wypozyczonych ksiazek na napis przedstawiajacy liste indeksow tych ksiazek
    def ksiazkiToString(self):
        napis = ""
        for index in self.wypozyczyl:
            napis = f"{napis}{str(index.id)}, "
        return napis[:-2]

    def __str__(self):
        return f"id={self.id}, imie={self.imie}, nazwisko={self.nazwisko}, email={self.email}, wypozyczyl ksiazki [id]: [{self.ksiazkiToString()}]"

# 2. Klasa z informacjami o wypozyczanych ksiazkach -----------------------------------------------

class Ksiazka(Base):
    __tablename__ = Stala.tabKsiazki
    id = db.Column("id", db.Integer, primary_key = True)
    autor = db.Column("autor", db.String)
    tytul = db.Column("tytul", db.String)
    rok = db.Column("rok", db.Integer)
    # kto wypozyczyl ta ksiazke (zakladamy, ze wlasciciel ksiazki posiada 1 kopie)
    # ale wypozyczajacy moze wypozyczyc wiele roznych ksiazek (czyli many-to-one)
    wypozyczajacy_id = db.Column(db.Integer, db.ForeignKey(f"{Stala.tabZnajomi}.id"))
    wypozyczajacy = relationship("Znajomy", back_populates = "wypozyczyl")

    @validates("rok")
    def validate_rok(self, _, rok):
        assert rok >= -4000 and rok <= 2023, "Rok musi byc z przedzialu [-4000, 2023]"
        return rok
    
    def __init__(self, id: db.Integer, autor: db.String, tytul: db.String, rok: db.Integer):
        self.id = id
        self.autor = autor
        self.tytul = tytul
        self.rok = int(rok)

    def __str__(self):
        return f"id={self.id}, autor={self.autor}, tytul={self.tytul}, rok={self.rok}"

# 3. Pokaz podpowiedzi/wszystkie ksiazki/wszystkich znajomych -------------------------------------

def NapiszPomoc(napisPoczatkowy = ""):
    napisOgolny = f"Podaj wejscie postaci python3 {Stala.nazwaPliku} [nazwaKlasy] [nazwaOperacji] [argumenty]\n"
    napisKlasy = f"[nazwaKlasy] to \"{Stala.tabZnajomi}\" lub \"{Stala.tabKsiazki}\"\n"
    napisOperacji = f"[nazwaOperacji] to \"{Stala.pokazTekst}\", \"{Stala.dodajTekst}\", \"{Stala.zmienTekst}\", \"{Stala.wypozyczTekst}\" lub \"{Stala.oddajTekst}\"\n"
    napisPokaz = f"\"{Stala.pokazTekst}\" nie ma dodatkowych argumentow\n"
    napisDodajZnajomego = f"[argumenty] \"{Stala.dodajTekst}\" klasy \"{Stala.tabZnajomi}\" to [imie], [nazwisko] oraz [email]\n"
    napisDodajKsiazke = f"[argumenty] \"{Stala.dodajTekst}\" klasy \"{Stala.tabKsiazki}\" to [autor], [tytul] oraz [rok]\n"
    napisZmienZnajomego = f"[argumenty] \"{Stala.zmienTekst}\" klasy \"{Stala.tabZnajomi}\" to [id], [noweImie], [noweNazwisko] oraz [nowyEmail]\n"
    napisZmienKsiazke = f"[argumenty] \"{Stala.zmienTekst}\" klasy \"{Stala.tabKsiazki}\" to [id], [nowyAutor], [nowyTytul] oraz [nowyRok]\n"
    napisWypozycz = f"[argumenty] \"{Stala.wypozyczTekst}\" klasy \"{Stala.tabKsiazki}\" to [idKsiazki] [idZnajomego]\n"
    napisOddaj = f"[argumenty] \"{Stala.oddajTekst}\" klasy \"{Stala.tabKsiazki}\" to [idKsiazki] [idZnajomego]\n"
    napis1 = f"{napisPoczatkowy}{napisOgolny}{napisKlasy}{napisOperacji}{napisPokaz}{napisDodajZnajomego}"
    napis2 = f"{napisDodajKsiazke}{napisZmienZnajomego}{napisZmienKsiazke}{napisWypozycz}{napisOddaj}"
    print(f"{napis1}{napis2}", end="")

# 4. Dodawanie nowych ksiazek, wypozyczanie/oddawanie ksiazek -------------------------------------

def QueryZnajomy(session: Session, znajomyArg: list[str]):
    match znajomyArg[0]:
        case Stala.pokazTekst: # pokaz wszystkich znajomych w bazie danych
            listaZnajomych = session.query(Znajomy).all()
            for znajomy in listaZnajomych:
                print(znajomy)
        case Stala.dodajTekst: # dodawanie nowego znajomego do bazy danych
            id = len(session.query(Znajomy).all()) + 1
            nowy = Znajomy(id, znajomyArg[1], znajomyArg[2], znajomyArg[3])
            session.add(nowy)
            session.commit()
        case Stala.zmienTekst: # zmiana znajomego w bazie danych
            idZnajomego = znajomyArg[1]
            znajomy: Znajomy = session.query(Znajomy).filter_by(id = idZnajomego).first()
            if znajomy:
                znajomy.imie = znajomyArg[2]
                znajomy.nazwisko = znajomyArg[3]
                znajomy.email = znajomyArg[4]
                session.commit()
            else:
                print(f"Nie istnieje znajomy o id={idZnajomego}")
        case _:
            NapiszPomoc(f"Podano zle argumenty klasy {Stala.tabZnajomi}! Instrukcja obslugi:\n")

def QueryWypozyczyl(session: Session, idKsiazki: db.Integer, idZnajomego: db.Integer, czyDodaj: bool):
    ksiazka: Ksiazka = session.query(Ksiazka).filter_by(id = idKsiazki).first()
    if ksiazka: # jesli ksiazka o podanym id istnieje
        znajomy: Znajomy = session.query(Znajomy).filter_by(id = idZnajomego).first()
        if znajomy: # jesli znajomy o podanym id istnieje, usun/dodaj ksiazke z listy wypozyczonych
            if czyDodaj:
                znajomy.wypozyczyl.append(ksiazka)
            else:
                znajomy.wypozyczyl.remove(ksiazka)
            session.commit()
        else:
            print(f"Nie istnieje znajomy o id={idZnajomego}")
    else:
        print(f"Nie istnieje ksiazka o id={idKsiazki}")

def QueryKsiazka(session: Session, ksiazkaArg: list[str]):
    match ksiazkaArg[0]:
        case Stala.pokazTekst: # pokaz wszystkie ksiazki w bazie danych
            listaKsiazek = session.query(Ksiazka).all()
            for ksiazka in listaKsiazek:
                print(ksiazka)
        case Stala.dodajTekst: # dodawanie nowej ksiazki do bazy danych
            id = len(session.query(Ksiazka).all()) + 1
            nowa = Ksiazka(id, ksiazkaArg[1], ksiazkaArg[2], ksiazkaArg[3])
            session.add(nowa)
            session.commit()
        case Stala.zmienTekst: # zmiana znajomego w bazie danych
            idKsiazki = ksiazkaArg[1]
            ksiazka: Ksiazka = session.query(Ksiazka).filter_by(id = idKsiazki).first()
            if ksiazka:
                ksiazka.autor = ksiazkaArg[2]
                ksiazka.tytul = ksiazkaArg[3]
                ksiazka.rok = ksiazkaArg[4]
                session.commit()
            else:
                print(f"Nie istnieje ksiazka o id={idKsiazki}")
        case Stala.oddajTekst: # oddawanie ksiazki przez znajomego
            QueryWypozyczyl(session, ksiazkaArg[1], ksiazkaArg[2], False)
        case Stala.wypozyczTekst: # wypozyczanie ksiazki przez znajomego
            QueryWypozyczyl(session, ksiazkaArg[1], ksiazkaArg[2], True)
        case _:
            NapiszPomoc(f"Podano zle argumenty klasy {Stala.tabKsiazki}! Instrukcja obslugi:\n")

def Query(session: Session, mainArg: list[str]):
    match mainArg[1]:
        case Stala.tabZnajomi:
            QueryZnajomy(session, mainArg[2:])
        case Stala.tabKsiazki:
            QueryKsiazka(session, mainArg[2:])
        case Stala.helpTekst:
            NapiszPomoc()
        case _:
            NapiszPomoc("Podano zly typ klasy! Instrukcja obslugi:\n")

# 5. Wywolanie __main__ ---------------------------------------------------------------------------

if __name__ == "__main__":
    Base.metadata.create_all(engine)
    session = Session()

    if (len(sys.argv) < 2):
        NapiszPomoc()
    else:
        Query(session, sys.argv)
    session.close()

    # Przyklady uzycia:
    # 1. Dodawanie Ksiazka("George Orwell", "Rok 1984", 1949)
    # -- python3 zad1.py ksiazka --dodaj "George Orwell" "Rok 1984" 1949

    # 2. Dodawanie Znajomy("Jan", "Kowalski", "jankowalski@gmail.com")
    # -- python3 zad1.py znajomi --dodaj Jan Kowalski jankowalski@gmail.com
    
    # 3. Pokazywanie listy wszystkich znajomych (lub ksiazek)
    # -- python3 zad1.py znajomi (lub ksiazki) --pokaz

    # 4. Wypozyczenie (lub oddanie) ksiazki "Rok 1984" znajomemu "Jan"
    # zalozmy, ze "Rok 1984".id = 8, "Jan".id = 3
    # oba id mozna latwo zdobyc wywolujac metode 3 --pokaz
    # -- python3 zad1.py ksiazki --wypozycz (lub --oddaj) 8 3
    
    # 5. Zmienianie Znajomy z id = 8 na Znajomy("Jakub", "Nowak", "jakubnowak@gmail.com")
    # -- python3 zad1.py znajomi --zmien 8 Jakub Nowak jakubnowak@gmail.com