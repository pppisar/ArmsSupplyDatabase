## Disclamer
This repository contains the semester project of the subject [Database Systems](https://courses.fit.cvut.cz/BI-DBS/) studied during the second semester at the Czech Technical University in Prague.

The topic was chosen due to its relevance and the availability of a large amount of information for further analysis, which made the development process not only useful in terms of acquiring new skills, but also interesting.

# Database of arms supplies to Ukraine (Databáze dodávek zbraní Ukrajině)

## Database description (English)

Today, many countries around the world are helping Ukraine win the war. In addition to financial and humanitarian aid, dozens of countries provide Ukraine with weapons, military equipment, and ammunition.

To ensure effective monitoring, the security of neighboring countries, and reduce the risk of corruption, which is a major problem in Ukraine, it is necessary to create a convenient system for managing and controlling this information.

One of the tasks of the database is to ensure monitoring of the amount of military equipment, weapons, and ammunition already transferred for rapid replenishment if necessary. The general accounting of weapons in the database will help to increase the efficiency of conducting combat operations and ensure reliable storage of weapons.

Any supplies(**dodávky**) begin with the signing of a contract(**smlouvy**). The database stores information about the supplier(**dodavateli**), which can be a company(**firma**) or a country(**země**) with which the contract was concluded, whether it is military assistance, when it was signed, and for what amount (not a mandatory attribute).

Each contract(**smlouva**) may include the supply of several types of weapons. The database will store information about each supply made under a specific contract, including the country of manufacture, the number of units supplied, and the specific arms that will or have been transferred. It should be noted that within one supply, only one type of armament can be transferred: Military Equipment(**Vojenská technika**), Weapon(**Zbraň**), or Ammunition(**Střelivo**). Each of these entities contains specific technical information about the weapon model being transferred within the supply.

The database also includes information about parts(**dílech**) for each piece of equipment, whether they are original or interchangeable. This makes it easy and accurate to determine which parts can be used for repairs.

Information about contract prices and supply volumes will allow, after the end of the war, if desired by the countries or supplier companies, to track all supplied armaments and request their return or financial compensation.

Finally, the creation of such a database allows for increased transparency and openness in management, reducing the risk of corruption and misuse. It provides access to important information for all stakeholders, including government structures, military command centers, and research centers.

## Conceptual diagram

![](/images/conceptual_diagram.jpg)

## Relational diagram

![](/images/relational_diagram.jpg)

## Deploying and filling the database

The database was developed for PostgreSQL. 

The [Create script](create.sql) completely clears previously created tables (if any) and creates the necessary tables with corresponding attributes as specified in the relational diagram.

The [Insert script](insert.sql) fills all tables with data that will be used for further testing. Most of the data is real and not generated, which makes the testing process informative.

## Testing the database

For database testing, a total of [25 queries](queries/) were created. All queries, regarding the used constructs, can be categorized as follows:

| Category | List of queries |
| --- | --- |
| Positive query on at least two joined tables | Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q24, Q25 |
| Select only those related to | Q3 |
| Select all related to - universal quantification query | Q5 |
| Result check of D1 query | Q6 |
| JOIN ON | Q2, Q17, Q22 |
| NATURAL JOIN \| JOIN USING |Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q24, Q25 |
| CROSS JOIN | Q5 |
| LEFT \| RIGHT OUTER JOIN | Q7 |
| FULL (OUTER) JOIN | Q8 |
| Nested query in WHERE clause | Q1, Q4, Q5, Q6, Q12, Q14, Q15, Q23 |
| Nested query in FROM clause | Q5 |
| Nested query in SELECT clause | Q9 |
| Relative nested query (EXISTS \| NOT EXISTS) | Q1, Q5, Q23 |
| Set unification - UNION | Q3, Q25 |
| Set difference - MINUS or EXCEPT | Q3, Q5, Q6, Q15, Q16, Q25 |
| Set intersection - INTERSECT | Q4 |
| Aggregate functions (count \| sum \| min \| max \| avg) | Q5, Q6, Q9, Q10, Q11, Q18, Q20, Q24 |
| Aggregate function over grouped rows - GROUP BY (HAVING) | Q10, Q11, Q18, Q20, Q24 |
| Same query in 3 different sql statements | Q5 |
| All clauses in one query - SELECT FROM WHERE GROUP BY HAVING ORDER BY | Q11 |
| View | Q12 |
| Query over a view | Q12 |
| INSERT, which insert a set of rows, which are the result of another subquery | Q13 |
| UPDATE with nested SELECT statement | Q14 |
| DELETE with nested SELECT statement | Q15 |


## Popis databáze (Čeština)

Dnes mnoho zemí světa pomáhá Ukrajině vyhrát válku. Kromě finanční a humanitární pomoci desítky zemí světa poskytuje Ukrajině zbraně, vojenskou techniku a střelivo.
Pro zajištění efektivního monitorování, bezpečnosti sousedních zemí a snížení rizika korupce, s níž má Ukrajina významné problémy, je nutné vytvořit pohodlný systém pro správu a kontrolu této informace.

Jedním z cílů databáze je zajištění monitorování množství již předané vojenské techniky, zbraní a střeliva pro rychlé doplnění v případě potřeby. Celkový účet zbraní v databázi pomůže zvýšit efektivitu vedení bojových operací a zajistit spolehlivé skladování zbraní.

Jakékoliv **dodávky** začínají uzavřením **smlouvy**. Databáze uchovává informace o **dodavateli**, kterým může být nějaká **firma** nebo **země** se kterou byla smlouva uzavřena, zda se jedná o vojenskou pomoc, kdy byla uzavřena a na jakou částku (ne povinný atribut).

Každá **smlouva** může obsahovat dodání několika druhů zbraní. Databáze bude uchovávat informace o každé dodávce, která byla provedena v rámci konkrétní smlouvy, a to země výrobce, počet dodaných jednotek a jaké konkrétní zbraně budou nebo byly předány. Je třeba poznamenat, že v rámci jedné dodávky lze předat pouze jeden druh zbraní: **Vojenská technika**, **Zbraň** a **Střelivo**. Každá z těchto entit obsahuje určité technické informace o modelu zbraní, která je předáváná v rámci dodávky.

Databáze také obsahuje informace o **dílech** pro každou techniku, které jsou výchozí nebo které jsou vzájemně zaměnitelné. To umožní snadné a přesné určit, které dílý lze použít k opravě.

Informace o ceně smluv a objemu dodávek umožní po skončení války, pokud si to země nebo firma dodavatelů přejí, sledovat veškerou dodanou výzbroj a požádat o její vrácení nebo finanční kompenzaci.

Nakonec vytvoření takové databáze umožňuje zvýšit průzračnost a otevřenost řízení, což snižuje riziko korupce a neprávem používaných akcí. Zajišťuje přístup ke důležitým informacím pro všechny zainteresované strany, včetně vládních struktur, vojenských velitelství a výzkumných center.