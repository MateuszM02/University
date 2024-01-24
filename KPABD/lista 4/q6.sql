-- Drop the existing tables
DROP TABLE IF EXISTS L4T6_Cache; 
GO 
DROP TABLE IF EXISTS L4T6_History; 
GO 
DROP TABLE IF EXISTS L4T6_Parameters; 
GO 

-- Create a table to store the cached URLs and their last access time
CREATE TABLE L4T6_Cache(
    ID INT IDENTITY PRIMARY KEY,
    UrlAddress VARCHAR(256) NOT NULL,
    LastAccess DATETIME2 NOT NULL
); 
GO 

-- Create a table to store the history of URLs and their last access time
CREATE TABLE L4T6_History(
    ID INT IDENTITY PRIMARY KEY,
    UrlAddress VARCHAR(256) NOT NULL,
    LastAccess DATETIME2 NOT NULL
); 
GO 

-- Create a table to store the parameters for the cache
CREATE TABLE L4T6_Parameters(
    Name VARCHAR(256) NOT NULL,
    val INT NOT NULL
); 
GO 

-- Insert the maximum size of the cache as a parameter
INSERT INTO L4T6_Parameters VALUES ('max_L4T6_Cache', 2); 
GO 

-- Insert two initial URLs into the cache
INSERT INTO L4T6_Cache (UrlAddress, LastAccess) 
VALUES ('https://google.com', CURRENT_TIMESTAMP), 
       ('https://bing.com', CURRENT_TIMESTAMP); 
GO 

-- Create a trigger that executes instead of inserting into the cache table ------------------------------------------------
CREATE TRIGGER tr_L4T6_Cache_insert ON L4T6_Cache 
INSTEAD OF INSERT 
AS 
BEGIN 
    -- Declare variables to store the inserted URL and its last access time
    declare @new_website varchar(200) 
    declare @new_date datetime 
    -- Select the values from the inserted row
    SELECT @new_website = URLAddress, @new_date = LastAccess 
    FROM inserted 
    -- Check if the inserted URL already exists in the cache
    IF EXISTS(SELECT * FROM L4T6_Cache WHERE URLAddress = @new_website) 
    BEGIN 
        -- If yes, update the last access time of the existing row
        UPDATE L4T6_Cache 
        SET LastAccess = @new_date 
        WHERE URLAddress = @new_website 
        -- Return without inserting a new row
        RETURN 
    END 
    -- Declare a variable to store the maximum size of the cache
    declare @max_cache INT 
    -- Select the value from the parameters table
    set @max_cache = (select CAST(val as int) FROM L4T6_Parameters WHERE Name = 'max_cache') 
    -- Check if the cache is full
    IF (SELECT COUNT(*) FROM L4T6_Cache) = @max_cache 
    BEGIN 
        -- Declare variables to store the oldest URL and its last access time
        declare @idx int 
        declare @old_website varchar(200) 
        declare @old_date DATETIME 
        -- Select the values from the cache table ordered by last access time ascending
        SELECT TOP 1 @idx = ID, @old_website = URLAddress, @old_date = LastAccess 
        FROM L4T6_Cache 
        ORDER BY LastAccess ASC 
        -- Delete the oldest row from the cache
        DELETE FROM L4T6_Cache 
        WHERE ID=@idx 
        -- Insert the deleted row into the history table
        INSERT INTO L4T6_History (URLAddress, LastAccess) 
        VALUES (@old_website, @old_date) 
    END 
    -- Insert the new row into the cache table
    INSERT INTO L4T6_Cache (URLAddress, LastAccess) 
    VALUES (@new_website, @new_date) 
END 
GO 

-- Create a trigger that executes instead of inserting into the history table ----------------------------------------------
CREATE TRIGGER tr_history_insert ON L4T6_History 
INSTEAD OF INSERT 
AS 
BEGIN 
    -- Declare variables to store the inserted URL and its last access time
    declare @new_website varchar(200) 
    declare @new_date datetime 
    -- Select the values from the inserted row
    SELECT @new_website = URLAddress, @new_date = LastAccess 
    FROM inserted 
    -- Check if the inserted URL already exists in the history
    IF EXISTS(SELECT * FROM L4T6_History WHERE URLAddress = @new_website) 
    BEGIN 
        -- If yes, update the last access time of the existing row
        UPDATE L4T6_History 
        SET LastAccess=@new_date 
        WHERE URLAddress = @new_website 
    END 
    ELSE 
    BEGIN 
        -- If no, insert the new row into the history table
        INSERT INTO L4T6_History (URLAddress, LastAccess) 
        VALUES (@new_website, @new_date) 
    END 
END 
GO 

-- tests -------------------------------------------------------------------------------------------------------------------

-- Select all rows from the cache table
SELECT * FROM L4T6_Cache; 
-- Select all rows from the history table
SELECT * FROM L4T6_History; 

-- Insert a URL into the cache table that already exists
INSERT INTO L4T6_Cache (UrlAddress, LastAccess) 
VALUES ('https://google.com', CURRENT_TIMESTAMP); 
GO 
-- Select all rows from the cache table
SELECT * FROM L4T6_Cache; 
-- Select all rows from the history table
SELECT * FROM L4T6_History; 

-- Insert a new URL into the cache table that does not exist
INSERT INTO L4T6_Cache (UrlAddress, LastAccess) 
VALUES ('https://youtube.com', CURRENT_TIMESTAMP); 
GO 
-- Select all rows from the cache table
SELECT * FROM L4T6_Cache; 
-- Select all rows from the history table
SELECT * FROM L4T6_History; 

-- Insert another new URL into the cache table that does not exist
INSERT INTO L4T6_Cache (UrlAddress, LastAccess) 
VALUES ('https://facebook.com', CURRENT_TIMESTAMP); 
GO 
-- Select all rows from the cache table
SELECT * FROM L4T6_Cache; 
-- Select all rows from the history table
SELECT * FROM L4T6_History; 

-- Insert one more new URL into the cache table that does not exist
INSERT INTO L4T6_Cache (UrlAddress, LastAccess) 
VALUES ('https://reddit.com', CURRENT_TIMESTAMP); 
GO 
-- Select all rows from the cache table
SELECT * FROM L4T6_Cache; 
-- Select all rows from the history table
SELECT * FROM L4T6_History;
