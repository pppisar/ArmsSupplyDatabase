-- Display all countries that have supplied aviation military equipment.
--------------------------------------------------------------------------

select distinct nazev_zeme
from smlouva
natural join dodavatel
join zeme on (id_zeme_dodavatel = id_zeme)
join dodavka using(id_smlouva)
join vojenska_technika using(id_technika)
join typ_technika using(id_typ_technika)
where nazev_typ = 'Aviation';

--------------------------------------------------------------------------