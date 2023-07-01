-- Display supplies (all attributes) under contracts signed with countries as aid, where the price exceeds 500 million dollars.
--------------------------------------------------------------------------

select d.* from dodavka d
natural join smlouva s
join dodavatel using(id_dodavatel)
join zeme on (id_zeme_dodavatel = id_zeme)
where pomoc = 'true' and cena >= 500000000;

--------------------------------------------------------------------------