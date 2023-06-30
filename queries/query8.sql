-- Display all information about military equipment and available parts suitable for that equipment. 
-- The query result should also show any unnecessary parts (unsuitable for any military equipment) 
-- and equipment for which no parts are available.
--------------------------------------------------------------------------
select * from vojenska_technika
full join technicka_prislusnost using(id_technika)
full join dil using(id_dil)
order by id_technika asc;
--------------------------------------------------------------------------