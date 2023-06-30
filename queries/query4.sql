-- Contracts (all attributes) under which both military equipment and 
-- weapons and ammunition have been supplied.
------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------