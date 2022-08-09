/*
Was kann alles passieren?

Fälle

A)   
			Logischer Fehler
			Inhalte der DB werden versehentlich geändert/gelöscht 
B) 
		   eine oder mehr Dateien beschädigt
C)	
		Server ist tot. Restore auf neuen /anderen Server
D)
		wenn ich weiss, dass gleich was passieren könnte.
E) 
		normaler Restore der DB auf OriginalServer

----------------------------------------------------------
--Backupvarianten
----------------------------------------------------------

V   Vollständiges Backup
sichert die Dateien/Größe und Pfade und deren Inhalte zu einm best Zeitpunkt
Checkpoint Daten aus dem RAM wegschreiben auf mdf für best Transaktionen


D Differentielles
sichert alle seit V geänderten Seiten bzw  Blöcke weg
sichert inene Zeitpunkt

T Transaktionsprotokoll Sicherung
schreibt alle Transkationen ins Log , daher müssen beim Restore alle Aktionn wieder durchgespielt werden
sichert den Weg und daher Restore auf Sekunde möglich


x V  6:00  
	T  manuell
	T  SW
	T  Ag
	D  Agent
	T  SW
	T man
	T 
	D 
	T 
	T 
	T 
x	D   18:00 
x	T 
x	T       21:00
--falsches update um 21:54:10
x	T     22:00


Was ist der schnellste Restore?
V daher so häufig wie möglich 

Wie lange dauert der Restore eines T?
auf ca 10sek genau?
es dauert solange, wie die Transaktionen im Orig brauchten


Firmeregel:
wie lange darf der Server bzw DB ausfallen?  (ink Reaktionszeit)
wie groß darf der Datenverlust in Zeit sein?  --> T
..Zusatz: mit gerinsgt möglichen Datenverlust

Weden alte Sicherung automatisch gelöscht?
--> Wartungsplan
--> Backupmedium kennt die Option Ablaufdatumzeit  with format

! Tipp: nbie in eine !!!! Datei wegsichern  


Es kann sein, dass das Protkoll nicht sicherbar ist


Wiederherstellungsmodel


Einfach
TX werden nach commit aus dem Log automatisch gelöscht
keine Sicherung des Logfile
es wird weniger protoklliert: INS UP DEL BULK rudimentär

Massenprotokolliert
wie Model Einfach
keine Leerung des Logfiles--> Logfile muss gesichert werden
theoretisch restore auf Sekunde möglich, aber nur dann , wenn kein BULK

!!! NUR DIE SICHERUNG DES TP leert das TP

Voll
protkolliert deutlich mehr auch BULK ausführlich
Restore auf Sek möglich

!!! NUR DIE SICHERUNG DES TP leert das TP
*/
--Vollsicherung
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\nwinddb.bak'
WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Diff
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  DIFFERENTIAL
, NOFORMAT, NOINIT,  NAME = N'Northwind-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Log
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\nwinddb.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--V TTT D TTT D TTT D TTT
--!                                !  !!!


-----------------------------------------------------------
--RESTORE
-----------------------------------------------------------

--A)   
			--Logischer Fehler
			--Inhalte der DB werden versehentlich geändert/gelöscht 

--Idee.. Tabelle Kunden, die versehentlich geändert wurde wieder restoren
--Restore als andere DB
--man muss wissen was genau geschehen

USE [master]
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 1,  MOVE N'Northwind' TO N'D:\_SQLDBDATA\MSSQL15.MSSQLSERVER\MSSQL\DATA\norttt222hwnd.mdf',  MOVE N'Northwind_log' TO N'D:\_SQLDBDATA\MSSQL15.MSSQLSERVER\MSSQL\DATA\nortvv222tthwnd.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 9,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 12,  NOUNLOAD,  STATS = 5

GO



--B) 
		   --eine oder mehr Dateien beschädigt

		   select * from sys.databases

		use [master];
GO
USE [master]
GO
ALTER DATABASE [Northwind2] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
EXEC master.dbo.sp_detach_db @dbname = N'Northwind2'
GO

--Logfile defekt oder komplett weg

USE [master]
GO
CREATE DATABASE [Northwind2] ON 
( FILENAME = N'D:\_SQLDBDATA\MSSQL15.MSSQLSERVER\MSSQL\DATA\norttt222hwnd.mdf' )
 FOR ATTACH
GO
--..das fehlend3e Logfile wurde automatsch erstellt

--was wäre wenn die mdf defekt wäre---> dann guter AV? gutes Backu zur Hand


--C 
		--Backup auf anderen Serverrestoren

		--1: Kopiere die Sicherung dorthin (auf den Zielserver) wo auch Backups sind (wg Rechten)


		USE [master]
