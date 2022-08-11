/*

Seitenkompr: macht zuerst Zeilenkompression

Zeilenkompression

40 bis 60% Text besser als Zahlen komprimierbar

*/

create table t1 (id int identity, spx char(4100))

insert into t1
select 'XY'
GO 20000



--Vorher : tabelle hat 20000 Seiten --> 160MB

--SQL neustarten: Taskmanager:    285MB

set statistics io, time on
select * from northwind..t1
--Seiten:  20000  Dauer:   CPU Zeit:   234 ms, verstrichene Zeit = 1503 ms.
--RAM danach : + 160MB

--Kompression:   auf ca 0.4MB

--RAM nach Neustart: evtl weniger --ne gleich, weil ja die t1 auch vorher nicht im RAM war..
--Client bekommt definitv 160 MB
set statistics io, time on
select * from northwind..t1

--Seiten: gleich ...weniger sein --> 29  1:1 in RAM
--RAM: 0.4 MB größer 
--Zeiten  CPU weniger  Dauer: weniger 

--Kompression eigtl zu Gunsten anderer Daten!!


select * from ptab where nummer = 6798




Hallo

Servus