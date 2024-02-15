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

--Z tabeli Customers wyświetl kolumnę Country gdzie:
    --Country rozpoczyna się na literę „F”
	--Country kończy się na literę „O”
    --Country zawiera literę „K”
SELECT [Country]
FROM [dbo].[Customers]
WHERE [Country] LIKE 'F%'

SELECT [Country]
FROM [dbo].[Customers]
WHERE [Country] LIKE '%o'

SELECT [Country]
FROM [dbo].[Customers]
WHERE [Country] LIKE '%k%'

--Z tabeli Customers wyświetl kolumnę Country i City gdzie:
  --Country zaczyna się na literę „P” i City kończy się na „aw”
  --Country zawiera literę „K” ale ma minimum 3 znaki  oraz City zaczyna się na ‚K’ i kończy na ‚N’
SELECT 
	[Country]
	,[City]
FROM [dbo].[Customers]
WHERE [Country] LIKE 'P%' AND [City] LIKE '%aw'

SELECT 
	[Country]
	,[City]
FROM [dbo].[Customers]
WHERE [Country] LIKE '%__k%' AND [City] LIKE 'K%n'

--Wyświetl wszystkie dane z tabeli Orders gdzie:
  --shipCity = Reims lub Lyon lub Graz
  --orderId = 10248 lub 10251 lub 10257
  --shipCity = Resende lub Münster oras ShipRegion jest rożny od NULL
SELECT *
FROM [dbo].[Orders]
WHERE [ShipCity] IN ('Reims', 'Lyon', 'Graz')

SELECT *
FROM [dbo].[Orders]
WHERE [OrderID] IN ('10248', '10251', '10257')

SELECT *
FROM [dbo].[Orders]
WHERE [ShipCity] IN ('Resende', 'Münster') AND [ShipRegion] IS NOT NULL

--Z tabeli Orders wyświetl kolumny shipCity oraz shipCountry gdzie:
  --shipCity = Reims lub Lyon lub Rio de Janeiro lub shipCountry = France lub Belgium lub USA
  --shipCity = Reims lub Lyon lub shipCountry = France lub Belgium lub shipVia = 3 lub 2
SELECT 
	[ShipCity]
	,[ShipCountry]
FROM [dbo].[Orders]
WHERE [ShipCity] IN ('Reims', 'Lyon', 'Rio de Janeiro') OR [ShipCountry] IN ('France', 'Belgium', 'USA')

--Z tabeli Orders wyświetla wszystkie wiersze które spełniają warunki:
	--1. OrderId znajduje się przedziale: 10266 – 10318
	--2. ShipCountry znajduje się przedziale: Austria  - France
	--3. OrderDate jest w przedziale: 1996-07-01 – 1996-08-30
SELECT *
FROM [dbo].[Orders]
WHERE [OrderID] BETWEEN 10266 AND 10318

SELECT *
FROM [dbo].[Orders]
WHERE [ShipCountry] BETWEEN 'Austria' AND 'France'

SELECT *
FROM [dbo].[Orders]
WHERE [OrderDate] BETWEEN '1996-07-01' AND '1996-08-30'

--W tabeli Products wyznacz:
	--1. Różnicę między UnitsInStock a UnitsOnOrder
	--2. Sumę UnitPrice , UnitsInStock, UnitsOnOrder
	--3. Iloczyn UnitsInStock i ReorderLevel, od wyniku odejmij UnitPrice
	--4. Podziel UnitPrice przez UnitsOnOrder
	--* Wyznacz wartość zamówienia z id 10317 z tabeli Order Details
SELECT 
	[UnitsInStock] - [UnitsOnOrder] AS 'Roznica UnitsInStock, UnitsOnOrder'
FROM [dbo].[Products]

SELECT 
	[UnitPrice] + [UnitsInStock] + [UnitsOnOrder] AS 'SUM UnitPrice, UnitsInStock, UnitsOnOrder'
FROM [dbo].[Products]

SELECT 
	COUNT ([UnitsInStock] + [UnitsOnOrder]) AS ILOSC
FROM [dbo].[Products]

SELECT 
	[UnitPrice] / [UnitsOnOrder]  AS ILOSC
FROM [dbo].[Products]
WHERE [UnitsOnOrder] <> 0

