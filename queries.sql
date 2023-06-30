-- 1 -------------------------------
-- Display military equipment (all attributes) for which no parts exist.
select distinct vt.* from vojenska_technika vt 
where not exists (
    select * from technicka_prislusnost tp where vt.id_technika=tp.id_technika
);
-------------------------------------

-- 2 -------------------------------
-- Countries (their names) that have signed at least one contract.
select distinct z.nazev_zeme from smlouva s
join dodavatel d using (id_dodavatel)
join zeme z on id_zeme = id_zeme_dodavatel;
-------------------------------------

-- 3 -------------------------------
-- Contracts (all attributes) under which ONLY ammunition has been supplied.
(select smlouva.* from smlouva 
join dodavka using(id_smlouva)
join strelivo using(id_strelivo))
except
(
    (select smlouva.* from smlouva 
        join dodavka using(id_smlouva)
        join zbran using(id_zbran))
    union
    (select smlouva.* from smlouva 
        join dodavka using(id_smlouva)
        join vojenska_technika using(id_technika))
);
-------------------------------------

-- 4 -------------------------------
-- Contracts (all attributes) under which both military equipment and weapons and ammunition have been supplied.
select distinct smlouva.* from smlouva 
    join dodavka using(id_smlouva)
    join vojenska_technika using(id_technika)
    where id_smlouva in (
        (select smlouva.id_smlouva from smlouva
            join dodavka using(id_smlouva)
            join zbran using(id_zbran))
        intersect
        (select smlouva.id_smlouva from smlouva
            join dodavka using(id_smlouva)
            join strelivo using(id_strelivo))
);
-------------------------------------

-- 5 -------------------------------
-- Contracts (all attributes) under which all types of weapons have been supplied.
-- set method
-- {Contracts containing weapons} 
-- / 
-- {Contracts that did not containt all types of weapons}
select distinct smlouva.* from smlouva
natural join dodavka
natural join zbran
where id_smlouva not in (
    select distinct id_smlouva from (
        select distinct * from (
            (select distinct id_smlouva from dodavka
            natural join zbran) as smlouvyObsahujiciZbran
            cross join
            (select id_typ_zbran from typ_zbran) as VseTypy
        ) as VseMozneKombinace
        except
        (select distinct id_smlouva, id_typ_zbran from dodavka
        natural join zbran) -- smlouvyObsahujiciZbran
    ) as coNedodalyVse
);
    
-- double negation method
-- If there is at least one type of weapon that has not been supplied, 1 will be returned.
-- If all weapon types have been supplied, then the internal query for the first not exists will be valid.
select * from smlouva s
where not exists(
    select 1 from typ_zbran tz
    where not exists (
        select 1 from dodavka d
        natural join zbran z
        where s.id_smlouva = d.id_smlouva
        and z.id_typ_zbran = tz.id_typ_zbran
    )
);

-- count method
-- The number of weapon types supplied under the contract should be the same as the total number of weapon types.
select * from smlouva s
where (
    select count (distinct z.id_typ_zbran)
    from dodavka d natural join zbran z
    where d.id_smlouva = s.id_smlouva
) = (select count(*) from typ_zbran);
-------------------------------------

-- 6 -------------------------------
-- Check the previous query (Select contracts (all attributes) under which all types of weapons have been supplied)
-- {All types of weapons}
-- \
-- {Types of weapons supplied by the supplier with the number 203}
-- = empty set
(select id_typ_zbran from typ_zbran)
except
(select id_typ_zbran from smlouva s
join dodavka using(id_smlouva)
join zbran using(id_zbran)
where id_dodavatel = (
    select id_dodavatel from smlouva s
    where (
        select count (distinct z.id_typ_zbran)
        from dodavka d 
        natural join zbran z
        where d.id_smlouva = s.id_smlouva
    ) = (select count(*) from typ_zbran)
));
-------------------------------------

-- 7 -------------------------------
-- Retrieve from the database all military equipment with complete characteristics. 
-- (For all items, include the type of fuel used by the equipment. For naval equipment, 
-- display the diving depth, and for aviation equipment, display the flight altitude)
select * from vojenska_technika vt
left join lodni using(id_technika)
left join letecka using(id_technika)
left join typ_technika using(id_typ_technika)
left join palivo using(id_palivo);
-------------------------------------

-- 8 -------------------------------
-- Display all information about military equipment and available parts suitable for that equipment. 
-- The query result should also show any unnecessary parts (unsuitable for any military equipment) 
-- and equipment for which no parts are available.
select * from vojenska_technika
full join technicka_prislusnost using(id_technika)
full join dil using(id_dil)
order by id_technika asc;
-------------------------------------

-- 9 -------------------------------
-- For each type of ammunition, list the quantity of ammunition (from the ammunition table) that exists in the database for that type.
select nazev_typ, (select count(*) from strelivo s where s.id_typ_strelivo = ts.id_typ_strelivo) as pocet_streliva
from typ_strelivo ts;
-------------------------------------

-- 10 -------------------------------
-- Calculate the quantity delivered for each weapon type across all completed deliveries. 
-- The result should be sorted in descending order based on the total quantity.
select nazev_typ, sum(mnozstvi) as celkem_zbrani_tohoto_typu
from dodavka
join zbran using(id_zbran)
join typ_zbran using(id_typ_zbran)
group by nazev_typ
order by celkem_zbrani_tohoto_typu desc;
-------------------------------------

