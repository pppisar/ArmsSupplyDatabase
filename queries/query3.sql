-- Contracts (all attributes) under which ONLY ammunition has been supplied.
--------------------------------------------------------------------------

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

--------------------------------------------------------------------------