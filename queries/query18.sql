-- For each part, calculate the number of military equipment it is suitable for. The result must not contain any unused parts.
--------------------------------------------------------------------------

select nazev_dil, count(*) as kolik_vhodne_techniky
from dil
join technicka_prislusnost using(id_dil)
group by nazev_dil
having count(*) > 0
order by kolik_vhodne_techniky desc;

--------------------------------------------------------------------------