--die Std Gr��enund Wachstumsraten 
-- 8MB f�r Dateien und Wachtum +64 MB
--nicht perfekt ;-)

use berlindb; --KOmmentar   select 100
GO

/*
select getdate()
*/

create table t1 (id int identity(1,1), spx char(4100));
GO


insert into t1
select 'XY'
GO 30000 --57 Sekunden  38 17

--Bericht auf DB: Datentr�gerverwendung

--es l��t sich jederzeit die datei vergr��ern und acuh evtl verkleinern








