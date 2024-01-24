dbcc dropcleanbuffers; dbcc freeproccache;
GO

SET STATISTICS TIME ON

-- Example 1. A lot of JOINs
SELECT DISTINCT c.PESEL, c.Nazwisko
FROM Egzemplarz e
JOIN Ksiazka k ON e.Ksiazka_ID = k.Ksiazka_ID
JOIN Wypozyczenie w ON e.Egzemplarz_ID = w.Egzemplarz_ID
JOIN Czytelnik c ON c.Czytelnik_ID = w.Czytelnik_ID;

-- Example 2. Less JOINs but still a few
SELECT c.PESEL, c.Nazwisko
FROM Czytelnik c WHERE c.Czytelnik_ID IN
(SELECT w.Czytelnik_ID FROM Wypozyczenie w
JOIN Egzemplarz e ON e.Egzemplarz_ID = w.Egzemplarz_ID
JOIN Ksiazka k ON e.Ksiazka_ID = k.Ksiazka_ID)

-- Example 3. No JOINs
SELECT c.PESEL, c.Nazwisko
FROM Czytelnik c WHERE c.Czytelnik_ID IN
(SELECT w.Czytelnik_ID FROM Wypozyczenie w, Egzemplarz e, Ksiazka k
WHERE e.Egzemplarz_ID = w.Egzemplarz_ID
AND e.Ksiazka_ID = k.Ksiazka_ID)

SET STATISTICS TIME OFF