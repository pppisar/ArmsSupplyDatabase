-- For each type of ammunition, list the quantity of ammunition (from the ammunition table) that exists in the database for that type.
--------------------------------------------------------------------------
select nazev_typ, (select count(*) from strelivo s where s.id_typ_strelivo = ts.id_typ_strelivo) as pocet_streliva
from typ_strelivo ts;
--------------------------------------------------------------------------