-- Unsupplied ammunition needs to be removed.
--------------------------------------------------------------------------

begin;

select * from strelivo;

delete from strelivo 
where id_strelivo in (
    select id_strelivo from strelivo
    
    except
    
    select s.id_strelivo from dodavka
    join strelivo s using(id_strelivo)
);

select * from strelivo;

rollback;

--------------------------------------------------------------------------