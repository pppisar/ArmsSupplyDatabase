-- Display deliveries that cannot be made immediately (production date is greater than the signing date).
-------------------------------------

select dodavka.* from dodavka
join smlouva using(id_smlouva)
where datum_vyroby > datum_podpisu;

--------------------------------------------------------------------------