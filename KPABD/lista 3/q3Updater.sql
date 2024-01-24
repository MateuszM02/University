SET NOCOUNT ON

IF object_id('L3T3_Products', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE L3T3_Products (
        ID INT PRIMARY KEY,
        ProductName VARCHAR(30)
    )
    INSERT INTO L3T3_Products VALUES
    (1, 'Water'),
    (2, 'Milk'),
    (3, 'Tea')
END

IF object_id('L3T3_Rates', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE L3T3_Rates (
        Currency VARCHAR(20) PRIMARY KEY,
        PricePLN DECIMAL(18, 2)
    )
    INSERT INTO L3T3_Rates VALUES
    ('Dollar', 4.03),
    ('Euro', 4.40),
    ('Franc', 4.54),
    ('PLN', 1.00),
    ('Pound', 5.01)
END

IF object_id('L3T3_Prices', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE L3T3_Prices (
        ProductID INT REFERENCES L3T3_Products(ID),
        Currency VARCHAR(20) REFERENCES L3T3_Rates(Currency),
        Price DECIMAL(18, 2),
        PRIMARY KEY(ProductID, Currency)
    )
    INSERT INTO L3T3_Prices VALUES 
    (1, 'PLN', 2.30), 
    (2, 'PLN', 3.49), 
    (3, 'PLN', 14.99),
    (1, 'Euro', 0.52), 
    (2, 'Dollar', 0.87), 
    (3, 'Franc', 3.30),
    (3, 'Pound', 2.99)
END

PRINT 'Before update of L3T3_Prices:'
PRINT ''
SELECT * FROM L3T3_Prices 

-- Declare variables
DECLARE @ProductID INT, @Currency VARCHAR(10), @PriceInThatCurrency DECIMAL(18,2), @ExchangeRate DECIMAL(18,2), @PriceInPLN DECIMAL(18,2)

-- Declare cursor for L3T3_Prices table
DECLARE PriceCursor CURSOR FOR
SELECT ProductID, Currency, Price FROM L3T3_Prices

-- Open cursor and fetch the first row
OPEN PriceCursor
FETCH NEXT FROM PriceCursor INTO @ProductID, @Currency, @PriceInThatCurrency

-- Loop through the rows of L3T3_Prices table
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Check if the currency exists in L3T3_Rates table
    IF EXISTS (SELECT 1 FROM L3T3_Rates WHERE Currency = @Currency)
    BEGIN
        -- Get the exchange rate from L3T3_Rates table
        SELECT @ExchangeRate = PricePLN FROM L3T3_Rates WHERE Currency = @Currency
        -- Get the price of product in PLN from L3T3_Prices table
        SELECT @PriceInPLN = Price FROM L3T3_Prices WHERE ProductID = @ProductID AND Currency = 'PLN'

        -- Update the price in L3T3_Prices table based on the rate
        UPDATE L3T3_Prices 
        SET Price = @PriceInPLN / @ExchangeRate 
        WHERE ProductID = @ProductID AND Currency = @Currency
    END
    ELSE
    BEGIN
        -- Delete the row in L3T3_Prices table if the currency does not exist in L3T3_Rates table
        DELETE FROM L3T3_Prices WHERE ProductID = @ProductID AND Currency = @Currency
    END

    -- Fetch the next row
    FETCH NEXT FROM PriceCursor INTO @ProductID, @Currency, @PriceInThatCurrency
END

-- Close and deallocate the cursor
CLOSE PriceCursor
DEALLOCATE PriceCursor

PRINT ''
PRINT 'After update of L3T3_Prices:'
PRINT ''
SELECT * FROM L3T3_Prices