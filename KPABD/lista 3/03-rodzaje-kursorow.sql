set nocount on

-- 1. creating table L3T2_Liczby
drop table if exists L3T2_Liczby
go

create table L3T2_Liczby
(
  nr int primary key,
  liczba int
)
go

-- 2. declaring variable a = 1
declare @a int
set @a = 1

-- 3. inserting values 1-60 into L3T2_Liczby table
while ( @a <= 60)
begin
  insert L3T2_Liczby
  values ( @a, @a )
  set @a = @a + 1
end
go

-- 4. declaring variable x = 10
declare @x int
set @x = 10

-- To do 3 times (analize results: results & messages)

/*
dynamic (default) - 1, 3, 5, 7, 9 were fetched, {2, 4, 6, 8, 10} were removed from L3T2_Liczby.
They can detect ALL data changes after opening cursor, that's why function below wrote only
numbers 1, 3, 5, 7, 9 - other numbers were deleted in the meantime and cursor detected change
*/

-- declare c cursor for 
--   select liczba
--   from L3T2_Liczby
--   where liczba <= @x

/*
static - all numbers 1 - 10 were fetched, {2, 4, 6, 8, 10} were removed from L3T2_Liczby
They NEVER detect data changes after opening cursor, that's why function below wrote
all numbers 1-10 - cursor created copy of query and it operated on copy 
so no changes to original mattered
*/

-- declare c cursor static for 
--   select liczba 
--   from L3T2_Liczby 
--   where liczba <= @x

/*
keyset - only 1 was fetched, only 2 removed from L3T2_Liczby.
Can detect row removal (same like dynamic, unlike static), 
but can't find new row after removal (unlike dynamic)
*/

declare c cursor keyset for 
  select liczba 
  from L3T2_Liczby 
  where liczba <= @x

set @x = 20

open c

declare @aux int, @licznik int
set @licznik = 2

print 'Cursor''s numbers:'
fetch next from c into @aux
while ( @@fetch_status = 0 )
begin
  print @aux;
  -- print 'Liczba: '+cast(@aux as varchar)
  -- print 'Licznik: '+cast(@licznik as varchar)
  delete from L3T2_Liczby where liczba = @licznik -- usually {2, 4, 6, 8, 10}
  fetch next from c into @aux
  set @licznik = @licznik + 2
end
print 'Status of last fetch: ' + cast(@@fetch_status as varchar)
close c
deallocate c

select *
from L3T2_Liczby
where liczba <= 10