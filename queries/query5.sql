-- Contracts (all attributes) under which all types of weapons have been supplied.
--------------------------------------------------------------------------

-- set method
-- {Contracts containing weapons} 
-- / 
-- {Contracts that did not containt all types of weapons}
select distinct smlouva.* from smlouva
natural join dodavka
natural join zbran
where id_smlouva not in (
    select distinct id_smlouva from (
        select distinct * from (
            (select distinct id_smlouva from dodavka
            natural join zbran) as smlouvyObsahujiciZbran
            cross join
            (select id_typ_zbran from typ_zbran) as VseTypy
        ) as VseMozneKombinace
        except
        (select distinct id_smlouva, id_typ_zbran from dodavka
        natural join zbran) -- smlouvyObsahujiciZbran
    ) as coNedodalyVse
);
    
-- double negation method
-- If there is at least one type of weapon that has not been supplied, 1 will be returned.
-- If all weapon types have been supplied, then the internal query for the first not exists will be valid.
select * from smlouva s
where not exists(
    select 1 from typ_zbran tz
    where not exists (
        select 1 from dodavka d
        natural join zbran z
        where s.id_smlouva = d.id_smlouva
        and z.id_typ_zbran = tz.id_typ_zbran
    )
);

-- count method
-- The number of weapon types supplied under the contract should be the same as the total number of weapon types.
select * from smlouva s
where (
    select count (distinct z.id_typ_zbran)
    from dodavka d natural join zbran z
    where d.id_smlouva = s.id_smlouva
) = (select count(*) from typ_zbran);
--------------------------------------------------------------------------