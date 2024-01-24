SELECT
    SalesLT.Address.City, -- name of city
    COUNT(DISTINCT SalesLT.Customer.CustomerID) as "number of customers", -- number of customers from that city
    COUNT(DISTINCT SalesLT.Customer.SalesPerson) as "number of sales people" -- number of sales people from that city
FROM 
    SalesLT.CustomerAddress 
LEFT JOIN 
    SalesLT.Address ON SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID
LEFT JOIN 
    SalesLT.Customer ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
GROUP BY SalesLt.Address.City;