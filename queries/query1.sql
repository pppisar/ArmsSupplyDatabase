-- Display military equipment (all attributes) for which no parts exist.
--------------------------------------------------------------------------

select distinct vt.* from vojenska_technika vt 
where not exists (
    select * from technicka_prislusnost tp where vt.id_technika=tp.id_technika
);

--------------------------------------------------------------------------