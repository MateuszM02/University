-- Creating copy of table in standard way

DROP TABLE IF EXISTS L3T1_CustomerBackup

DECLARE @time_start DATETIME;
DECLARE @time_end DATETIME;
SET @time_start = GETDATE()

SELECT * INTO L3T1_CustomerBackup FROM SalesLT.Customer;
SET @time_end = GETDATE()
SELECT DATEDIFF(millisecond, @time_start, @time_end) AS "elapsed_ms (typical way)";

-- Creating copy of table using cursor

DROP TABLE IF EXISTS L3T1_CustomerBackup;
GO

DECLARE @time_start DATETIME;
DECLARE @time_end DATETIME;
SET @time_start = GETDATE()
CREATE TABLE L3T1_CustomerBackup(
    CustomerID INT, NameStyle VARCHAR(10), Title NVARCHAR(8), FirstName VARCHAR(20), 
    MiddleName VARCHAR(20), LastName VARCHAR(20), Suffix NVARCHAR(10), CompanyName NVARCHAR(128),
    SalesPerson NVARCHAR(256), EmailAddress NVARCHAR(50), Phone VARCHAR(20), PasswordHash VARCHAR(128),
    PasswordSalt VARCHAR(10), rowguid VARCHAR(50), ModifiedDate DATETIME)

--SELECT * INTO L3T1_CustomerBackup FROM SalesLT.Customer;
-- 1. define variables to use in cursor
DECLARE @CustomerID INT, @NameStyle VARCHAR(10), @Title NVARCHAR(8), @FirstName VARCHAR(20), 
        @MiddleName VARCHAR(20), @LastName VARCHAR(20), @Suffix NVARCHAR(10), @CompanyName NVARCHAR(128),
        @SalesPerson NVARCHAR(256), @EmailAddress NVARCHAR(50), @Phone VARCHAR(20), @PasswordHash VARCHAR(128),
        @PasswordSalt VARCHAR(10), @rowguid VARCHAR(50), @ModifiedDate DATETIME;

-- 2. declare and open cursor for table SalesLT.Customer
DECLARE table_cursor CURSOR FOR SELECT 
    CustomerID, NameStyle, Title, FirstName, 
    MiddleName, LastName, Suffix, CompanyName,
    SalesPerson, EmailAddress, Phone, PasswordHash,
    PasswordSalt, rowguid, ModifiedDate
FROM SalesLT.Customer;
OPEN table_cursor;

-- 3. Fetch data from table SalesLT.Customer into variables
FETCH NEXT FROM table_cursor INTO
    @CustomerID, @NameStyle, @Title, @FirstName, 
    @MiddleName, @LastName, @Suffix, @CompanyName,
    @SalesPerson, @EmailAddress, @Phone, @PasswordHash,
    @PasswordSalt, @rowguid, @ModifiedDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO L3T1_CustomerBackup(
        CustomerID, NameStyle, Title, FirstName, 
        MiddleName, LastName, Suffix, CompanyName,
        SalesPerson, EmailAddress, Phone, PasswordHash,
        PasswordSalt, rowguid, ModifiedDate
    )
    VALUES(
        @CustomerID, @NameStyle, @Title, @FirstName, 
        @MiddleName, @LastName, @Suffix, @CompanyName,
        @SalesPerson, @EmailAddress, @Phone, @PasswordHash,
        @PasswordSalt, @rowguid, @ModifiedDate);
    FETCH NEXT FROM table_cursor INTO
        @CustomerID, @NameStyle, @Title, @FirstName, 
        @MiddleName, @LastName, @Suffix, @CompanyName,
        @SalesPerson, @EmailAddress, @Phone, @PasswordHash,
        @PasswordSalt, @rowguid, @ModifiedDate;
END

-- 4. Close and deallocate cursor
CLOSE table_cursor;
DEALLOCATE table_cursor;
SET @time_end = GETDATE()
SELECT DATEDIFF(millisecond, @time_start, @time_end) AS "elapsed_ms (using cursor)";