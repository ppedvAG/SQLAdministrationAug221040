/*
Tabellen auf andere HDDs legen

Db kann mehrere (viele ) Dateien haben..  .ndf

*/

create table test(id int)

--heisse Tabelle auf andere HDDs
--kalten / STammdaten auf andere HDDs (Azure Strech Database)

--Dateigruppen-------------------------

--Alias für ein ndf  oder mehr ndf Dateien

create table test (id int) ON Dateigruppen


ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwindhotdata', FILENAME = N'D:\_SQLDBDATA\nwindhotdata.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [HOT]
GO


create table test2(id int) on hot --klappt..

--Frage: Wie kan ich Tabellen auf anderen Dateigruppen verschieben?

---Weg 1: Tabelle neu erstellen
-- Weg 2: Indizes


--Tabelle Umsatz wird immer größer.... :

Umsatz2022
Umsatz2021
Umsatz2020
Umsatz2019

select * fro umsatz where jahr = 2021



create table u2022(id int identity, jahr int, spx int)
create table u2021(id int identity, jahr int, spx int)
create table u2020(id int identity, jahr int, spx int)
create table u2019(id int identity, jahr int, spx int)


select * from umsatz


create view Umsatz
as
select * from u2022
UNION ALL --kein suche nach doppelten zeilen
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019


--bringt das was bisher?
select * from umsatz where jahr = 2021
select * from umsatz where id = 2021

GO
ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

	GO
ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

	GO
ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)


	-achtung: Part Sicht -->bei INS UP DEL --> kein Identity, PK muss eindeutigkeit über die sicht

	--> Archiv



	----------Partitionierung
	-- bis100, bis200 bis500 , rest

	USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis100', FILENAME = N'D:\_SQLDBDATA\nwbis100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis200', FILENAME = N'D:\_SQLDBDATA\nwbis200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis5000', FILENAME = N'D:\_SQLDBDATA\nwbis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwrst', FILENAME = N'D:\_SQLDBDATA\nwrst.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO



	GO
ALTER TABLE dbo.u2022 ADD CONSTRAINT
	CK_u2022 CHECK (jahr=2022)


	-----------100--------------200---------------
	create partition function fZahl(int)--muss sortierbar
	as
	range left for values(100,200)


	select $partition.fzahl(117) --2

	--Part scheme


	create partition scheme schZahl
	as
	partition fzahl to(bis100,bis200,rest)
	--------------------    1       2      3


	create table ptab (id int identity, nummer int, spx  char(4100))
	ON schZahl(nummer)


	--Schleife für 20000 inserts
	declare @i as int = 1
	begin tran
	while @i <=20000
	begin
				insert into ptab(nummer, spx) values(@i, 'xy')
				set @i=@i+1
	end
	commit


	insert into t1
	select 'XY'
	GO 20000 --17 / 35 / 57 


	--ist das besser????

	--PLAN
	set statistics io, time on

	select * from ptab  --20000

	select * from ptab where id = 117

		select * from ptab where nummer = 117

		--SCAN: geht alles durch
		--SEEK: herauspicke


		--kann man Grenzen dazunehmen

		--Tab, Dgruppen, F(), schema
		--nix     bis5000     !       !

		-------100---------------200-------------5000


		
	alter partition scheme schZahl next used bis5000

	select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
	from ptab group by $partition.fzahl(nummer)


alter partition function fzahl()  split range(5000)


--Partitionierung ist mit vielen anderen Dingen kombinierbar





--Grenzen entfernen   100

--------100---------200------5000-------

alter partition function fzahl()  merge range(100)





--Feld BestDatum datetime

---------2019  2020  2021
	create partition function fZahl(datetime)--muss sortierbar
	as
	range left for values('31.12.2021 23:59:59.997')

	-------inkl 2021]------
	-----a bis m  --- n   bis r  --- s bis z
	create partition function fZahl(datetime)--muss sortierbar
	as
	range left for values('N',r)

	create partition scheme schZahl
	as
	partition fzahl to([PRIMARY],[PRIMARY],[PRIMARY])

	
	create partition scheme schZahl
	as
	partition fzahl  all  to([PRIMARY])