-- 11 -------------------------------
-- List how much military equipment of each type was delivered in 2022 (date_signed) as aid. 
-- We are not interested in types of military equipment for which less than 200 units were delivered. 
-- Sort the result in ascending order by the type name.
select nazev_typ, sum(mnozstvi) as celkem_techniky_tohoto_typu
from smlouva
join dodavka using(id_smlouva)
join vojenska_technika using(id_technika)
join typ_technika using(id_typ_technika)
where extract(year from datum_podpisu) = 2022
and pomoc = 'true'
group by nazev_typ
having sum(mnozstvi) >= 200
order by nazev_typ asc;
-------------------------------------

-- 12 -------------------------------
-- Create a view of military equipment that uses diesel fuel. Display diesel-powered armored military equipment.
create or replace view dieselovaTechnika as
select * from vojenska_technika
where id_palivo = (select id_palivo from palivo where nazev_palivo = 'Diesel')
with check option;

select * from dieselovaTechnika
join typ_technika using(id_typ_technika)
where nazev_typ = 'Armored';
-------------------------------------

-- 13 -------------------------------
-- Find the latest signed contract that was signed as aid and under which a weapon was delivered, and repeat this weapon delivery. 
-- If there were multiple weapon deliveries under this contract, repeat the delivery with the newest weapon (highest production date). 
-- In duplication, the production date must be current.
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
-------------------------------------

-- 14 -------------------------------
-- An audit revealed that all ammunition deliveries under contracts signed in 2023 were subject to incorrect quantity control. 
-- For each such delivery, the quantity should have been increased by 25%.
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
-------------------------------------

-- 15 -------------------------------
-- Unsupplied ammunition needs to be removed.
begin;

select * from strelivo;

delete from strelivo 
where id_strelivo in (
    select id_strelivo from strelivo
    
    except
    
    select s.id_strelivo from dodavka
    join strelivo s using(id_strelivo)
);

select * from strelivo;

rollback;
-------------------------------------

-- 16 -------------------------------
-- Display military equipment (all attributes) that has not been delivered.
select * from vojenska_technika
    
except
    
select distinct vt.* from vojenska_technika vt
join dodavka using(id_technika);
-------------------------------------

-- 17 -------------------------------
-- Display deliveries (all attributes) under contracts signed with countries as aid, where the price exceeds 500 million dollars.
select d.* from dodavka d
natural join smlouva s
join dodavatel using(id_dodavatel)
join zeme on (id_zeme_dodavatel = id_zeme)
where pomoc = 'true' and cena >= 500000000;
-------------------------------------

-- 18 -------------------------------
-- For each part, calculate the number of military equipment it is suitable for. The result must not contain any unused parts.
select nazev_dil, count(*) as kolik_vhodne_techniky
from dil
join technicka_prislusnost using(id_dil)
group by nazev_dil
having count(*) > 0
order by kolik_vhodne_techniky desc;
-------------------------------------

-- 19 -------------------------------
-- Display deliveries that cannot be made immediately (production date is greater than the signing date).
select dodavka.* from dodavka
join smlouva using(id_smlouva)
where datum_vyroby > datum_podpisu;
-------------------------------------

-- 20 -------------------------------
-- Display the name of the most frequently used fuel along with the number of military equipment units that use it.
select nazev_palivo as nejpouzivanejsi_palivo, count(*) as kolik_vhodne_techniky
from palivo
join vojenska_technika using(id_palivo)
group by nazev_palivo
order by kolik_vhodne_techniky desc
limit 1;
-------------------------------------

-- 21 -------------------------------
-- Display all deliveries made by a single country as the supplier (supplier_country_id) 
-- and manufactured by another country (production_country_id).
select dodavka.* from dodavka
join smlouva using(id_smlouva)
join dodavatel using(id_dodavatel)
where id_zeme_dodavatel = id_zeme_vyroby;
-------------------------------------

-- 22 -------------------------------
-- Display all countries that have supplied aviation military equipment.
select distinct nazev_zeme
from smlouva
natural join dodavatel
join zeme on (id_zeme_dodavatel = id_zeme)
join dodavka using(id_smlouva)
join vojenska_technika using(id_technika)
join typ_technika using(id_typ_technika)
where nazev_typ = 'Aviation';
-------------------------------------

-- 23 -------------------------------
-- Display all variants of military equipment that have multiple modifications (similar name, but other attributes may differ).
select * from vojenska_technika vt
where exists (
    select * from vojenska_technika
    where id_technika != vt.id_technika
    and nazev like vt.nazev
);
-------------------------------------

-- 24 -------------------------------
-- Determine the number of deliveries made by each company. 
-- The resulting table should not include the names of companies that have not made any deliveries.
select nazev_firma, count(*) as kolik_bylo_dodano
from dodavka
join smlouva using(id_smlouva)
join dodavatel using(id_dodavatel)
join firma using(id_firma)
group by nazev_firma
having count(*) > 0
order by kolik_bylo_dodano desc;
-------------------------------------

-- 25 -------------------------------
-- Contracts under which only ammunition and weapons were delivered.
((select smlouva.* from smlouva 
join dodavka using(id_smlouva)
join strelivo using(id_strelivo))
union
(select smlouva.* from smlouva 
join dodavka using(id_smlouva)
join zbran using(id_zbran)))
except
(select smlouva.* from smlouva 
join dodavka using(id_smlouva)
join vojenska_technika using(id_technika));
-------------------------------------