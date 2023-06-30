-- Contracts under which only ammunition and weapons were delivered.
--------------------------------------------------------------------------

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

--------------------------------------------------------------------------