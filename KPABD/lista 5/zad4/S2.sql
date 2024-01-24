-- From tests we know that read commited allows, but repeateable read has deadlock
Set transaction isolation level read committed
--Set transaction isolation level repeatable read
--Set transaction isolation level serializable
begin transaction
insert dbo.liczby2 values ( 1 )

S2:
update dbo.liczby1 set liczba=10
Commit