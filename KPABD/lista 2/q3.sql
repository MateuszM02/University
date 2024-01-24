DROP PROCEDURE IF EXISTS createReader 
GO

CREATE PROCEDURE createReader 
    @pesel CHAR(11), 
    @lastname VARCHAR(30), 
    @city VARCHAR(30), 
    @birthDate DATE 
    -- @ostatnie_Wypozyczenie DATE = NULL
AS
BEGIN
    DECLARE @surname_len INT = LEN (@lastname)
    DECLARE @pesel_len INT = LEN(@pesel)

    -- pesel verification
    IF (@pesel_len != 11)
        THROW 50110, 'PESEL should have 11 numbers.', 1; 
    
    DECLARE @pesel_date DATE -- date from PESEL
    DECLARE @weights VARCHAR(11) = '13791379131'
    
    DECLARE @i INT = 1 -- table indexed from 1
    DECLARE @char INT  -- current character
    DECLARE @pesel_sum INT = 0 -- control sum

    WHILE (@i <= 11)
    BEGIN
        DECLARE @c CHAR = SUBSTRING(@pesel, @i, 1)
        -- check if char is a number (using ASCII cast)
        IF (@c < '0') OR (@c > '9')
            THROW 50111, 'PESEL should have only numbers.', 1; 

        SET @char = @c

        SET @pesel_sum += CAST(SUBSTRING(@weights, @i, 1) as INT) * @char
        SET @i = @i + 1
    END
    
    -- PRINT @pesel_sum
    -- PRINT 'control sum: ' + CAST(@pesel_sum as VARCHAR)

    IF ((@pesel_sum % 10) != 0)
        THROW 50112, 'PESEL have wrong control sum', 1;
    
    DECLARE @pesel_year INT     = SUBSTRING(@pesel, 1, 2)
    DECLARE @pesel_month INT = SUBSTRING(@pesel, 3, 2)
    DECLARE @year INT = 1900 + @pesel_year

    -- from first digit of month there are extra news about years
    -- 8/9 -> 1800-1899
    -- 0/1 -> 1900-1999
    -- 2/3 -> 2000-2099
    -- 4/5 -> 2100-2199
    -- 6/7 -> 2200-2299
    DECLARE @pesel_add INT = SUBSTRING(@pesel, 3, 1)

    IF (@pesel_add >= 8)
        SET @year -= 100
    ELSE IF (@pesel_add >= 2)
        SET @year += (@pesel_add / 2) * 100
    
    -- months after october demands modulo (11, 31, 51 vs 01, 21, 41)
    DECLARE @month INT = (@pesel_add % 2) * 10 + SUBSTRING(@pesel, 4, 1)

    -- conversion of ints - day, month, year to datetime
    SET @pesel_date = CAST(
            CAST(@year AS VARCHAR(4)) +
            RIGHT('0' + CAST(@month AS VARCHAR(2)), 2) +
            SUBSTRING(@pesel, 5, 2)
        AS DATETIME)
    
    -- PRINT @pesel_date

    -- surname verification
    IF (@surname_len < 2)
       THROW 50113, 'surname is too short!', 1;
    
    IF LEFT(@lastname, 1) != UPPER(LEFT(@lastname, 1)) COLLATE Latin1_General_CS_AS
        THROW 50114, 'surname should start with uppercase.', 1;
    
    IF RIGHT(@lastname, @surname_len - 1) != LOWER(RIGHT(@lastname, @surname_len - 1)) COLLATE Latin1_General_CS_AS
        THROW 50115, 'Only first letter of surname should be uppercase.', 1;
    
    -- verify date of birth
    IF ISDATE(CAST(@birthDate AS varchar)) = 0
        THROW 50116, 'Invalid Date of birth.', 1;
    IF @pesel_date != @birthDate
        THROW 50116, 'Date of birth doesnt match PESEL.', 1;

    -- all tests passed - add reader
    INSERT INTO Czytelnik (PESEL, Nazwisko, Miasto, Data_Urodzenia) VALUES
        (@pesel, @lastname, @city, @birthDate)

END
GO

DELETE FROM Czytelnik WHERE Czytelnik.PESEL = '02280105673'; -- making sure to not get error inserting duplicate
-- Test Case 1: Valid input
DECLARE @pesel1 CHAR(11) = '02280105673';
DECLARE @lastname1 VARCHAR(30) = 'Kowalski';
DECLARE @city1 VARCHAR(30) = 'Wroclaw';
DECLARE @birthDate1 DATE = '2002-08-01';

-- Test Case 2: Invalid PESEL (incorrect length)
DECLARE @pesel2 CHAR(11) = '12345';  -- Invalid PESEL
DECLARE @lastname2 VARCHAR(30) = 'Nowak';
DECLARE @city2 VARCHAR(30) = 'Warszawa';
DECLARE @birthDate2 DATE = '1985-08-20';

-- Test Case 3: Invalid PESEL (non-numeric characters)
DECLARE @pesel3 CHAR(11) = '12a45678901';  -- Contains non-numeric characters
DECLARE @lastname3 VARCHAR(30) = 'Bosak';
DECLARE @city3 VARCHAR(30) = 'Bialystok';
DECLARE @birthDate3 DATE = '1978-03-10';

-- Test Case 4: Invalid PESEL (incorrect control sum)
DECLARE @pesel4 CHAR(11) = '12345678902';  -- Incorrect control sum
DECLARE @lastname4 VARCHAR(30) = 'Braun';
DECLARE @city4 VARCHAR(30) = 'Rzeszow';
DECLARE @birthDate4 DATE = '1992-12-03';

--DELETE FROM Czytelnik WHERE Czytelnik.PESEL = '92120332286';
-- Test Case 5: Invalid Date - doesn't match PESEL
DECLARE @pesel5 CHAR(11) = '92120332286';
DECLARE @lastname5 VARCHAR(30) = 'Lewandowski';
DECLARE @city5 VARCHAR(30) = 'Gdansk';
DECLARE @birthDate5 DATE = '1995-12-03'; -- wrong date/pesel duo

-- Ensure no errors occur
EXEC createReader @pesel1, @lastname1, @city1, @birthDate1;

-- Expect an error due to the incorrect PESEL length
--EXEC createReader @pesel2, @lastname2, @city2, @birthDate2;

-- Expect an error due to non-numeric characters in PESEL
--EXEC createReader @pesel3, @lastname3, @city3, @birthDate3;

-- Expect an error due to the incorrect control sum
--EXEC createReader @pesel4, @lastname4, @city4, @birthDate4;

-- Expect an error due to the invalid data
--EXEC createReader @pesel5, @lastname5, @city5, @birthDate5;