-- Find the latest signed contract that was signed as aid and under which a weapon was supplied, and repeat this weapon supply. 
-- If there were multiple weapon supplies under this contract, repeat the supply with the newest weapon (highest production date). 
-- When duplicating, the date of manufacture must be current.
--------------------------------------------------------------------------

begin;

select * from dodavka order by id_dodavka desc;

insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran)
select d.id_smlouva, d.id_zeme_vyroby, d.mnozstvi, cast(now() as date) as datum_vyroby, d.id_zbran
from dodavka d
join zbran z using(id_zbran)
join smlouva s using(id_smlouva)
where s.pomoc = 'true'
order by s.datum_podpisu desc, d.datum_vyroby desc
limit 1;

select * from dodavka order by id_dodavka desc;

rollback;

--------------------------------------------------------------------------