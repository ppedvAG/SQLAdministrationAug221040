/*

Virtualisierung

muss genauso funktionieren, als w�re sie nacktes Blech
--sind die HDDs genauso schnell in der VM
--CPU Auslastung
--auch genug RAM

SQL DB braucht eigtl 2 HDDs mind, wenn es schnell sein soll
und der SQL Server nochmal  mind 2 HDDs, wenn es schnell sein soll
--Bwin:f�r eine Tabelle 1000 HDDs im Einsatz


16 GB-4 GB = 12 GB
HV-DC:  2 GB RAM  1 CPU

HV-SQL1: 6GB   4 Kerne

HV-SQL2:  4 GB 4 Kerne



schulung\Administrator
ppedv2019!


computer\fe













INSTALLATION




Pfade
			- Bin�rkram: egal
			--Daten und Logfile: trenne Daten von Logfiles physikalisch (mehrere HDDs)

Instanzen: 
-	SQL Server kann bis zu 25 mal installierbar
- jede Instanz ist eine ieg isolierte Installation(eig Verzeichnisse eig DB)

- warum Instanzen:  Test/Produktiv   Versionen/Edition  Security Perfomance


COMPUTER\FE

COMPUTERNAME


Freigegebene Funktionen (nur einmal installierbar)
Konnektivit�t der Clientools



-- Port: 1433 TCP bei Standardinstanz
--Port�: weitere Instanzen haben einen random Port  (benannte Instanz)

Security
-  immer NT Auth
-- gemischt Auth (NT Auth + SQL Logins)
-- spez SQL Login : sa --> Kennwort muss komplex sein:  mehr als 8 Zeichen und komplex
-- sp�ter sa deaktiveren aus Sicherheitsgr�nden

-- Windows Admins sind keine SQL Admins!
--es muss beim Setup ein Windows Konto angegeben werden der ist dann "Sysadmin"


MAXDOP
wieviele Kerne darf eine Abfrage verwenden 
--einen Kern oder alle des MAXDOP Wertes)


Arbeitsspeicher
--min RAM: 0 
--max RAM: begrenzen, damit auch das OS noch etwas zum Leben hat 
 ---OS braucht in etwa: mind 2 GB  bis 10 GB


 Dienste(konten)

--SQL Server: DB Modul
--SQL Agent: Jobs Auftr�ge per Zeitplan
--Browser :  "Rezeptionist" teilt dem Client den Port zur benannten Instanz mit
--braucht 1434 UDP

--Volltextsuche:  f�r contains formsof

NT Service/mssqlserver .. sind managed Serviceaccounts, 
								lokale Konten, 
								Kennw�rter werden von Windows verwaltet
								geringe Rechte (ist nicht lokal system)
								im Netz wird das Computerkonto verwendet

--auch Dom User (dom\ServiceSQL)  m�ssen keine besonderen Rechte vorab haben



TEMPDB sollte eig HDDs besitzen 
evtl auch Log von Daten trenne




























*/