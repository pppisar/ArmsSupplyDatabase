-- Calculate the quantity delivered for each weapon type across all completed deliveries. 
-- The result should be sorted in descending order based on the total quantity.
--------------------------------------------------------------------------
select nazev_typ, sum(mnozstvi) as celkem_zbrani_tohoto_typu
from dodavka
join zbran using(id_zbran)
join typ_zbran using(id_typ_zbran)
group by nazev_typ
order by celkem_zbrani_tohoto_typu desc;
--------------------------------------------------------------------------