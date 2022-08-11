/*

Normalisierung: Redundanz vermeiden
1 NF nur ein Wert pro Zelle
2.NF  PK
3.NF keine wechjselseitige Beziehung zw den spalten ausserhalb des PK

Primärschlüssel:
Aufgabe des PK...: es ist nicht Aufgabe den DAtesatz eindeutig zu machen, aber es ist ein Muss die Aufgabe zu erledigen
	--> AUfgabe: ref Integrität


--je mehr Normalisiert desto langsamer

1 MIO Kunden  1:N  2 MIO Best   1:N BestDet 4 MIO 
--RngSumme in Best


Generalisierung

Redundanz



Datentypen

'otto'
varchar(50)  'Otto'  4
char(50)  'Otto                             ' 50
nchar(50) Unicode  'otto                          ' 50 *2 
nvarchar(50) 'Otto'  4* 2



GebDat
datetime   (ms)
datetime2  (ns)
date (datum)
smalldatetime (sek)
datetimeoffset (ms plus Zeitzone)



----SEITEN!!!!!!!!!!!!




Seiten sind immer 8192bytes groß
1 Seiten hat max 8072 Nutzlast
max 700 Slots
1 DS mit fixen Längen darf nur max 8060 ZEichen haben
1DS mit fixen Längen muss in Seite passen
*/

create table t2 (id int identity, spx char(4100), sp2 char(4100))

--Fehler beim Erstellen oder Ändern der t2-Tabelle, weil die Mindestzeilengröße 8211 betragen würde, einschließlich 7 Bytes an internen Verwaltungsbytes. Dies überschreitet die maximal zulässige Größe für Tabellenzeilen von 8060 Bytes.

--was wäre wenn
-->1 DS  4100bytes --> 1 MIO DS --> 1 MIO Seiten
--> 8 GB  --> 1:1RAM--> 8 GB RAM



select * from orders where year(orderdate) = 1997 --richtig aber langsam

select * from orders where orderdate  between '1.1.1997' and '31.12.1997 23:59:59.999' --falsch aber schnell

--CRM Kunden. > 300   Hobby, Fax1 Fax2, Frau1 Frau2 Frau3 Frau4 , Religion


delete from customers where customerid ='ALFKI'

--Prmärschlüssel werden in SQL Server per default als CL IX angelegt.. und das ist purere Bullshit...
--der PK muss lediglich eindeutig sein und muss kein CL IX sein...

--wi ekonnte man feststellen ob Seiten gut ausgelsatet sind

dbcc showcontig('kundeumsatz')

select * from sys.dm_db_index_physical_stats

dbcc showcontig()--vorsicht!!