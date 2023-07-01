-- Display the name of the most frequently used fuel along with the number of military equipments that use it.
--------------------------------------------------------------------------

select nazev_palivo as nejpouzivanejsi_palivo, count(*) as kolik_vhodne_techniky
from palivo
join vojenska_technika using(id_palivo)
group by nazev_palivo
order by kolik_vhodne_techniky desc
limit 1;

--------------------------------------------------------------------------