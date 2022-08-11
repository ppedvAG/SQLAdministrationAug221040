--MAXDOP

/*
ob ein oder mehr Prozessoren verwendet werden hängt von den Kosten des Plans ab
ab Kostenschwellwert 5 werden mehr Kerne eingesetzt

*/

set statistics io, time on-- Seiten, Dauerin ms der CPU und ges Dauer  --off

select country, sum(unitprice*quantity) from kundeumsatz
group by country


-- 37643 Seiten

--, CPU-Zeit = 533 ms, verstrichene Zeit = 74 ms.
--CPU-Zeit = 422 ms, verstrichene Zeit = 64 ms.
--SQL Server-Analyse- und Kompilierzeit: 
,---CPU-Zeit = 52 ms, verstrichene Zeit = 52 ms.

select country, sum(unitprice*quantity) from kundeumsatz
group by country option (maxdop 1)

--, CPU-Zeit = 219 ms, verstrichene Zeit = 218 ms. mit 1 Kern


--CXPACKET

select country, sum(unitprice*quantity) from kundeumsatz
group by country option (maxdop 6)

---bei 4 oder 6 Kernen sind wir eigtl genausogut dran (Dauer) bei weniger CPU Leistung
----> und haben freie CPUs 


--was eigtl wenn alle CPUs gerade in Nutzung sind
--Suspended  Runnable Running

--es solte der MAXDOP angepasst werden (Shop oder DAtenwarehouse)
--MAXDOP pro DB.zählt dann der Wert der DB
--steht der Wert 0 in der DB zählt der Wert des Servers
--es zählt immer der Wert des MAXDOP je näher er an der Abfrage definiert wurde
select country, sum(unitprice*quantity) from kundeumsatz
group by country option (maxdop 4)

--der Kostenschwellwert von 5 ist sehr niedrig... es sollte korrrigiert werden
--Datawarehouse 25   OLTP (shop) 50
--der KOstenschwellwert muss überschritten werden, damit der MAXDOP wirksam wird

--kein Neustart notwendig


