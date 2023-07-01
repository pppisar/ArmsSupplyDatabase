-- Display all supplies that have been supplied (id_zeme_dodavatel) 
-- and manufactured (id_zeme_vyroby) by one country.
--------------------------------------------------------------------------

select dodavka.* from dodavka
join smlouva using(id_smlouva)
join dodavatel using(id_dodavatel)
where id_zeme_dodavatel = id_zeme_vyroby;

--------------------------------------------------------------------------