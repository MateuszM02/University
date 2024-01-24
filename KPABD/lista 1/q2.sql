SELECT 
    SalesLT.ProductModel.Name, 
    COUNT(SalesLT.Product.ProductID) AS ProductCount
FROM 
    SalesLT.ProductModel, 
    SalesLT.Product
WHERE 
    SalesLT.ProductModel.ProductModelID = SalesLT.Product.ProductModelID
GROUP BY SalesLT.ProductModel.Name
HAVING ProductCount > 1