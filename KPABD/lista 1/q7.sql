IF NOT EXISTS -- if table doesnt exist, create it
    (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Test')
    BEGIN
        CREATE TABLE Test (
            ID INT IDENTITY(1000, 10) PRIMARY KEY,
            Val VARCHAR(255)
        );
    END

-- Insert a record into the "Test" table
INSERT INTO Test(Val) VALUES('Sample Data');

-- Using @@IDENTITY to get the last identity value generated in the current session
SELECT @@IDENTITY AS "Last @@Identity Value";

-- Using IDENT_CURRENT to get the last identity value for the "Test" table
SELECT IDENT_CURRENT('Test') AS "Last Ident_Current('Test') Value";