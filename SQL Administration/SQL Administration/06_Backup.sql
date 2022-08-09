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