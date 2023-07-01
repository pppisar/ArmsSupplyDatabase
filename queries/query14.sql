-- An audit revealed that all ammunition supplies under contracts signed in 2023 were subject to improper quantity control.
-- For each such delivery, the quantity should have been increased by 25%.
--------------------------------------------------------------------------

begin;

select dodavka.* from dodavka
join strelivo using(id_strelivo)
join smlouva using(id_smlouva)
where datum_podpisu >= '2023-01-01';

update dodavka 
set mnozstvi = mnozstvi*1.25
where id_dodavka in (
    select d.id_dodavka from dodavka d
    join strelivo using(id_strelivo)
    join smlouva using(id_smlouva)
    where datum_podpisu >= '2023-01-01'
);

select dodavka.* from dodavka
join strelivo using(id_strelivo)
join smlouva using(id_smlouva)
where datum_podpisu >= '2023-01-01';

rollback;

--------------------------------------------------------------------------