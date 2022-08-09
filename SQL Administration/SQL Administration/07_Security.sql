USE [master]
GO
CREATE LOGIN [Lukas] WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


CREATE LOGIN Eva WITH PASSWORD=N'123', DEFAULT_DATABASE=northwind, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


USE [Northwind]
GO
CREATE USER [Eva] FOR LOGIN [Eva]
GO


select * from syslogins--0xDD8BB8EAF8BFF24A98F05280FDBD94C5

select * from sysusers  --0xDD8BB8EAF8BFF24A98F05280FDBD94C5



USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO


create table it.projekte (itpro int)
create table it.kst (itkst int)

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Lukas]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [Eva]
GO


select * from customers

select * from kst --dbo.kst
USE [Northwind]
GO
ALTER USER [Eva] WITH DEFAULT_SCHEMA=[MA]
GO


--vererbete Rechte werden nicht angezeigt . Man muss sie explizit suchen...

use [Northwind]
GO
GRANT SELECT ON [IT].[projekte] TO [Eva]
GO


USE [Northwind]
GO
CREATE ROLE [ITRolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Lukas]
GO
use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [ITRolle]
GO

use [Northwind]
GO
GRANT CREATE TABLE TO [Eva]
GO


use [Northwind]
GO
GRANT ALTER ON SCHEMA::[MA] TO [Eva] -- CREATE DROP inklusive
GO


--Gib nie einem normalen User das recht create procedure, create view , create function
--aber vergebe iummer den BEsitz dem dbo, dann wird das Handlung mit den Rechten  einfacher
--Besitzverkettung


select * from northwind.dbo.employees










--default Schema ist dbo



create table ma.projekte (mapro int)
create table ma.kst (makst int)



