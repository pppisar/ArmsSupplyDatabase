-- Check the previous query (Select contracts (all attributes) under which all types of weapons have been supplied)
--------------------------------------------------------------------------

-- {All types of weapons}
-- \
-- {Types of weapons supplied by the supplier with the number 203}
-- = empty set

(select id_typ_zbran from typ_zbran)
except
(select id_typ_zbran from smlouva s
join dodavka using(id_smlouva)
join zbran using(id_zbran)
where id_dodavatel = (
    select id_dodavatel from smlouva s
    where (
        select count (distinct z.id_typ_zbran)
        from dodavka d 
        natural join zbran z
        where d.id_smlouva = s.id_smlouva
    ) = (select count(*) from typ_zbran)
));

--------------------------------------------------------------------------