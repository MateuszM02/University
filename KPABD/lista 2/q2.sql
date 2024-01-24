-- dropping tables from previous Runs
DROP TABLE IF EXISTS fldata;
DROP TABLE IF EXISTS firstnames;
DROP TABLE IF EXISTS lastnames;

-- creating tables
CREATE TABLE firstnames
(
  id INT PRIMARY KEY,
  firstname CHAR(20)
);

CREATE TABLE lastnames
(
  id INT PRIMARY KEY,
  lastname CHAR(20)
);

CREATE TABLE fldata
(
  firstname CHAR(20),
  lastname CHAR(20),
  CONSTRAINT fldata_KEY PRIMARY KEY (firstname, lastname)
);

-- insert test data
INSERT INTO firstnames (id, firstname)
VALUES
(1, 'Cristiano'),
(2, 'Lionel'),
(3, 'Robert'),
(4, 'Kevin'),
(5, 'Martin');

INSERT INTO lastnames (id, lastname)
VALUES
(1, 'Ronaldo'),
(2, 'Messi'),
(3, 'Lewandowski'),
(4, 'De Bruyne'),
(5, 'Odegard');

-- random data function
DROP PROCEDURE IF EXISTS insertRandomData;
GO

CREATE PROCEDURE insertRandomData @n INT AS
BEGIN
    DECLARE @totalPairs INT = (SELECT COUNT(*) FROM firstnames) * (SELECT COUNT(*) FROM lastnames);

    IF @n > @totalPairs
        THROW 50110, 'The n parameter is larger than the total possible pairs.', 1;
    
    DELETE FROM fldata; -- First, clear the table

    DECLARE @i INT = 0;

    WHILE @i < @n
    BEGIN
        DECLARE @firstname VARCHAR(20), @lastname VARCHAR(20);

        -- Generate a random pair of names
        WITH RandomFirstName AS (
            SELECT TOP 1 firstname FROM firstnames ORDER BY NEWID()
        ),
        RandomLastName AS (
            SELECT TOP 1 lastname FROM lastnames ORDER BY NEWID()
        )
        SELECT @firstname = firstname, @lastname = lastname
        FROM RandomFirstName, RandomLastName;

        -- Check if the pair already exists in fldata
        IF NOT EXISTS (SELECT 1 FROM fldata WHERE firstname = @firstname AND lastname = @lastname)
        BEGIN
            INSERT INTO fldata (firstname, lastname) VALUES (@firstname, @lastname);
            SET @i = @i + 1;
        END;
    END
END;
GO

EXEC insertRandomData 26; -- 25 is max

SELECT * FROM fldata
