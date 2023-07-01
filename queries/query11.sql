-- Display how much military equipment of each type was supplied in 2022 (datum_podpisu) as aid. 
-- We are not interested in types of military equipment for which less than 200 units were supplied. 
-- Sort the result in ascending order by the type name
--------------------------------------------------------------------------

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

--------------------------------------------------------------------------