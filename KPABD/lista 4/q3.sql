-- trigger instead of let us override query insert/delete/update, in this example it let us add brand into dbo.brands

DROP TABLE IF EXISTS brand_approvals

IF object_id('dbo.brands', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE dbo.brands(
        brand_id INT IDENTITY PRIMARY KEY,
        brand_name VARCHAR(255) NOT NULL
    );
    INSERT INTO dbo.brands(brand_name) VALUES ('test1')
END
GO

IF object_id('dbo.brand_approvals', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE dbo.brand_approvals(
        brand_id INT IDENTITY PRIMARY KEY,
        brand_name VARCHAR(255) NOT NULL
    );
    INSERT INTO dbo.brand_approvals(brand_name) VALUES ('test2')
END
GO

-- create view -------------------------------------------------------------------------------------------------------------
DROP VIEW IF EXISTS dbo.vw_brands
GO

CREATE VIEW dbo.vw_brands 
AS
    SELECT
        brand_name,
        'Approved' approval_status
    FROM
        dbo.brands
    UNION
    SELECT
        brand_name,
        'Pending Approval' approval_status
    FROM
        dbo.brand_approvals;
GO

SELECT * FROM dbo.vw_brands -- 1 of 3
GO

-- create trigger ----------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS dbo.trg_vw_brands
GO

CREATE TRIGGER dbo.trg_vw_brands 
ON dbo.vw_brands
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.brand_approvals (brand_name)
    SELECT
        i.brand_name
    FROM
        inserted AS i
    WHERE
        i.brand_name NOT IN (
            SELECT 
                brand_name
            FROM
                dbo.brands
        );
END
GO

INSERT INTO dbo.vw_brands(brand_name)
VALUES('Eddy Merckx');

SELECT -- 2 of 3
	brand_name,
	approval_status
FROM
	dbo.vw_brands;
GO

SELECT * FROM dbo.brands
SELECT * from dbo.brand_approvals -- 3 of 3