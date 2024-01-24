SET NOCOUNT ON

IF object_id('L3T4_Employees', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE L3T4_Employees (
        ID INT IDENTITY PRIMARY KEY,
        SalaryGros DECIMAL(10, 2)
    )
    INSERT INTO L3T4_Employees (SalaryGros) VALUES
    (15000.00),
    (4321.11),
    (2137.00),
    (15000.45),
    (9999.99),
    (6666.66)
END

IF object_id('L3T4_SalaryHistory', 'U') is null -- create table if doesn't exist
BEGIN
    CREATE TABLE L3T4_SalaryHistory (
        ID INT IDENTITY PRIMARY KEY,
        EmployeeID INT FOREIGN KEY REFERENCES L3T4_Employees(ID),
        _Year INT,
        _Month INT,
        SalaryNet DECIMAL(10, 2),
        SalaryGros DECIMAL(10, 2)
    )
    INSERT INTO L3T4_SalaryHistory (EmployeeID, _Year, _Month, SalaryGros) VALUES
    (1, YEAR(GETDATE()), 1, 15000.00),
    (1, YEAR(GETDATE()), 2, 15000.00), -- 30 000
    (1, YEAR(GETDATE()), 3, 15000.00), -- 45 000
    (1, YEAR(GETDATE()), 4, 15000.00), -- 60 000
    (1, YEAR(GETDATE()), 5, 15000.00), -- 75 000
    (1, YEAR(GETDATE()), 6, 15000.00), -- 90 000
    (1, YEAR(GETDATE()), 7, 15000.00), -- 105 000
    (1, YEAR(GETDATE()), 8, 15000.00), -- 120 000 (tax threshold)
    (1, YEAR(GETDATE()), 9, 15000.00), -- 135 000
    (1, YEAR(GETDATE()), 10, 15000.00), -- 150 000
    (1, YEAR(GETDATE()), 11, 15000.00); -- 165 000
END

DROP PROCEDURE IF EXISTS ComputeSalary
GO

-- Declare function
CREATE PROCEDURE ComputeSalary @Month INT AS
BEGIN
    -- declare constant variables that has same values for each employee
    DECLARE @TaxThreshold DECIMAL(10, 2) = 120000,
            @TaxAddition DECIMAL(10, 2) = 15300,
            @TaxBelow DECIMAL(10, 2) = 0.17,
            @TaxAbove DECIMAL(10, 2) = 0.32;
    
    -- declare table that determines how much to pay this month to each employee
    DECLARE @SalariesToBePaidThisMonth TABLE(
    ID INT PRIMARY KEY,
    SalaryGross DECIMAL(10, 2),
    SalaryNet DECIMAL(10, 2)
    )
    
    -- declare cursor for L3T4_Employees
    DECLARE @CurrentID INT = 0;
    DECLARE EmployeeCursor CURSOR STATIC FOR
    SELECT ID FROM L3T4_Employees

    OPEN EmployeeCursor
    FETCH NEXT FROM EmployeeCursor INTO @CurrentID

    WHILE ( @@FETCH_STATUS = 0 ) -- for each employee
    BEGIN
        -- declare variables for this employee
        DECLARE @SalaryGrosThisMonth DECIMAL(10, 2) = 0,
                @TotalIncome DECIMAL(10, 2) = 0,
                @SalaryNetToBePaid DECIMAL(10, 2) = 0;

        -- declare cursor for employee's history --------------------------------------------------
        DECLARE HistoryCursor CURSOR FOR
        SELECT SalaryGros FROM L3T4_SalaryHistory WHERE EmployeeID = @CurrentID AND _Month < @Month
        
        OPEN HistoryCursor
        FETCH NEXT FROM HistoryCursor INTO @SalaryGrosThisMonth

        WHILE (  @@FETCH_STATUS = 0) -- for each salary employee received this year
        BEGIN
            PRINT 'history'
            SET @TotalIncome += @SalaryGrosThisMonth;
            FETCH NEXT FROM HistoryCursor INTO @SalaryGrosThisMonth
        END

        CLOSE HistoryCursor
        DEALLOCATE HistoryCursor

        -- calculate salary net of this employee for this month -----------------------------------
        DECLARE @CurrentSalaryGros DECIMAL(10, 2) = 0; -- first get current gros salary
        SELECT @CurrentSalaryGros = E.SalaryGros FROM L3T4_Employees E WHERE E.ID = @CurrentID
        
        IF @TotalIncome <= @TaxThreshold
            SET @SalaryNetToBePaid = @CurrentSalaryGros * (1 - @TaxBelow)
        ELSE
            SET @SalaryNetToBePaid = @CurrentSalaryGros - ( (@CurrentSalaryGros * @TaxAbove) - (@TaxAddition / @Month) );

        -- insert that salary to this month salaries table ----------------------------------------
        INSERT INTO @SalariesToBePaidThisMonth VALUES(@CurrentID, @CurrentSalaryGros, @SalaryNetToBePaid)
        -- fetch next employee
        FETCH NEXT FROM EmployeeCursor INTO @CurrentID
    END
    
    CLOSE EmployeeCursor
    DEALLOCATE EmployeeCursor

    SELECT * FROM @SalariesToBePaidThisMonth
END
GO

DECLARE @SalariesToBePaid TABLE(
    ID INT PRIMARY KEY,
    SalaryGross DECIMAL(10, 2),
    SalaryNet DECIMAL(10, 2)
    )

-- ID = 1 before hitting tax threshold
INSERT INTO @SalariesToBePaid EXEC ComputeSalary 6
SELECT * FROM @SalariesToBePaid
DELETE FROM @SalariesToBePaid

-- ID = 1 after hitting tax threshold
INSERT INTO @SalariesToBePaid EXEC ComputeSalary 12
SELECT * FROM @SalariesToBePaid