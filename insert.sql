-- smazání všech záznamů z tabulek

CREATE or replace FUNCTION clean_tables() RETURNS void AS $$
declare
  l_stmt text;
begin
  select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename) , ',')
    into l_stmt
  from pg_tables
  where schemaname in ('public');

  execute l_stmt || ' cascade';
end;
$$ LANGUAGE plpgsql;
select clean_tables();

-- reset sekvenci

CREATE or replace FUNCTION restart_sequences() RETURNS void AS $$
DECLARE
i TEXT;
BEGIN
 FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
  LOOP
         EXECUTE 'ALTER SEQUENCE'||' ' || substring(substring(i from '''[a-z_]*')from '[a-z_]+') || ' '||' RESTART 1;';
  END LOOP;
END $$ LANGUAGE plpgsql;
select restart_sequences();
-- konec resetu
-- konec mazání

-- Some types of military equipment
insert into typ_technika (nazev_typ) values ('Rocket'); -- 1
insert into typ_technika (nazev_typ) values ('Artillery'); -- 2
insert into typ_technika (nazev_typ) values ('Armored'); -- 3
insert into typ_technika (nazev_typ) values ('Auxiliary'); -- 4
insert into typ_technika (nazev_typ) values ('Communication'); -- 5
insert into typ_technika (nazev_typ) values ('Aviation'); -- 6
insert into typ_technika (nazev_typ) values ('Naval'); -- 7

-- Some types of fuel
insert into palivo (nazev_palivo) values ('Gasoline'); -- 1
insert into palivo (nazev_palivo) values ('Diesel'); -- 2
insert into palivo (nazev_palivo) values ('Kerosene '); -- 3
insert into palivo (nazev_palivo) values ('Electricity'); -- 4
insert into palivo (nazev_palivo) values ('Jet fuel'); -- 5

-- Some military equipment:
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('M1 Abrams',       54000,    6,                  4,          5,         3); -- 1
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Leopard 2',       55150,    6,                  4,          2,         3); -- 2
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Challenger 2',    75000,    7,                  4,          2,         3); -- 3
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('BMP-2',           14300,    2,                  8,          2,         3); -- 4
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('M2 Bradley',      25300,    3,                  3,          2,         3); -- 5
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Patria AMV',      32000,    4,                  15,         2,         3); -- 6
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('M142 Himars',     16250,    1,                  3,          2,         1); -- 7
insert into vojenska_technika   (nazev,             hmotnost, pocet_mist, id_typ_technika)
                        values  ('NASAMS',          1200,     2,          1); -- 8
insert into vojenska_technika   (nazev,             hmotnost, pocet_mist, id_typ_technika)
                        values  ('MIM-104 Patriot', 1400,     3,          1); -- 9
insert into vojenska_technika   (nazev,             hmotnost, pocet_mist, id_typ_technika)
                        values  ('M777',            4200,     8,          2); -- 10
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Archer',          34000,    1,                  3,          2,         2); -- 11
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Caesar',          17700,    0,                  6,          2,         2); -- 12
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Humvee',          3856,     1,                  5,          2,         4); -- 13
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('KMW AMPV',        10000,    2,                  5,          2,         4);  -- 14
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('AMZ Tur',         6200,     2,                  5,          1,         4); -- 15
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('F-16',            26500,    0,                  1,          5,         6); -- 16
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('AH-64 Apache',    17650,    1,                  2,          3,         6); -- 17
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, id_palivo, id_typ_technika)
                        values  ('Bayraktar TB2',   700,      0,                  4,         6); -- 18
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('PNS Munsif M166', 370000,   3,                  20,         2,         7); -- 19
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Visby-class corvette', 640000, 5,               32,         5,         7); -- 20
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Whiskey Long Bin',7000000,  2,                  80,         4,         7); -- 21
insert into vojenska_technika   (nazev,             hmotnost, stupen_pancerovani, pocet_mist, id_palivo, id_typ_technika)
                        values  ('Leopard 2',       63000,    7,                  5,          2,         3); -- 22

insert into letecka (id_technika, vyska_letu) values (16, 35000);
insert into letecka (id_technika, vyska_letu) values (17, 6000);
insert into letecka (id_technika, vyska_letu) values (18, 8200);
insert into lodni (id_technika, hloubka_ponoru) values (19, 0);
insert into lodni (id_technika, hloubka_ponoru) values (20, 20);
insert into lodni (id_technika, hloubka_ponoru) values (21, 500);

-- Several parts for military equipments
-- Engines
insert into dil (nazev_dil) values ('Volvo Penta D16'); -- 1
insert into dil (nazev_dil) values ('MAN D0836'); -- 2
insert into dil (nazev_dil) values ('Scania DC13'); -- 3
insert into dil (nazev_dil) values ('Mitsubishi S6R2'); -- 4
-- Transmissions
insert into dil (nazev_dil) values ('Renk HSWL 295TM'); -- 5
insert into dil (nazev_dil) values ('Fuller RTLO-20918B 18'); -- 6
insert into dil (nazev_dil) values ('Volvo I-Shift 14'); -- 7
insert into dil (nazev_dil) values ('ZF Friedrichshafen AG 8HP 8'); -- 8 -
insert into dil (nazev_dil) values ('Ford TorqShift 5R110 5'); -- 9
-- Tracks and Wheels
insert into dil (nazev_dil) values ('LMTV Wheel by Goodyear'); -- 10
insert into dil (nazev_dil) values ('Bandvagn 206'); -- 11
insert into dil (nazev_dil) values ('T-156 by Halgo Inc.'); -- 12
insert into dil (nazev_dil) values ('T-130 by UNEX'); -- 13 -
insert into dil (nazev_dil) values ('RM-70 Track'); -- 14
-- Chassis
insert into dil (nazev_dil) values ('M2 Bradley Chassis by United Defense'); -- 15
insert into dil (nazev_dil) values ('Puma Chassis by Rheinmetall'); -- 16
insert into dil (nazev_dil) values ('Leopard 2 Chassis by Krauss-Maffei Wegmann'); -- 17
-- Fuel tanks
insert into dil (nazev_dil) values ('K2 Black Panther'); -- 18
insert into dil (nazev_dil) values ('T-14 Armata'); -- 19
insert into dil (nazev_dil) values ('CV90 by BAE Systems'); -- 20
insert into dil (nazev_dil) values ('Henschel Fuel Tank by Rheinmetall'); -- 21
insert into dil (nazev_dil) values ('Patria AMV'); -- 22

-- Matching parts and military equipments
insert into technicka_prislusnost (id_technika, id_dil) values (1, 6);
insert into technicka_prislusnost (id_technika, id_dil) values (1, 14);
insert into technicka_prislusnost (id_technika, id_dil) values (2, 2);
insert into technicka_prislusnost (id_technika, id_dil) values (2, 12);
insert into technicka_prislusnost (id_technika, id_dil) values (2, 17);
insert into technicka_prislusnost (id_technika, id_dil) values (3, 1);
insert into technicka_prislusnost (id_technika, id_dil) values (3, 16);
insert into technicka_prislusnost (id_technika, id_dil) values (4, 14);
insert into technicka_prislusnost (id_technika, id_dil) values (5, 3);
insert into technicka_prislusnost (id_technika, id_dil) values (5, 15);
insert into technicka_prislusnost (id_technika, id_dil) values (5, 20);
insert into technicka_prislusnost (id_technika, id_dil) values (6, 5);
insert into technicka_prislusnost (id_technika, id_dil) values (7, 4);
insert into technicka_prislusnost (id_technika, id_dil) values (7, 7);
insert into technicka_prislusnost (id_technika, id_dil) values (10, 10);
insert into technicka_prislusnost (id_technika, id_dil) values (11, 3);
insert into technicka_prislusnost (id_technika, id_dil) values (11, 20);
insert into technicka_prislusnost (id_technika, id_dil) values (12, 16);
insert into technicka_prislusnost (id_technika, id_dil) values (12, 19);
insert into technicka_prislusnost (id_technika, id_dil) values (13, 1);
insert into technicka_prislusnost (id_technika, id_dil) values (13, 11);
insert into technicka_prislusnost (id_technika, id_dil) values (13, 18);
insert into technicka_prislusnost (id_technika, id_dil) values (14, 9);
insert into technicka_prislusnost (id_technika, id_dil) values (14, 11);
insert into technicka_prislusnost (id_technika, id_dil) values (15, 4);
insert into technicka_prislusnost (id_technika, id_dil) values (15, 18);
insert into technicka_prislusnost (id_technika, id_dil) values (16, 21);
insert into technicka_prislusnost (id_technika, id_dil) values (18, 22);
insert into technicka_prislusnost (id_technika, id_dil) values (19, 4);
insert into technicka_prislusnost (id_technika, id_dil) values (13, 4);
insert into technicka_prislusnost (id_technika, id_dil) values (22, 3);
insert into technicka_prislusnost (id_technika, id_dil) values (22, 14);
insert into technicka_prislusnost (id_technika, id_dil) values (22, 17);

-- Some types of weapons
insert into typ_zbran (nazev_typ) values ('Pistols'); -- 1
insert into typ_zbran (nazev_typ) values ('Shotgun'); -- 2
insert into typ_zbran (nazev_typ) values ('Assault rifle'); -- 3
insert into typ_zbran (nazev_typ) values ('Sniper rifle'); -- 4
insert into typ_zbran (nazev_typ) values ('Submachine gun'); -- 5
insert into typ_zbran (nazev_typ) values ('Machine gun'); -- 6
insert into typ_zbran (nazev_typ) values ('Grenade launcher'); -- 7
insert into typ_zbran (nazev_typ) values ('Melee weapons'); -- 8

-- Some weapons
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Glock 17',        1,        17,                 1); -- 1
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('SIG Sauer P226',  1,        15,                 1); -- 2
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Beretta M9',      1,        15,                 1); -- 3
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Browning Hi-Power', 1,      13,                 1); -- 4
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Mossberg 500',    3,        8,                  2); -- 5
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Remington 870',   3,        7,                 2); -- 6
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Heckler & Koch G36', 4,     30,                 3); -- 7
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Colt M4',         3,        30,                 3); -- 8
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('FN SCAR',         4,        30,                 3); -- 9
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('AK-47',           5,        30,                 3); -- 10
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Steyr AUG',       4,        30,                 3); -- 11
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Accuracy International Arctic Warfare', 7, 10,  4); -- 12
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Steyr SSG 69',    4,        5,                  4);  -- 13
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Heckler & Koch PSG1', 8,    20,                 4); -- 14
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Heckler & Koch MP5', 3,     100,                5); -- 15
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('Uzi',             4,        25,                 5); -- 16
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('FN P90',          3,        50,                 5); -- 17
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('M249 SAW',        10,       200,                6); -- 18
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('M240B',           13,       200,                6); -- 19
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('FN MAG',          12,       200,                6); -- 20
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('M136 AT4',        1,        1,                  7); -- 21
insert into zbran   (nazev,             hmotnost, kapacita_zasobniku, id_typ_zbran)
            values  ('M203',            1,        1,                  7); -- 22
insert into zbran   (nazev,             hmotnost, id_typ_zbran)
            values  ('M18A1 Claymore',  2,        8); -- 23
insert into zbran   (nazev,             hmotnost, id_typ_zbran)
            values  ('KA-BAR',          1,        8); -- 24
insert into zbran   (nazev,             hmotnost, id_typ_zbran)
            values  ('Gerber Mark II',  1,        8); -- 25

-- Some types of ammunition
insert into typ_strelivo (nazev_typ) values ('Aerial bomb'); -- 1
insert into typ_strelivo (nazev_typ) values ('Artillery shell'); -- 2
insert into typ_strelivo (nazev_typ) values ('Rocket'); -- 3
insert into typ_strelivo (nazev_typ) values ('Torpedo'); -- 4
insert into typ_strelivo (nazev_typ) values ('Grenade'); -- 5
insert into typ_strelivo (nazev_typ) values ('Mine');  -- 6
insert into typ_strelivo (nazev_typ) values ('Handgun ammunition'); -- 7

-- Some ammunition
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('5.56x45mm',       0,        7); -- 1
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('7.62x51mm',       0,        7); -- 2
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('9x19mm',          0,        7); -- 3
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('.50 BMG',         0,        7); -- 4
insert into strelivo    (nazev,             hmotnost, polomer_ucinku, id_typ_strelivo)
            values      ('M67',             0,        5,              5); -- 5
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('AN-M14 TH3',      1,        5); -- 6
insert into strelivo    (nazev,             hmotnost, polomer_ucinku, id_typ_strelivo)
            values      ('B61 Nuclear Bomb',320,      300,            1); -- 7
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('GBU-12 Paveway II', 227,    1); -- 8
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('AIM-9 Sidewinder',87,    3); -- 9
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('AGM-65 Maverick', 290,      3); -- 10
insert into strelivo    (nazev,             hmotnost, polomer_ucinku, id_typ_strelivo)
            values      ('M72 LAW',         3,        15,             3); -- 11
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('FGM-148 Javelin', 22,       3); -- 12
insert into strelivo    (nazev,             hmotnost, polomer_ucinku, id_typ_strelivo)
            values      ('M18A1 Claymore',  2,        50,             6); -- 13
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('M2 Browning .50', 0,        7); -- 14
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('M61 Vulcan 20mm', 0,        7); -- 15
insert into strelivo    (nazev,             hmotnost, polomer_ucinku, id_typ_strelivo)
            values      ('M982 Excalibur',  48,       150,             2); -- 16
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('XM395 Precision', 15,       2); -- 17
insert into strelivo    (nazev,             hmotnost, polomer_ucinku, id_typ_strelivo)
            values      ('M712 Copperhead', 44,       300,             2); -- 18
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('Mk 48',           1275,     4); -- 19
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('AGM-88 HARM',     360,      3); -- 20
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('40mm Bofors',     1,        2); -- 21
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('M134',            1,        7); -- 22
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('BGM-71 TOW',      19,       3); -- 23
insert into strelivo    (nazev,             hmotnost, id_typ_strelivo)
            values      ('FIM-92 Stinger',  15,       3); -- 24

-- Some companies
insert into firma (nazev_firma) values ('BAE Systems'); -- 1
insert into firma (nazev_firma) values ('Airbus Defence and Space'); -- 2
insert into firma (nazev_firma) values ('Leonardo'); -- 3
insert into firma (nazev_firma) values ('Thales Group'); -- 4
insert into firma (nazev_firma) values ('Saab AB'); -- 5
insert into firma (nazev_firma) values ('Krauss-Maffei Wegmann'); -- 6
insert into firma (nazev_firma) values ('Nexter'); -- 7
insert into firma (nazev_firma) values ('Rheinmetall'); -- 8
insert into firma (nazev_firma) values ('MBDA'); -- 9
insert into firma (nazev_firma) values ('Denel'); -- 10
insert into firma (nazev_firma) values ('Lockheed Martin'); -- 11
insert into firma (nazev_firma) values ('Boeing'); -- 12
insert into firma (nazev_firma) values ('Raytheon Technologies'); -- 13
insert into firma (nazev_firma) values ('General Dynamics'); -- 14
insert into firma (nazev_firma) values ('Northrop Grumman'); -- 15
insert into firma (nazev_firma) values ('L3Harris Technologies'); -- 16
insert into firma (nazev_firma) values ('Textron'); -- 17
insert into firma (nazev_firma) values ('Oshkosh Defense'); -- 18
insert into firma (nazev_firma) values ('Colt Defense'); -- 19
insert into firma (nazev_firma) values ('Barrett Firearms'); -- 20
insert into firma (nazev_firma) values ('Remington Outdoor Company'); -- 21
insert into firma (nazev_firma) values ('Sturm, Ruger & Co.'); -- 22
insert into firma (nazev_firma) values ('Smith & Wesson'); -- 23
insert into firma (nazev_firma) values ('Winchester Repeating Arms'); -- 24
insert into firma (nazev_firma) values ('Sig Sauer'); -- 25

-- Some countries
insert into zeme (nazev_zeme) values ('Albania'); -- 1
insert into zeme (nazev_zeme) values ('Austria'); -- 2
insert into zeme (nazev_zeme) values ('Belgium'); -- 3
insert into zeme (nazev_zeme) values ('Bulgaria'); -- 4
insert into zeme (nazev_zeme) values ('Canada'); -- 5
insert into zeme (nazev_zeme) values ('Czech Republic'); -- 6
insert into zeme (nazev_zeme) values ('Denmark'); -- 7
insert into zeme (nazev_zeme) values ('Estonia'); -- 8
insert into zeme (nazev_zeme) values ('Finland'); -- 9
insert into zeme (nazev_zeme) values ('France'); -- 10
insert into zeme (nazev_zeme) values ('Georgia'); -- 11
insert into zeme (nazev_zeme) values ('Germany'); -- 12
insert into zeme (nazev_zeme) values ('Greece'); -- 13
insert into zeme (nazev_zeme) values ('Iceland'); -- 14
insert into zeme (nazev_zeme) values ('Ireland'); -- 15
insert into zeme (nazev_zeme) values ('Italy'); -- 16
insert into zeme (nazev_zeme) values ('Latvia'); -- 17
insert into zeme (nazev_zeme) values ('Lithuania'); -- 18
insert into zeme (nazev_zeme) values ('Netherlands'); -- 19
insert into zeme (nazev_zeme) values ('Norway'); -- 20
insert into zeme (nazev_zeme) values ('Poland'); -- 21
insert into zeme (nazev_zeme) values ('Portugal'); -- 22
insert into zeme (nazev_zeme) values ('Romania'); -- 23
insert into zeme (nazev_zeme) values ('Slovakia'); -- 24
insert into zeme (nazev_zeme) values ('Slovenia'); -- 25
insert into zeme (nazev_zeme) values ('Spain'); -- 26
insert into zeme (nazev_zeme) values ('Sweden'); -- 27
insert into zeme (nazev_zeme) values ('Turkey'); -- 28
insert into zeme (nazev_zeme) values ('United Kingdom'); -- 29
insert into zeme (nazev_zeme) values ('United States'); -- 30

-- zeme_dodavatele(1-195)
insert into dodavatel (id_zeme_dodavatel) values (1); -- 1
insert into dodavatel (id_zeme_dodavatel) values (2); -- 2
insert into dodavatel (id_zeme_dodavatel) values (3); -- 3
insert into dodavatel (id_zeme_dodavatel) values (4); -- 4
insert into dodavatel (id_zeme_dodavatel) values (5); -- 5
insert into dodavatel (id_zeme_dodavatel) values (6); -- 6
insert into dodavatel (id_zeme_dodavatel) values (7); -- 7
insert into dodavatel (id_zeme_dodavatel) values (8); -- 8
insert into dodavatel (id_zeme_dodavatel) values (9); -- 9
insert into dodavatel (id_zeme_dodavatel) values (10); -- 10
insert into dodavatel (id_zeme_dodavatel) values (11); -- 11
insert into dodavatel (id_zeme_dodavatel) values (12); -- 12
insert into dodavatel (id_zeme_dodavatel) values (13); -- 13
insert into dodavatel (id_zeme_dodavatel) values (14); -- 14
insert into dodavatel (id_zeme_dodavatel) values (15); -- 15
insert into dodavatel (id_zeme_dodavatel) values (16); -- 16
insert into dodavatel (id_zeme_dodavatel) values (17); -- 17
insert into dodavatel (id_zeme_dodavatel) values (18); -- 18
insert into dodavatel (id_zeme_dodavatel) values (19); -- 19
insert into dodavatel (id_zeme_dodavatel) values (20); -- 20
insert into dodavatel (id_zeme_dodavatel) values (21); -- 21
insert into dodavatel (id_zeme_dodavatel) values (22); -- 22
insert into dodavatel (id_zeme_dodavatel) values (23); -- 23
insert into dodavatel (id_zeme_dodavatel) values (24); -- 24
insert into dodavatel (id_zeme_dodavatel) values (25); -- 25
insert into dodavatel (id_zeme_dodavatel) values (26); -- 26
insert into dodavatel (id_zeme_dodavatel) values (27); -- 27
insert into dodavatel (id_zeme_dodavatel) values (28); -- 28
insert into dodavatel (id_zeme_dodavatel) values (29); -- 29
insert into dodavatel (id_zeme_dodavatel) values (30); -- 30
-- For companies id_dodavatel > 200
select setval(pg_get_serial_sequence('dodavatel','id_dodavatel'),200);
insert into dodavatel (id_firma) values (1); -- 201
insert into dodavatel (id_firma) values (2); -- 202
insert into dodavatel (id_firma) values (3); -- 203
insert into dodavatel (id_firma) values (4); -- 204
insert into dodavatel (id_firma) values (5); -- 205
insert into dodavatel (id_firma) values (6); -- 206
insert into dodavatel (id_firma) values (7); -- 207
insert into dodavatel (id_firma) values (8); -- 208
insert into dodavatel (id_firma) values (9); -- 209
insert into dodavatel (id_firma) values (10); -- 210
insert into dodavatel (id_firma) values (11); -- 211
insert into dodavatel (id_firma) values (12); -- 212
insert into dodavatel (id_firma) values (13); -- 213
insert into dodavatel (id_firma) values (14); -- 214
insert into dodavatel (id_firma) values (15); -- 215
insert into dodavatel (id_firma) values (16); -- 216
insert into dodavatel (id_firma) values (17); -- 217
insert into dodavatel (id_firma) values (18); -- 218
insert into dodavatel (id_firma) values (19); -- 219
insert into dodavatel (id_firma) values (20); -- 220
insert into dodavatel (id_firma) values (21); -- 221
insert into dodavatel (id_firma) values (22); -- 222
insert into dodavatel (id_firma) values (23); -- 223
insert into dodavatel (id_firma) values (24); -- 224
insert into dodavatel (id_firma) values (25); -- 225

-- Some contracts
-- Countries
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (1, '2023-03-27', true, 164795029); -- 1
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (11, '2023-01-21', false, 707313395); -- 2
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (11, '2022-04-06', false, 23476461); -- 3
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (5, '2023-03-21', false, 751228832); -- 4
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (24, '2022-12-20', true, 759932110); -- 5
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (22, '2022-09-03', false, 9941355); -- 6
insert into smlouva (id_dodavatel, datum_podpisu, pomoc) values (15, '3/4/2022', true); -- 7
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (12, '2022-10-10', false, 759067173); -- 8
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (4, '2022-11-2', false, 841993772); -- 9
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (18, '2022-07-12', false, 555012694); -- 10
insert into smlouva (id_dodavatel, datum_podpisu, pomoc) values (25, '2022-06-15', true); -- 11
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (3, '2022-06-10', true, 670690399); -- 12
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (6, '2023-01-03', false, 402329427); -- 13
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (8, '2022-10-02', true, 242608165); -- 14
insert into smlouva (id_dodavatel, datum_podpisu, pomoc) values (10, '2022-12-22', true); -- 15
insert into smlouva (id_dodavatel, datum_podpisu, pomoc) values (20, '2022-02-20', true); -- 16
insert into smlouva (id_dodavatel, datum_podpisu, pomoc) values (2, '2022-05-18', true); -- 17
-- Companies
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (219, '2022-02-23', false, 903509725); -- 18
insert into smlouva (id_dodavatel, datum_podpisu, pomoc) values (222, '2023-04-29', true); -- 19
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (203, '2022-08-10', true, 121017924); -- 20
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (216, '2023-04-26', true, 838972759); -- 21
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (210, '2022-07-14', false, 424833743); -- 22
insert into smlouva (id_dodavatel, datum_podpisu, pomoc, cena) values (218, '2022-05-19', true, 788938200); -- 23

-- Some shipments
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (1, 20, 3200, '2006-01-18', 22);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (1, 19, 126, '2011-11-12', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (2, 5, 440, '2018-06-09', 18);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (2, 1, 65, '2017-08-28', 1);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (2, 16, 1300, '2022-03-23', 5);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (3, 3, 89, '2005-04-12', 5);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (4, 30, 3600, '2012-09-13', 4);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (4, 8, 1200, '2006-08-24', 8);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (5, 27, 122, '2008-11-09', 16);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (5, 18, 115, '2017-03-18', 2);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (5, 18, 154, '2008-01-08', 14);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (5, 15, 1100, '2013-11-22', 11);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (6, 10, 5700, '2021-09-12', 4);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (7, 3, 183, '2021-06-20', 11);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (7, 22, 55, '2021-12-05', 21);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (8, 25, 7000, '2003-08-26', 1);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (9, 20, 50, '2021-10-21', 2);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (9, 19, 1200, '2019-10-16', 20);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (9, 8, 150, '2016-08-11', 18);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 21, 5000, '2015-03-24', 17);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 29, 5670, '2009-11-20', 8);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 21, 8200, '2016-07-23', 10);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 27, 6600, '2020-01-31', 19);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 4, 3300, '2016-09-26', 6);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 4, 3100, '2011-10-11', 13);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (10, 10, 6300, '2018-02-21', 20);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (11, 26, 1400, '2004-10-28', 16);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (11, 29, 70, '2020-12-13', 3);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (11, 21, 1800, '2012-05-01', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (11, 23, 8000, '2020-07-09', 14);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (12, 11, 70, '2019-09-23', 10);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (12, 20, 1200, '2023-05-01', 22);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (13, 27, 100, '2003-11-24', 4);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (13, 13, 1900, '2006-08-09', 11);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (13, 6, 9000, '2008-05-14', 16);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (13, 18, 1600, '2015-10-24', 16);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (14, 2, 120, '2014-12-14', 17);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (14, 26, 5000, '2009-10-12', 16);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (15, 11, 1200, '2021-07-20', 5);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (15, 6, 150, '2020-12-10', 2);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (15, 20, 6000, '2017-05-16', 15);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (16, 20, 1500, '2021-12-07', 7);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (16, 1, 100, '2022-02-04', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (17, 5, 8000, '2021-11-01', 23);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (17, 2, 1200, '2017-07-09', 24);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (17, 22, 120, '2021-10-03', 5);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (17, 29, 25, '2018-08-01', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (18, 27, 1000, '2004-02-24', 22);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (18, 14, 50, '2014-12-24', 8);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (18, 30, 150, '2021-09-30', 2);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (18, 19, 25, '2013-09-14', 17);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (18, 6, 100, '2002-07-20', 13);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (18, 13, 5000, '2021-11-20', 3);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (19, 23, 1500, '2006-07-24', 8);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (19, 9, 1000, '2013-02-23', 22);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (19, 25, 8000, '2009-09-17', 11);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 12, 1500, '2015-04-29', 25);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 7, 400, '2012-12-15', 3);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 4, 100, '2008-03-06', 6);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 14, 200, '2012-11-17', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 4, 80, '2008-11-02', 13);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 22, 300, '2018-05-04', 16);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 13, 40, '2009-09-14', 18);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 12, 30, '2017-04-01', 22);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (20, 11, 50, '2005-12-25', 11);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (20, 20, 200, '2021-08-03', 12);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (20, 8, 75, '2021-12-22', 4);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (20, 13, 1200, '2022-04-08', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (21, 16, 150, '2002-09-11', 9);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (21, 11, 7000, '2007-12-11', 17);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (21, 30, 2000, '2003-09-20', 17);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_strelivo) values (22, 4, 2000, '2013-09-23', 3);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_zbran) values (22, 19, 1700, '2016-03-15', 5);
insert into dodavka (id_smlouva, id_zeme_vyroby, mnozstvi, datum_vyroby, id_technika) values (23, 29, 25, '2018-07-19', 8);