--die Std Größenund Wachstumsraten 
-- 8MB für Dateien und Wachtum +64 MB
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

--Bericht auf DB: Datenträgerverwendung

--es läßt sich jederzeit die datei vergrößern und acuh evtl verkleinern








