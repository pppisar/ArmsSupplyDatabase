-- Create a view of military equipment that uses diesel fuel. Display diesel-powered armored military equipment.
--------------------------------------------------------------------------
create or replace view dieselovaTechnika as
select * from vojenska_technika
where id_palivo = (select id_palivo from palivo where nazev_palivo = 'Diesel')
with check option;

select * from dieselovaTechnika
join typ_technika using(id_typ_technika)
where nazev_typ = 'Armored';
--------------------------------------------------------------------------