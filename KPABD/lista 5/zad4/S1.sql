-- From tests we know that read commited allows, but repeateable read has deadlock
DROP TABLE IF EXISTS liczby1;
GO
DROP TABLE IF EXISTS liczby2;
GO
create table liczby1 ( liczba int );
GO
create table liczby2 ( liczba int );
GO

Set transaction isolation level read committed
--Set transaction isolation level repeatable read
--Set transaction isolation level serializable
begin transaction
insert dbo.liczby1 values ( 1 )
--WAITFOR DELAY '00:00:01';

S1:
update dbo.liczby2 set liczba=10
commit