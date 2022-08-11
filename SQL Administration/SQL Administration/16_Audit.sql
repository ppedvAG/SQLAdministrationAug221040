--Login anlegen ändern

--alter Table  view

--INS UP DEL -- TRIGGER

SEL Audit




--Table
--Views / Sichten

--Sicht: gemerkte Abfrage

select * from (select * from customers) c


create view view1
as
select * from customers

select * from view1


--Überwachung = Logdatei




USE [master]
GO

/****** Object:  Audit [Sicherheitsaudit]    Script Date: 20.07.2022 12:21:54 ******/
CREATE SERVER AUDIT [Sicherheitsaudit]
TO FILE 
(	FILEPATH = N'D:\_BACKUP\'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE, AUDIT_GUID = '75e0d808-c7c7-4bb7-a6f5-48115378ea0b')
ALTER SERVER AUDIT [Sicherheitsaudit] WITH (STATE = OFF)
GO


USE [master]
GO

CREATE SERVER AUDIT SPECIFICATION [LoginAuditX]
FOR SERVER AUDIT [Sicherheitsaudit]
ADD (FAILED_LOGIN_GROUP),
ADD (USER_CHANGE_PASSWORD_GROUP)
WITH (STATE = OFF)
GO


USE [Northwind]
GO

CREATE DATABASE AUDIT SPECIFICATION [SEL_SUSI]
FOR SERVER AUDIT [Sicherheitsaudit]
ADD (SELECT ON OBJECT::[dbo].[Employees] BY [SUSI])
WITH (STATE = OFF)
GO


