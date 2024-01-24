
DROP PROCEDURE IF EXISTS ChangeTitle;
GO

CREATE PROCEDURE ChangeTitle @CustomerID INT, @NewTitle VARCHAR(10)
AS
BEGIN
    BEGIN TRANSACTION;
    SAVE TRANSACTION StartUpdate;

    UPDATE SalesLT.Customer
    SET Title = @NewTitle
    WHERE CustomerID = @CustomerID;

    -- If title is different than "Mr" or "Mrs", rollback
    IF @@ROWCOUNT > 0
        IF (SELECT Title FROM SalesLT.Customer WHERE CustomerID = @CustomerID) NOT IN ('Mr.', 'Mrs.')
            ROLLBACK TRANSACTION StartUpdate;

    COMMIT TRANSACTION;

    -- title after update
    SELECT Title AS "Title (after update)" FROM SalesLT.Customer 
    where CustomerID = @CustomerID
END
GO

EXEC ChangeTitle 1, 'Mr.'
EXEC ChangeTitle 1, 'Mrs.'
EXEC ChangeTitle 1, 'None.' -- doesnt change