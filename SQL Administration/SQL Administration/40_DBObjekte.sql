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







---IO Reduziert

--Kompression 40 bis 60%

--Tabell splitten

--Partitionierung   vs part Sicht (INS UP DEL--> keine Identity, PK muss ID und Jahr


--Kompression  Partiotionierung
*/

set statistics io, time on
select * from ptab where id = 9000







Salamitaktik
--> Tabellen kleiner machen . part Sicht  Partition Kompression DB Redisgn


--mehr HDDs und Tabellen darauf verteilen

--tempdb lokal


--Warten : IX Statistiken
*/
select * into o1 from  orders

select * from o1 where orderid = 10250

select * from o1 where freight  < 1















--Tabellen  select * from tabelle 

--select * from view / Sicht 

select * from (select * from customers where customerid = 'ALFKI') vAlfki
create view vdemo
as
select * from customers

select * from vdemo 

--Sicht kann all das tun, was Tabelle tun kann: SEL INS UP DEL eig Rechte


--der select * gehört verboten!!!!

create table slf (id int, stadt int, land int)

insert into slf
select 1,10,100
UNION 
select 2,20,200
union

select 3,30,300

select * from slf

create view vslf
as
select * from slf

select * from vslf  --3 Zeilen 

alter table slf add fluss int

update slf set fluss = id*1000

select * from vslf

alter table slf drop column land --es kommt der Wert von Fluss in nicht exit Spalte land




drop table slf
drop view vslf
-------NEU  BESSER-------------
create table slf (id int, stadt int, land int)

insert into slf
select 1,10,100
UNION 
select 2,20,200
union
select 3,30,300

select * from slf

create view vslf with schemabinding ---!!!!!!!!!!!!!
as
select id, stadt, land from dbo.slf --kein * und alle schematas angeben

select * from vslf  --3 Zeilen 

alter table slf add fluss int

update slf set fluss = id*1000

select * from vslf

alter table slf drop column land --es kommt der Wert von Fluss in nicht exit Spalte land.. geht nicht mehr



create proc gpdemo @par1 int , @par2 int
as
select @par1*@par2


exec gpdemo 200,3


--Prozeduren gelten als schnell

--Sichten sind genausoschnell wie eine normale "Abfrage"

--Warum? 

--Der Ausfürhungsplan wird immer bei der ersten ausführung mit den ersten parametern erstellt?
--der Plan bleibt auch nach Neustart erhalten

--mit IX auf sp Id non clustered
set statistics io, time on
select * from kundeumsatz where id < 1000000   ---4Seiten 


create proc gpsuchid @parid int
as
select * from kundeumsatz where id <@parid

exec gpsuchID 1000000

--Prozeduren sollen nicht benutzerfreundlich sein

exec gpSucheKunden 'A' --10 DS -seek

exec gpSucheKunden 'AL' --2DS  seek


exec gpSucheKunden --alle DS  scan, macht trotzdem seek

---Soll un eher immer der Seek passieren oder immer der Scan

dbcc freeproccache --alle Pläne sind weg


exec gpsuchID 2


---Functions


--tu  nie im where um eine Spalte eine f() bauen ---> SCAN

--Tabellenwertf().. die können nie paralleisiert werden
-- schätz sql seltsam ein: 2014 erwartet immer 100 Zeilen
--2012 -- 1 



select * from orders where year(orderdate) = 1997
where left(famName, 1) = M