RESTORE DATABASE [Northwind] FROM  DISK = N'C:\Backup\nwinddb.bak' WITH  FILE = 1,  MOVE N'Northwind' TO N'C:\_SQLDBS\norttthwnd.mdf',  MOVE N'Northwind_log' TO N'C:\_SQLDBS\nortvvtthwnd.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'C:\Backup\nwinddb.bak' WITH  FILE = 9,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'C:\Backup\nwinddb.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'C:\Backup\nwinddb.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'C:\Backup\nwinddb.bak' WITH  FILE = 12,  NOUNLOAD,  STATS = 5

GO


---E) 
		--normaler Restore der DB auf OriginalServer

/*
Backup lief um 11:31

Problem um 12:01 logischer Fehler  DB läuft einwandfrei weiter mit falschen Daten
JETZT 12:10
Nächste  Sicherung ist 12:30  (T)

--restore die DB mit geringst möglichen Datenverlust

--Idee 1:  Restore von 11:31  Datenverlust ca 30min

--Idee 2: Warten auf 12:30, dann restore von 12:00 
--DAtenverlust kanpp 30 min

--Idee 3: manuell Sicherung um 12:10, dann Restore auf 12:00 
-- Datenverlust 10min ? eigtl nicht, weil alles im Backup ist bis 12:10
--Datenverlust dennoch: ja weil Sicherung ist Online, alles was während der Sicherung passiert bzw beginnt ist nicht mehr Teil der Sicherung

--Idee 4:  User runterwerfen , dann keinen mehr drauf lassen, dann backup log, dann restore auf 12:00
--0 Datenverlust
*/
USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-08-09_12-21-57.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2022-08-09_12-21-57', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 9,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\nwinddb.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind\Northwind_backup_2022_08_09_120001_0352506._tlog.trn' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-08-09_12-21-57.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2022-08-09T12:15:00'
ALTER DATABASE [Northwind] SET MULTI_USER

GO


-----------------------------------------------
--SNAPSHOT
---------------------------------------------

D) 
		--wenn ich weiss, dass was passieren kann (UPD einspielen)

		--Ziel: lesbare DB mit den DAten vonm Backupzeitpunkt

		-- auich wenn die OrigDB 100GB, dann hat die ZielDB dennoch zu Beginn nur 128kb

-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO

-- Create the database snapshot
CREATE DATABASE SNAPSHOTDBNAME ON
( 
NAME =LogischerDAteinamederOrigDB, 
FILENAME = 'PFADUNDDATEINAMEDESSNAPSHOT.mdf' )
AS SNAPSHOT OF ORIGNALDB;
GO



-- Create the database snapshot
CREATE DATABASE SN_Northwind_1355  ON
( 
NAME =northwind, 
FILENAME = 'D:\_SQLDBDATA\SN_Northwind_1355.mdf' 
)-- falls mehrere Datendateien vorhanden sind, uss die Klammer  wiederholt werden pro Datei
AS SNAPSHOT OF northwind;
GO

--RESTORE mittles SNAPSHOT

--alle Blöcke und Seitzen aus dem Snapshot zurückspielen und alle neuen Seiten und Blöcke der QuellDB verwerfen

restore database northwind
from database_snapshot = 'SN_Northwind_1355'

--der Restore geht nur, wenn:
--der Snapshot und die OrigDB nicht verwendet werden

--wie finde ich die User, die auf den DBs sind?

--Aktivitätsmonitor oder TSQL
--alle Prozesseüber 50 sind User
--DBID herausfinden
select db_id('northwind'), db_id('sn_northwind_1355')

select * from sys.sysprocesses where spid > 50 and dbid in(5,21)

kill 54 --die Prozesse beenden 


--Kann man mehrere Snapshots haben?
--Ja

--Kann man einen Snapshot sichern?
--Nö

--Kann man den Snapshot retoren?
--Hä... dooofe Frage  Nö!

--Kann man die Orig DB backupen?
-- Ichoffe doch: jaaaa!

--Kann man die OrigDB restoren?
--Nö, solange ein Snapshot existiert gehts nicht

--Wie lange existiert ein snapshot?
--bis ein Restore notwendig wird

--war eigtl Enterpsie Funktion, aber seit SQL 2016 SP1 auch in allen anderen Editionen!


-------------------------------------------------
---BACKUPSTRATGIE
-------------------------------------------------

--DB:  
---Größe der DB: 40GB
---Arbeitszeiten:  7:00 bis 20:00   Mo bis Fr

--Wie lange darf die DB ausfallen?  1 Stunde
--Wie groß darf der Datenverlust in Zeit sein: 
--0 --> Hochverfügbarkeit (Spiegelung oder AlwaysOn Avialbailitygroups 
 -- 5 min

 --V: täglich  (zw 20 Uhr und 7 Uhr)
 --T : alle 5 min (von 7:05 bis 20:00)
 --D: alle 30min




 --DB:  
---Größe der DB: 400GB
---Arbeitszeiten:  7:00 bis 20:00   Mo bis Fr
-- Ausfallzeit unter 10min --> Hochverfügbarkeit

--V TTTTTTTTTTTTTTTTTTTTTTXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT
-