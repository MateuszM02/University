DROP PROCEDURE IF EXISTS sumOfBorrows
DROP TYPE IF EXISTS Readers

CREATE TYPE Readers AS TABLE(reader_id INT)
GO

CREATE PROCEDURE sumOfBorrows @Czytelnicy Readers READONLY AS  
BEGIN
    SELECT r.reader_id, SUM(DATEDIFF(day, Wypozyczenie.Data, GETDATE())) as "suma_dni"
    FROM 
        @Czytelnicy r,
        Wypozyczenie
    WHERE
        r.reader_id = Wypozyczenie.Czytelnik_ID
    GROUP BY r.reader_id
END

DECLARE @temp Readers

INSERT INTO @temp(reader_id) 
VALUES (1), (2), (3)

EXEC sumOfBorrows @temp