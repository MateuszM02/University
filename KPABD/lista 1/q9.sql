--ALTER TABLE SalesLT.Customer
  --  ADD CreditCardNumber VARCHAR(20); -- adding new column named "CreditCardNumber" to table "Customer"

-- changing values of Code for 3 rows
UPDATE SalesLT.SalesOrderHeader
SET CreditCardApprovalCode = 12345
WHERE SalesLT.SalesOrderHeader.SalesOrderID = 71899

UPDATE SalesLT.SalesOrderHeader
SET CreditCardApprovalCode = 98765
WHERE SalesLT.SalesOrderHeader.SalesOrderID = 71935

UPDATE SalesLT.SalesOrderHeader
SET CreditCardApprovalCode = 13579
WHERE SalesLT.SalesOrderHeader.SalesOrderID = 71946

-- for customers (Customer) with orders (SalesOrderHeader) where CreditCardApprovalCode value is set, change the CreditCardNumber value for ’X’
UPDATE SalesLT.Customer
SET CreditCardNumber = 'X'
WHERE EXISTS (
    SELECT 1 FROM SalesLT.SalesOrderHeader
    WHERE SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerId
    AND SalesLT.SalesOrderHeader.CreditCardApprovalCode IS NOT NULL
    )