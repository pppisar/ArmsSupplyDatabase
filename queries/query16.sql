-- Display military equipment (all attributes) that has not been supplied.
--------------------------------------------------------------------------

select * from vojenska_technika
    
except
    
select distinct vt.* from vojenska_technika vt
join dodavka using(id_technika);

--------------------------------------------------------------------------