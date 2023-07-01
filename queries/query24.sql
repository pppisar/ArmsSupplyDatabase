-- How many supplies each company has made. 
-- The resulting table should not include the names of companies that have not made any supplies.
--------------------------------------------------------------------------

select nazev_firma, count(*) as kolik_bylo_dodano
from dodavka
join smlouva using(id_smlouva)
join dodavatel using(id_dodavatel)
join firma using(id_firma)
group by nazev_firma
having count(*) > 0
order by kolik_bylo_dodano desc;

--------------------------------------------------------------------------