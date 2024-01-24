
-- w translock uzywany jest sp_lock
drop table if exists liczby1;
create table liczby1 ( liczba int )
insert into liczby1 Values (1)

set tran isolation level serializable
begin tran
select * from liczby1 --with (NOLOCK) --z NOLOCK nie s¹ nak³adane odpowiednie blokady
Commit
