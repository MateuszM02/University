set tran isolation level read uncommitted
begin tran
	select * from dbo.liczby1
COmmit


set tran isolation level read uncommitted
begin tran
Update dbo.liczby1 set liczba = 5
Commit


set tran isolation level read uncommitted
begin tran
	select * from dbo.liczby1
Commit