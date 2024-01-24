DROP FUNCTION IF EXISTS borrowed;
GO

CREATE FUNCTION borrowed (@days INT = 0) RETURNS TABLE
AS
RETURN
    SELECT Czytelnik.PESEL, COUNT(Wypozyczenie.Wypozyczenie_ID) AS NumberOfBorrowed
    FROM Czytelnik
    INNER JOIN Wypozyczenie ON Czytelnik.Czytelnik_ID = Wypozyczenie.Czytelnik_ID
    GROUP BY Czytelnik.PESEL
    HAVING MAX(DATEDIFF(day, Wypozyczenie.Data, GETDATE())) >= @days
GO

--SELECT * FROM borrowed(1350)
--SELECT * FROM borrowed(1370)
--SELECT * FROM borrowed(1385)