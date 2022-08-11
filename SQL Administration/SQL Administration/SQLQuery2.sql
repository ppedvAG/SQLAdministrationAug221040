--Tuing

/*

Indizes

gehört..
müssen gewartet werden rebuild mit reorg

--Suchen schneller ..langsamer
--Indizes  Sperrverhalten

--weniger IO , weniger RAM, weniger CPU

--tab kann bis zu 1000 IX

--Strategie --> repr.Querschnitt

-- --Indexarten: CL IX  NON CL IX COl IX   8 Subvarianten

ALTER tab t1 add spx



---Salamitaktik


--Tab A   10000
--Tab B    100000

Abfrage--> 10 Datensätze  A

Salamitaktik
--> Tabellen kleiner machen . part Sicht  Partition Kompression DB Redisgn


--mehr HDDs und Tabellen darauf verteilen

--tempdb lokal


--Warten : IX Statistiken
*/
select * into o1 from  orders

select * from o1 where orderid = 10250

select * from o1 where freight  < 1















