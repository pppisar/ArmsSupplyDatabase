-- Remove conflicting tables
-- odeberu pokud existuje funkce na oodebrání tabulek a sekvencí
DROP FUNCTION IF EXISTS remove_all();

-- vytvořím funkci která odebere tabulky a sekvence
-- chcete také umět psát PLSQL? Zapište si předmět BI-SQL ;-)
CREATE or replace FUNCTION remove_all() RETURNS void AS $$
DECLARE
    rec RECORD;
    cmd text;
BEGIN
    cmd := '';

    FOR rec IN SELECT
            'DROP SEQUENCE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace
        WHERE
            relkind = 'S' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    FOR rec IN SELECT
            'DROP TABLE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace WHERE relkind = 'r' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    EXECUTE cmd;
    RETURN;
END;
$$ LANGUAGE plpgsql;
-- zavolám funkci co odebere tabulky a sekvence - Mohl bych dropnout celé schéma a znovu jej vytvořit, použíjeme však PLSQL
select remove_all();
-- End of removing


CREATE TABLE dil (
    id_dil SERIAL NOT NULL,
    nazev_dil VARCHAR(100) NOT NULL
);
ALTER TABLE dil ADD CONSTRAINT pk_dil PRIMARY KEY (id_dil);
ALTER TABLE dil ADD CONSTRAINT uc_dil_nazev_dil UNIQUE (nazev_dil);

CREATE TABLE dodavatel (
    id_dodavatel SERIAL NOT NULL,
    id_firma INTEGER,
    id_zeme_dodavatel INTEGER
);
ALTER TABLE dodavatel ADD CONSTRAINT pk_dodavatel PRIMARY KEY (id_dodavatel);
ALTER TABLE dodavatel ADD CONSTRAINT u_fk_dodavatel_firma UNIQUE (id_firma);
ALTER TABLE dodavatel ADD CONSTRAINT u_fk_dodavatel_zeme UNIQUE (id_zeme_dodavatel);

CREATE TABLE dodavka (
    id_dodavka SERIAL NOT NULL,
    id_smlouva INTEGER NOT NULL,
    id_strelivo INTEGER,
    id_technika INTEGER,
    id_zbran INTEGER,
    id_zeme_vyroby INTEGER NOT NULL,
    mnozstvi INTEGER NOT NULL CHECK(mnozstvi > 0), -- kontrola dat
    datum_vyroby DATE NOT NULL
);
ALTER TABLE dodavka ADD CONSTRAINT pk_dodavka PRIMARY KEY (id_dodavka);

CREATE TABLE firma (
    id_firma SERIAL NOT NULL,
    nazev_firma VARCHAR(100) NOT NULL
);
ALTER TABLE firma ADD CONSTRAINT pk_firma PRIMARY KEY (id_firma);
ALTER TABLE firma ADD CONSTRAINT uc_firma_nazev_firma UNIQUE (nazev_firma);

CREATE TABLE letecka (
    id_technika INTEGER NOT NULL,
    vyska_letu INTEGER NOT NULL CHECK(vyska_letu > 0) -- kontrola dat
);
ALTER TABLE letecka ADD CONSTRAINT pk_letecka PRIMARY KEY (id_technika);

CREATE TABLE lodni (
    id_technika INTEGER NOT NULL,
    hloubka_ponoru INTEGER NOT NULL CHECK(hloubka_ponoru >= 0) -- kontrola dat
);
ALTER TABLE lodni ADD CONSTRAINT pk_lodni PRIMARY KEY (id_technika);

CREATE TABLE palivo (
    id_palivo SERIAL NOT NULL,
    nazev_palivo VARCHAR(30) NOT NULL
);
ALTER TABLE palivo ADD CONSTRAINT pk_palivo PRIMARY KEY (id_palivo);
ALTER TABLE palivo ADD CONSTRAINT uc_palivo_nazev_palivo UNIQUE (nazev_palivo);

