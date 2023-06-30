-- Display all deliveries made by a single country as the supplier (supplier_country_id) 
-- and manufactured by another country (production_country_id).
--------------------------------------------------------------------------

select dodavka.* from dodavka
join smlouva using(id_smlouva)
join dodavatel using(id_dodavatel)
where id_zeme_dodavatel = id_zeme_vyroby;

--------------------------------------------------------------------------