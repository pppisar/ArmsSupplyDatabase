-- Display all variants of military equipment that have multiple modifications (similar name, but other attributes may differ).
--------------------------------------------------------------------------

select * from vojenska_technika vt
where exists (
    select * from vojenska_technika
    where id_technika != vt.id_technika
    and nazev like vt.nazev
);

--------------------------------------------------------------------------