drop table if exists liczby;
go
create table liczby ( liczba int );
go
insert liczby values ( 10 );
go

-- 1 --
set transaction isolation level repeatable read;
begin transaction

-- w drugim po��czeniu robimy update: update liczby set liczba=4
-- translock

select * from liczby

-- ponownie w drugim po��czeniu robimy update: update liczby set liczba=4
-- translock

commit

-- 2 --
set transaction isolation level serializable;

insert liczby values ( 10 );

begin transaction

-- w drugim po��czeniu robimy insert: insert liczby values(151)
-- translock

select * from liczby

-- ponownie w drugim po��czeniu robimy insert: insert liczby values(151)
-- translock

commit