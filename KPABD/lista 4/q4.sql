DROP TRIGGER IF EXISTS tr_max_specimens
GO

CREATE TRIGGER tr_max_specimens
ON Egzemplarz
AFTER INSERT
AS
BEGIN
	DECLARE c_inserted CURSOR FOR
	SELECT * FROM inserted;
	OPEN c_inserted;

	DECLARE @specimen_id INT;
	DECLARE @signature CHAR(8);
	DECLARE @book_id INT;
	DECLARE @number_of_specimens INT;

	FETCH NEXT FROM c_inserted INTO
		@specimen_id,
		@signature,
		@book_id;

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SELECT @number_of_specimens = COUNT(Egzemplarz_ID) FROM Egzemplarz
		WHERE Książka_ID = @book_id;

		IF @number_of_specimens > 5
			DELETE FROM Egzemplarz WHERE Egzemplarz_ID = @specimen_id;

		FETCH NEXT FROM c_inserted INTO
			@specimen_id,
			@signature,
			@book_id;
	END;

	CLOSE c_inserted;
	DEALLOCATE c_inserted;
END;
GO

SELECT Książka_ID, COUNT(Egzemplarz_ID) [Number of specimens] FROM Egzemplarz
GROUP BY Książka_ID
ORDER BY [Number of specimens];

/*
INSERT INTO Egzemplarz 
	(Sygnatura, Książka_ID)
VALUES
	('S0014', 3),
	('S0015', 3),
	('S0016', 3),
	('S0017', 3);
*/ 

/*
DELETE FROM Egzemplarz
WHERE Sygnatura IN ('S0014', 'S0015')
*/

SELECT * FROM Egzemplarz
WHERE Książka_ID = 3;