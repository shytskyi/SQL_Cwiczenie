--Wyświetl wszystkie dane z tabeli Products
SELECT * 
FROM [dbo].[Products]

--Wyświetl LastName  i FirstName z tabeli Employees
SELECT 
	[LastName]
	,[FirstName]
FROM [dbo].[Employees]

--Wyświetl wszystkie dane z tabeli Territories oprócz kolumny RegionId
SELECT 
	TerritoryID
	,TerritoryDescription
FROM [dbo].[Territories]

--Wyświetl 5 pierwszych kolumn z tabeli Suppliers
SELECT 
	[SupplierID]
	,[CompanyName]
	,[ContactName]
	,[ContactTitle]
	,[Address]
FROM [dbo].[Suppliers]

--Wyświetl wszystkie zamówienia
SELECT *
FROM [dbo].[Orders]

--Wyświetla dane z tabeli Customers ale zmien nazwy kolumn: 
   -- CustomerId -> ID
   -- CompanyName -> Name
   -- ContactTitle -> ContactPerson
SELECT
	[CustomerID] AS ID
	,[CompanyName] AS NAME
	,[ContactTitle] AS ContactPerson
FROM [dbo].[Customers] 

--Wyświetl dane adresowe z tabeli Customers jako jedna kolumna
    --Dane adresowe to: Adress, City, Country, PostaCode, Fax
SELECT
	'Dame adresowe to: '+[Address]+' '+[City]+' '+[Country]+' '+[PostalCode]+' '+[Fax] AS [DANE ADRESOWE]  --każda columna musi miecz jednakowy typ  
FROM [dbo].[Customers]

--Z tabeli Customers wystwietl wszystkie Country (policz wiersze)
SELECT DISTINCT
	[Country]
FROM [dbo].[Customers]

--Napisz zapytanie, które wyświeli różniące się wartości Country oraz City tabeli Customers 
SELECT DISTINCT 
	[City]
	,[Country]
FROM [dbo].[Customers]
ORDER BY [Country] ASC   -- LUB DESC

--Napisz zapytanie które wyświeli różniące się wartości CustomerID, Country oraz City tabeli Customers (policz wiersze, wytłumacz co się stało)
SELECT DISTINCT
	[CustomerID]
	,[Country]
	,[City]
FROM [dbo].[Customers]
ORDER BY [Country] DESC

SELECT
	[Country]
FROM [dbo].[Customers]
WHERE [Country] LIKE 'U%' OR [Country] LIKE '%u%'

--Wyswietl wszystkich Customers gdzie City to Londyn
SELECT *
FROM [dbo].[Customers]
WHERE [City] = 'London' OR [City] = 'Paris' AND [Country] LIKE 'A%'

--Wyświetl wszystkich Customers gdzie Country jest inne niż Mexico
SELECT *
FROM [dbo].[Customers]
WHERE [Country] <> 'Mexico'
ORDER BY [Country]

--Wyświetl wszystkie Products gdzie UnitPrice = 20
SELECT *
FROM [dbo].[Products]
WHERE [UnitPrice] = 20

--Wyświetl wszystkie Products gdzie UnitPrice >= 20
SELECT *
FROM [dbo].[Products]
WHERE [UnitPrice] >= 20
ORDER BY [UnitPrice] DESC

--Wyświetl wszystkie Products gdzie UnitsInStock < 10
SELECT *
FROM [dbo].[Products]
WHERE [UnitsInStock] < 10
ORDER BY [UnitsInStock]

SELECT
	[CustomerID]
	,[Region]
FROM [dbo].[Customers]
ORDER BY CASE WHEN [Region] IS NULL THEN 1 ELSE 0 END,  [Region] 

--*Wyświetl wszystkie Customers gdzie Region jest pusty
SELECT *
FROM [dbo].[Customers]
WHERE [Region] IS NULL

--Wyswietl wszystkich Customers gdzie PostalCode jest NOT NULL
SELECT *
FROM [dbo].[Customers]
WHERE [PostalCode] IS NOT NULL

--Wyswietl wszystkich Customers gdzie:
--Country = France i City = Paris lub (City = Marseille i ContactTitle <> Owner)
SELECT *
FROM [dbo].[Customers]
WHERE [Country] = 'France' AND [City] = 'Paris' OR ([City] = 'Marseille' AND [ContactTitle] <> 'Owner')

--Wyswietl wszystkie ORDERS. Posortowane po Freight ASC i OrderDate Desc
SELECT *
FROM [dbo].[Orders]
ORDER BY [Freight] ASC, [OrderDate] DESC

--Z tabeli Customers wyświetl kolumnę Country gdzie:
    --Country rozpoczyna się na literę „F”
	--Country zawiera literę „O” lub kończy się na „Y” (wyświetl niepowtarzające się wartości)
SELECT [Country]
FROM [dbo].[Customers]
WHERE [Country] LIKE 'F%'
SELECT DISTINCT [Country]
FROM [dbo].[Customers]
WHERE [Country] = 'O' OR  [Country] LIKE '%y'

--Wyświetl wszystkie dane z tabeli Orders gdzie:
  --shipCity = Reims lub Lyon lub Graz
SELECT *
FROM [dbo].[Orders]
WHERE  [ShipCity] IN ('Reims', 'Lyon', 'Graz')



SELECT 
	c.CustomerID AS ID
	,c.CompanyName AS Name
	,c.ContactName
	,c.ContactTitle
	,c.Address
	,c.City
	,c.Region
	,c.PostalCode
	,c.Country
	,c.Phone
	,c.Fax
	,o.OrderID
	,o.ShipCity
	,o.OrderDate
FROM [dbo].[Customers] AS c
JOIN [dbo].[Orders] AS o ON c.CustomerID = o.CustomerID