CREATE TABLE smlouva (
    id_smlouva SERIAL NOT NULL,
    id_dodavatel INTEGER NOT NULL,
    datum_podpisu DATE NOT NULL CHECK(datum_podpisu >= '2021-01-01'), -- konrola dat
    pomoc BOOLEAN NOT NULL,
    cena INTEGER CHECK(cena >= 0) -- kontrola dat
);
ALTER TABLE smlouva ADD CONSTRAINT pk_smlouva PRIMARY KEY (id_smlouva);

CREATE TABLE strelivo (
    id_strelivo SERIAL NOT NULL,
    id_typ_strelivo INTEGER NOT NULL,
    nazev VARCHAR(100) NOT NULL,
    hmotnost INTEGER NOT NULL CHECK(hmotnost >= 0), -- kontrola dat
    polomer_ucinku INTEGER
);
ALTER TABLE strelivo ADD CONSTRAINT pk_strelivo PRIMARY KEY (id_strelivo);

CREATE TABLE technicka_prislusnost (
    id_dil INTEGER NOT NULL,
    id_technika INTEGER NOT NULL
);
ALTER TABLE technicka_prislusnost ADD CONSTRAINT pk_technicka_prislusnost PRIMARY KEY (id_dil, id_technika);

CREATE TABLE typ_strelivo (
    id_typ_strelivo SERIAL NOT NULL,
    nazev_typ VARCHAR(30) NOT NULL
);
ALTER TABLE typ_strelivo ADD CONSTRAINT pk_typ_strelivo PRIMARY KEY (id_typ_strelivo);
ALTER TABLE typ_strelivo ADD CONSTRAINT uc_typ_strelivo_nazev_typ UNIQUE (nazev_typ);

CREATE TABLE typ_technika (
    id_typ_technika SERIAL NOT NULL,
    nazev_typ VARCHAR(30) NOT NULL
);
ALTER TABLE typ_technika ADD CONSTRAINT pk_typ_technika PRIMARY KEY (id_typ_technika);
ALTER TABLE typ_technika ADD CONSTRAINT uc_typ_technika_nazev_typ UNIQUE (nazev_typ);

CREATE TABLE typ_zbran (
    id_typ_zbran SERIAL NOT NULL,
    nazev_typ VARCHAR(30) NOT NULL
);
ALTER TABLE typ_zbran ADD CONSTRAINT pk_typ_zbran PRIMARY KEY (id_typ_zbran);
ALTER TABLE typ_zbran ADD CONSTRAINT uc_typ_zbran_nazev_typ UNIQUE (nazev_typ);

CREATE TABLE vojenska_technika (
    id_technika SERIAL NOT NULL,
    id_typ_technika INTEGER NOT NULL,
    id_palivo INTEGER,
    nazev VARCHAR(100) NOT NULL,
    hmotnost INTEGER NOT NULL CHECK(hmotnost >= 0), -- kontrola dat
    stupen_pancerovani SMALLINT CHECK(stupen_pancerovani >= 0), -- kontrola dat
    pocet_mist SMALLINT CHECK(pocet_mist >= 0) -- kontrola dat
);
ALTER TABLE vojenska_technika ADD CONSTRAINT pk_vojenska_technika PRIMARY KEY (id_technika);

CREATE TABLE zbran (
    id_zbran SERIAL NOT NULL,
    id_typ_zbran INTEGER NOT NULL,
    nazev VARCHAR(100) NOT NULL,
    hmotnost INTEGER NOT NULL CHECK(hmotnost >= 0), -- kontrola dat
    kapacita_zasobniku INTEGER CHECK(kapacita_zasobniku >= 0) -- kontrola dat
);
ALTER TABLE zbran ADD CONSTRAINT pk_zbran PRIMARY KEY (id_zbran);

CREATE TABLE zeme (
    id_zeme SERIAL NOT NULL,
    nazev_zeme VARCHAR(30) NOT NULL
);
ALTER TABLE zeme ADD CONSTRAINT pk_zeme PRIMARY KEY (id_zeme);
ALTER TABLE zeme ADD CONSTRAINT uc_zeme_nazev_zeme UNIQUE (nazev_zeme);

