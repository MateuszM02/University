SELECT 
    SalesLT.ProductCategory.Name AS "Category name", SalesLT.Product.Name AS "Product name"
FROM 
    SalesLT.Product LEFT JOIN SalesLT.ProductCategory -- create table of products with their categories (could be NULL)
on -- join condition - IDs must match
    SalesLT.ProductCategory.ProductCategoryID = SalesLT.Product.ProductCategoryID
WHERE -- those categories which are non-leafs
    SalesLT.Product.ProductCategoryID
IN 
    (SELECT SalesLT.ProductCategory.ParentProductCategoryID FROM SalesLT.ProductCategory) -- table of non-leafs