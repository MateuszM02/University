SELECT DISTINCT SalesLT.Address.City
FROM SalesLT.Address, SalesLT.SalesOrderHeader
WHERE SalesLT.Address.AddressID = SalesLT.SalesOrderHeader.ShipToAddressID
ORDER BY SalesLT.Address.City;
