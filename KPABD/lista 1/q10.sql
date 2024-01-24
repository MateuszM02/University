-- table M1 creation
IF NOT EXISTS (SELECT * from sysobjects where name='M1' and xtype='U')
    CREATE TABLE M1 (
	    K INT NOT NULL,
	    V VARCHAR(20),
	    PRIMARY KEY(K)
    );

-- table S1 creation
IF NOT EXISTS (SELECT * from sysobjects where name='S1' and xtype='U')
    CREATE TABLE S1 (
	    K INT NOT NULL,
	    MFK INT,
	    V VARCHAR(20),
	    PRIMARY KEY(K),
	    FOREIGN KEY (MFK) REFERENCES M1(K)
    );

-- table M2 creation
IF NOT EXISTS (SELECT * from sysobjects where name='M2' and xtype='U')
    CREATE TABLE M2 (
	    K1 INT NOT NULL,
	    K2 INT NOT NULL,
	    V VARCHAR(20),
	    PRIMARY KEY(K1, K2)
    );

-- table S2 creation
IF NOT EXISTS (SELECT * from sysobjects where name='S2' and xtype='U')
    CREATE TABLE S2 (
	    K INT NOT NULL,
	    MFK1 INT,
	    MFK2 INT,
	    V VARCHAR(20),
	    PRIMARY KEY(K),
	    FOREIGN KEY (MFK1, MFK2) REFERENCES M2(K1, K2)
    );

-- tests

--INSERT INTO M1
--VALUES (1, 'aaa'),
  --     (2, 'bbb')

SELECT * FROM M1

-- OK, since we inserted key 2 into M1
--INSERT INTO S1
--VALUES (21, 2, 'a')

SELECT * FROM S1

-- error -> no key 14 in M1
--INSERT INTO S1
--VALUES (20, 14, 'a')

-- test for m2, s2

INSERT INTO M2
VALUES (2, 3, 'm2')
SELECT * FROM M2

INSERT INTO S2
VALUES (42, 2, 3, 's2')
SELECT * FROM S2

/* ON UPDATE
default action -> RESTRICT (change of K in M1 is impossible if it is referencing to some row in S1)

NO ACTION -> DEFAULT

SET NULL -> set child data to NULL when parent is UPDATED

CASCADE -> update child data when parent is UPDATED

SET DEFAULT -> set child data to default when parent is UPDATED
*/