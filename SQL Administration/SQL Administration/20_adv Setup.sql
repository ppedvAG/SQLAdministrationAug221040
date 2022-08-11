--Volumewartungstask

/*

Dateien können wachsen

---------------------
xxxxxxxxxxxxxxxxxxx
---------------------

seit SQL 2016
DB Initalgrößen: 8 MB Daten und 8 MB Logfile
Wachstumrate: 64 MB

vor SQL 2016
5MB   +1 MB
2 MB

--kein Ausnullen und SQL übernimmt Aufgabe selber

--kann man eigtl immer anhaken

--warum Security

lokale Sicherhetisrichtline
Durchführen von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausführen können, zum Beispiel eine Remotedefragmentierung.

Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht können Datenträger durchsuchen und Dateien in den Speicher erweitern, der andere Daten enthält. Wenn die erweiterten Dateien geöffnet werden, kann der Benutzer möglicherweise die so erlangten Daten lesen und ändern.

Standardwert: Administratoren

Aber für den guten Admin ist das rel egal
--Anfangsgrößen auf einen Wert setzen, der am Ende der Lebenszeit errreicht wird
--Wachstumsrate auf 1024MB. ode rzumindest so, dass das Wacshtum selten passiert aber auch nicht ins Gewicht

--kann man das irgendwo festestellen?


--Pfade
--trenne daten von logfile, aber beurteile das DB nochmal extra (evtl eig HDDs für die DB)



--TEMPDB
Regel: sollte soviele Datendatein wie Kerne (max 8)
--wieso haben wir 2 Dateien, obwohl 4 Prozessoren
--Virtualsierung (beim Setup gabs nur 2 )
--absichtlich nur 2 vergeben
--gib der Tempdb eig HDDs und trenne Daten von Log

--IX Wartung  200MB + 1 GR IX + 2 NGR IX --> 363 MB: 1100MB
--Zeilenversionierung
--temp Tabellen

- Traceflag 1117  1118 (im Hintergrund)


--MAXDOP
wieviele Kerne darf eine Abfrage max verwenden
 eine Bafreg verwendet immer nur 1 Kern oder alle bzw Mxdop Wert
 --Regel: Maxdop = Anzahl der Kerne max 8  früher war der Wert 0
 --Abhängig von den kosten default 5  
 --mehr als 8 ist nicht gut
 --Serversetting - Seit SQL 2016 auch pro DB einstellbar 
 --Kostenschwellwert ist aber nur pro Server einstellbar



 --Arbeitsspeicher
 MAx Wert auf Gesamt - OS einstellern
 das Setup schlägtdies vor, muss aber vorher ausgewählt und akzeptiert werden :-/
 OS: ca 2 bis 10 GB 
Min Wert macht zunächst noch keinen Sinn einzustellen, da der Wert erst zählt, wenn entsprechend Datenim Speicher liegen












*/