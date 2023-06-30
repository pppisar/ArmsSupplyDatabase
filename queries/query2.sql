-- Countries (their names) that have signed at least one contract.
--------------------------------------------------------------------------
select distinct z.nazev_zeme from smlouva s
join dodavatel d using (id_dodavatel)
join zeme z on id_zeme = id_zeme_dodavatel;
--------------------------------------------------------------------------