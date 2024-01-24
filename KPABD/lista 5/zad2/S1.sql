drop table if exists liczby1;

create table liczby1 ( liczba int )

insert into liczby1 Values (1)

set tran isolation level read uncommitted
begin tran
Update dbo.liczby1 set liczba = 10

--robimy select w drugiej transakcji
Commit


set tran isolation level read uncommitted
begin tran
Update dbo.liczby1 set liczba = 10

--robimy select w drugiej transakcji
Commit


set tran isolation level read uncommitted
begin tran
select * from dbo.liczby1

--czekamy na koniec transakcji drugiej
Commit

set tran isolation level read uncommitted
begin tran
insert into liczby1 Values (30)

--robimy select w drugiej transakcji
Commit