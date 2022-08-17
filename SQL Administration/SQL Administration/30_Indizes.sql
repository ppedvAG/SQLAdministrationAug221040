/*

IX sind für vieles verantwortlich


Sperrverhalten
Performance
Fragemtierung von Tab und IX



Clustered Index  (gruppierte)
= Tabelle  , j+kann also nur 1 mal pro Tabelle geben
serh gut bei eindeutigen Werten, kein Lookup
aber auch richtig gut bei Bereichsabfragen  <> between


NON CL IX (nicht gr)..kann pro Tab 1000 mal geben
..ist gut bei rel wenigen Ergebniszeilen .. bei Lookup dann evtl bei ca 1%
--ideal bei Suche auf IDs / PK  = 

PK wird automatisch immer als eindeutiger und gruppierter IX angelegt
--was aber nicht sein muss.. es kann auch ein nicht gr sein



-------------------------------
zusammengesetzten IX
besteht aus mehreren Spalten  (max 16 )
eindeutigen IX
legt fest, dass die IX Spaltenwerte immer eindeutig sind
IX mit eingeschls Spalten  !

gefilterten IX-- nicht alle Datenzeilen der Tabelle
--dann aber mit weniger Ebenen! sons sinnlos


part IX
funktioniert eigtl wie ein gefilterter IX


ind Sicht
--ist aber in der Praxis fast irrelavant. Extrem starke Einschränkungen


abdeckender IX --der ideale IX
realer hypothtischer IX --tools
---------------------------------
columnstore 


*/
select * into kundex from kundeumsatz
select * into kundey from kundeumsatz

--beide Tabelle sind ohne Indizes

--Abfrage, die 

--den max Umsatz für ein best Datum , für die wo aus Llondon

set statistics io, time on
select top 1 with ties orderdate, max(unitprice*quantity) as Umsatz from kundex where employeeid = 2 group by orderdate
order by Umsatz desc

---NIX_city_inc_Odate_UP_QU

select top 1 with ties orderdate, max(unitprice*quantity) as Umsatz from kundey where  employeeid = 2 group by orderdate
order by Umsatz desc


--KundeX ist ca 320 MB inkl IX

--KundeY ist ca   3,4 MB inkl IX--ist auch so real.. stimmt! --> Kompression (aber KundeX würde nur 64 MB schaffen)


--In Summe: die besten IX finden, überflüssige IX entfernen,  IX warten


select * from sys.dm_db_index_usage_stats--überflüsige Indizes

--diese komprimierte Tabelle kommtr logischerweise auch 1:1 in RAM!!!

select object_name(i.object_id) as TableName
      ,i.type_desc,i.name
      ,us.user_seeks, us.user_scans
      ,us.user_lookups,us.user_updates
      ,us.last_user_scan, us.last_user_update
  from sys.indexes as i
       left outer join sys.dm_db_index_usage_stats as us
                    on i.index_id=us.index_id
                   and i.object_id=us.object_id
 where objectproperty(i.object_id, 'IsUserTable') = 1
go














*/
--SCAN TABLE / CL 
select * from best



select bid from best where bid = 100





set statistics io, time  on

select id from kundeumsatz where id = 100--3 seiten

select id, freight from kundeumsatz where id = 100--4 seiten

select id, freight from kundeumsatz where id < 100--102 seiten

select id, freight, Employeeid  from kundeumsatz where id < 950000 --3 seiten
--jede Menge Lookups bis ca 10000 DS





select country, city, sum(unitprice*quantity) from kundeumsatz
where productid = 5
group by country, city


select country, city, sum(unitprice*quantity) from kundeumsatz
where productid = 5 or employeeid = 2
group by country, city