ALTER TABLE dodavatel ADD CONSTRAINT fk_dodavatel_firma FOREIGN KEY (id_firma) REFERENCES firma (id_firma) ON DELETE CASCADE;
ALTER TABLE dodavatel ADD CONSTRAINT fk_dodavatel_zeme FOREIGN KEY (id_zeme_dodavatel) REFERENCES zeme (id_zeme) ON DELETE CASCADE;

ALTER TABLE dodavka ADD CONSTRAINT fk_dodavka_smlouva FOREIGN KEY (id_smlouva) REFERENCES smlouva (id_smlouva) ON DELETE CASCADE;
ALTER TABLE dodavka ADD CONSTRAINT fk_dodavka_strelivo FOREIGN KEY (id_strelivo) REFERENCES strelivo (id_strelivo) ON DELETE CASCADE;
ALTER TABLE dodavka ADD CONSTRAINT fk_dodavka_vojenska_technika FOREIGN KEY (id_technika) REFERENCES vojenska_technika (id_technika) ON DELETE CASCADE;
ALTER TABLE dodavka ADD CONSTRAINT fk_dodavka_zbran FOREIGN KEY (id_zbran) REFERENCES zbran (id_zbran) ON DELETE CASCADE;
ALTER TABLE dodavka ADD CONSTRAINT fk_dodavka_zeme FOREIGN KEY (id_zeme_vyroby) REFERENCES zeme (id_zeme) ON DELETE CASCADE;

ALTER TABLE letecka ADD CONSTRAINT fk_letecka_vojenska_technika FOREIGN KEY (id_technika) REFERENCES vojenska_technika (id_technika) ON DELETE CASCADE;

ALTER TABLE lodni ADD CONSTRAINT fk_lodni_vojenska_technika FOREIGN KEY (id_technika) REFERENCES vojenska_technika (id_technika) ON DELETE CASCADE;

ALTER TABLE smlouva ADD CONSTRAINT fk_smlouva_dodavatel FOREIGN KEY (id_dodavatel) REFERENCES dodavatel (id_dodavatel) ON DELETE CASCADE;

ALTER TABLE strelivo ADD CONSTRAINT fk_strelivo_typ_strelivo FOREIGN KEY (id_typ_strelivo) REFERENCES typ_strelivo (id_typ_strelivo) ON DELETE CASCADE;

ALTER TABLE technicka_prislusnost ADD CONSTRAINT fk_technicka_prislusnost_dil FOREIGN KEY (id_dil) REFERENCES dil (id_dil) ON DELETE CASCADE;
ALTER TABLE technicka_prislusnost ADD CONSTRAINT fk_technicka_prislusnost_vojens FOREIGN KEY (id_technika) REFERENCES vojenska_technika (id_technika) ON DELETE CASCADE;

ALTER TABLE vojenska_technika ADD CONSTRAINT fk_vojenska_technika_typ_techni FOREIGN KEY (id_typ_technika) REFERENCES typ_technika (id_typ_technika) ON DELETE CASCADE;
ALTER TABLE vojenska_technika ADD CONSTRAINT fk_vojenska_technika_palivo FOREIGN KEY (id_palivo) REFERENCES palivo (id_palivo) ON DELETE CASCADE;

ALTER TABLE zbran ADD CONSTRAINT fk_zbran_typ_zbran FOREIGN KEY (id_typ_zbran) REFERENCES typ_zbran (id_typ_zbran) ON DELETE CASCADE;

ALTER TABLE dodavatel ADD CONSTRAINT xc_dodavatel_id_firma_id_zeme CHECK ((id_firma IS NOT NULL AND id_zeme_dodavatel IS NULL) OR (id_firma IS NULL AND id_zeme_dodavatel IS NOT NULL));

ALTER TABLE dodavka ADD CONSTRAINT xc_dodavka_id_strelivo_id_techn CHECK ((id_strelivo IS NOT NULL AND id_technika IS NULL AND id_zbran IS NULL) OR (id_strelivo IS NULL AND id_technika IS NOT NULL AND id_zbran IS NULL) OR (id_strelivo IS NULL AND id_technika IS NULL AND id_zbran IS NOT NULL));