SELECT 
	[Quantity] * [UnitPrice] AS WARTOSC
FROM [dbo].[Order Details]
WHERE [OrderID] = 10317

--W tabeli Products znajdź:
    --Wyznacz najwyższą cenę
    --Wyznacz najniższą cenę
    --Sprawdź jaką jest średnia cena produktów
    --Policz ile kosztują razem wszystkie produkty
    --Policz ile jest dostępnych produktów (discountinued = 1)
    --Policz ile kosztują wszystkie produkty, których nazwa zaczyna się na ‚C’ oraz UnitsInStock > 20
SELECT MAX ([UnitPrice]) AS 'MAX PRICE'
FROM [dbo].[Products]

SELECT MIN ([UnitPrice]) AS 'MIN PRICE'
FROM [dbo].[Products]

SELECT AVG ([UnitPrice]) AS 'AVERAGE PRICE'
FROM [dbo].[Products]

SELECT SUM ([UnitPrice]) AS 'SUM PRICE'
FROM [dbo].[Products]

SELECT COUNT ([Discontinued]) AS 'Discontinued COUNT'
FROM [dbo].[Products]
WHERE [Discontinued] = 1

SELECT	SUM ([UnitPrice]) AS 'SUM PRODUCT WITH CONDITION' 
FROM [dbo].[Products]
WHERE [ProductName] LIKE 'C%' AND [UnitsInStock] > 20

--* Jednym zapytaniem wyznacz:
    --Liczbę dostępnych produktów
    --Średnią cenę
    --Maksymalną cenę
    --Minimalną cenę 
    --Różnicę między maksymalna a minimalną ceną
SELECT 
	COUNT ([UnitsInStock]) AS 'COUNT PRODUCTS In Stock'
	,AVG ([UnitPrice]) AS 'AVERAGE PRICE'
	,MAX ([UnitPrice]) AS 'MAX PRICE'
	,MIN ([UnitPrice]) AS 'MIN PRICE'
	,MAX ([UnitPrice]) - MIN ([UnitPrice]) AS 'DIFFERENCE PRICE'
FROM [dbo].[Products] 

--Napisz zapytanie z INNER JOIN dla tabel Categories i Products
	--Wyświetl kolumny ProductName, CategoryName, Description
SELECT 
	p.[ProductName]
	,c.[CategoryName]
	,c.[Description]
	,p.[UnitPrice]
FROM [dbo].[Categories] AS c
INNER JOIN [dbo].[Products] AS p ON c.CategoryID = p.CategoryID

--Napisz zapytanie z LEFT JOIN dla tabel Categories i Products
   --Wyświetl kolumny ProductName, CategoryName, Description, UnitPrice
   --Wyświetl wyniki tylko dla CategoryName = Seafood
   --Wyniki posortuj po kolumnie ProductName
SELECT 
	p.[ProductName]
	,c.[CategoryName]
	,c.[Description]
	,p.[UnitPrice]
FROM [dbo].[Categories] AS c
RIGHT JOIN [dbo].[Products] AS p ON c.CategoryID = p.CategoryID
WHERE [CategoryName] = 'Seafood'
ORDER BY [ProductName]

--Wyświetl zamówienia wraz z klientami które je złożyli
SELECT 
	o.[OrderID]
	,c.ContactName
FROM [dbo].[Orders] AS o
INNER JOIN [dbo].[Customers] AS c ON o.CustomerID = c.CustomerID

--Wyświetl klientów którzy nie złożyli zamówienia
SELECT 
	c.ContactName
FROM [dbo].[Customers]  AS c
INNER JOIN [dbo].[Orders]  AS o ON c.CustomerID = o.CustomerID
WHERE [OrderID] IS NULL

SELECT [ProductName]
FROM [dbo].[Products]
WHERE [UnitsInStock] IS NOT NULL



SELECT 
	[FirstName] +' ' + [LastName] AS 'Employee NANE'
FROM [dbo].[Employees]
WHERE [LastName] LIKE 'D%'

SELECT 
	[LastName]
	,[FirstName]
	,[Title]
	,[Country]
FROM [dbo].[Employees]
WHERE [Country] = 'USA'

SELECT DISTINCT [Title]
FROM[dbo].[Employees]