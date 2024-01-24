SELECT 
    SalesLT.Customer.FirstName, 
    SalesLT.Customer.LastName, 
    SUM(Detail.UnitPriceDiscount * Detail.OrderQty) AS DiscountSum
FROM 
    SalesLT.Customer, 
    SalesLT.SalesOrderDetail AS Detail, 
    SalesLT.SalesOrderHeader AS Header
WHERE 
    SalesLT.Customer.CustomerID = Header.CustomerID
    AND Detail.SalesOrderID = Header.SalesOrderID
GROUP BY 
    SalesLT.Customer.FirstName, SalesLT.Customer.LastName
ORDER BY DiscountSum DESC