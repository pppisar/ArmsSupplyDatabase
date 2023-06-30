-- Find the latest signed contract that was signed as aid and under which a weapon was delivered, and repeat this weapon delivery. 
-- If there were multiple weapon deliveries under this contract, repeat the delivery with the newest weapon (highest production date). 
-- In duplication, the production date must be current.
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