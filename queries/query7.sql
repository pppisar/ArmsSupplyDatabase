-- Retrieve from the database all military equipment with complete characteristics. 
-- (For all items display the type of fuel used by the equipment. For naval equipment 
-- display the diving depth. For aviation equipment display the flight altitude)
--------------------------------------------------------------------------

select * from vojenska_technika vt
left join lodni using(id_technika)
left join letecka using(id_technika)
left join typ_technika using(id_typ_technika)
left join palivo using(id_palivo);

--------------------------------------------------------------------------