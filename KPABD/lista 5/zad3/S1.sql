-- When we use certain levels of isolation there are blockades IS, S, X, IX, U

-- 1 --
set transaction isolation level repeatable read;
begin transaction
update liczby set liczba=4
-- translock

select * from liczby

update liczby set liczba=4
-- translock

commit



-- 2 --
set transaction isolation level serializable;
insert liczby values ( 10 );
begin transaction
insert liczby values(151);
-- translock

select * from liczby

insert liczby values(151);
-- translock

commit