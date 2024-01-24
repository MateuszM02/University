/* ----------------------------------------------
how to add checking constraint to already existing table:
ALTER TABLE [TableName]
ADD CONSTRAINT [ConstraintName] CHECK (ID,LastName);
---------------------------------------------- */

/* ----------------------------------------------
Our constraint is in script 27 and looks like that:
CONSTRAINT  CK_SalesOrderHeader_ShipDate  CHECK  ([ShipDate] >= [OrderDate] OR   [ShipDate] IS NULL)
---------------------------------------------- */

-- disable specific constraint (replace the name with ALL to disable all constraints)
-- ALTER TABLE SalesLT.SalesOrderHeader NOCHECK CONSTRAINT --CK_SalesOrderHeader_ShipDate
ALTER TABLE SalesLT.SalesOrderHeader NOCHECK CONSTRAINT ALL

-- inserting faulty line into table
INSERT INTO SalesLT.SalesOrderHeader(DueDate, ShipDate, Comment, CustomerID, ShipMethod)
VALUES
    ('2008-06-13 00:00:00.000', NULL, 'badvalue', 12345, 'CARGO TRANSPORT 1')

-- enable specific constraint (ALL to enable every constraint)
-- ALTER TABLE SalesLT.SalesOrderHeader WITH CHECK CHECK CONSTRAINT CK_SalesOrderHeader_ShipDate
ALTER TABLE SalesLT.SalesOrderHeader WITH CHECK CHECK CONSTRAINT ALL


-- delete faulty line from table
/*
DELETE FROM SalesLT.SalesOrderHeader
WHERE Comment = 'badvalue'
*/

/* 
1. IF constraint is enabled, we get message: 
"The INSERT statement conflicted with the CHECK constraint "CK_SalesOrderHeader_DueDate". The conflict occurred in database [Name], table "SalesLT.SalesOrderHeader"."

2. IF constraint is disabled, we can add faulty line to table. Once we put constraint back, we get message: 
"The ALTER TABLE statement conflicted with the CHECK constraint "CK_SalesOrderHeader_DueDate". The conflict occurred in database [Name], table "SalesLT.SalesOrderHeader""
*/