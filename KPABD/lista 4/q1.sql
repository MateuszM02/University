SET NOCOUNT ON
GO

DROP TRIGGER IF EXISTS SalesLT.update_modified_date
GO

CREATE TRIGGER update_modified_date ON SalesLT.Customer
AFTER UPDATE
AS
BEGIN
    UPDATE SalesLT.Customer
    SET ModifiedDate = GETDATE() -- change date to current date
    FROM SalesLT.Customer
    INNER JOIN inserted
    ON SalesLT.Customer.CustomerID = inserted.CustomerID
END
GO

-- data to be changed for customer 1
DECLARE @old_date DATETIME = CAST('2005-08-01 00:00:00.000' as datetime)
DECLARE @old_FirstName VARCHAR(20) = 'Orlando'
DECLARE @new_FirstName VARCHAR(20) = 'John'

-- UPDATE SalesLT.Customer
-- SET FirstName = @old_FirstName
-- WHERE CustomerID = 1 -- change date only for 1 customer

-- show date of customer 1 before update
SELECT CustomerID, FirstName, ModifiedDate
FROM SalesLT.Customer
WHERE CustomerID = 1

-- updating FirstName will trigger update_modified_date
UPDATE SalesLT.Customer
SET FirstName = @new_FirstName
WHERE CustomerID = 1 -- change date only for 1 customer

-- show date of customer 1 after update 
SELECT CustomerID, FirstName, ModifiedDate
FROM SalesLT.Customer
WHERE CustomerID = 1