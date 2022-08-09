--Tabelle

--Sichten Views
--enthalten selbst keine Daten
--gemerkte Abfrage, die sich wie ein Tabelle verhält

create view vKunden
as
select * from customers


select * from vkunden


create view KundeUmsatz
as
SELECT      Customers.CompanyName, Customers.CustomerID, Customers.ContactName, Orders.OrderDate, Orders.Freight, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID


	select * from kundeumsatz