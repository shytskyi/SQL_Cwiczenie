
WITH NEW_CTE AS 
(
	SELECT *
	FROM [dbo].[Customers] AS c
	JOIN [dbo].[Orders] AS o ON c.CustomerID = o.CustomerID
)
SELECT * FROM NEW_CTE;

WITH SIMPLECTE AS 
(
	SELECT [CompanyName], [Address]
	FROM [dbo].[Customers]
)
SELECT * FROM SIMPLECTE;

WITH CTE2 (NAME, ID) AS 
(
	SELECT [ContactName], [CustomerID]
	FROM [dbo].[Customers]
)
SELECT * FROM CTE2;

WITH CTE01 (NAME, ID) AS
	(
		SELECT [CompanyName], [CustomerID]
		FROM [dbo].[Customers]
	),
	CTE02 AS
	(
		SELECT [OrderID], [CustomerID]
		FROM [dbo].[Orders]
	)
SELECT * 
FROM CTE01 AS one JOIN CTE02 AS two ON one.ID = two.CustomerID

WITH CTE01 (NAME, ID) AS
	(
		SELECT [CompanyName], [CustomerID]
		FROM [dbo].[Customers]
	),
	CTE02 AS
	(
		SELECT [OrderID], [CustomerID]
		FROM [dbo].[Orders]
	)
SELECT * FROM CTE02; 

--CTE INSERT

IF OBJECT_ID ('TEST_TABLE','U') IS NULL
BEGIN
	CREATE TABLE TEST_TABLE 
	(
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		NAME NVARCHAR(40) NOT NULL,
		PHONE NVARCHAR(24),
		SHIPERSID INT NOT NULL 
	)
END
GO

WITH CTE_INSERT AS
(
	SELECT *
	FROM [dbo].[Shippers] AS s
	WHERE s.CompanyName LIKE '%a%'
)
INSERT INTO TEST_TABLE
SELECT [CompanyName], [Phone], [ShipperID] FROM CTE_INSERT;

SELECT * 
FROM [dbo].[TEST_TABLE];

--DROP TABLE TEST_TABLE

WITH CTE_UPDATE AS
	(
		SELECT *
		FROM [dbo].[TEST_TABLE]
		WHERE [ID] = 1
	)
UPDATE CTE_UPDATE
SET [PHONE] = '(222) 333-1944';

WITH CTE_DELETE AS
	(
		SELECT *
		FROM [dbo].[TEST_TABLE]
		WHERE [PHONE] = '(333) 985-2211'
	)
DELETE FROM CTE_DELETE;



--ZADANIA

--Napisz zapytanie z wykorzystaniem CTE, które wyświetli CompanyName, CustomerId, z tabeli Customers
WITH CTE_ZDENIA1 AS
(
	SELECT [CompanyName], [CustomerID]
	FROM [dbo].[Customers]
)
SELECT * FROM CTE_ZDENIA1;

--Z wykorzystaniem CTE napisz zapytanie, które wyświetli wszystkie zamówienia (Orders) wraz z informacją o kliencie (Customers)
WITH CTE_ZADANIA2_1 AS
	(
		SELECT [OrderID], [CustomerID]
		FROM [dbo].[Orders]
	),
	CTE_ZADANIA2_2 AS
	(
		SELECT 	[CompanyName], [Address], [City], [Country], [CustomerID]
		FROM [dbo].[Customers]
	)
SELECT * FROM  CTE_ZADANIA2_1 AS cte1 
JOIN CTE_ZADANIA2_2 AS cte2 ON cte1.CustomerID = cte2.CustomerID

--Napisz zapytanie, którego wynikiem będzie join pomiędzy 2 CTE
--a.Pierwsze CTE ma pobrać Customers, kórych Country =’France’
--b.Drugie CTE ma pobrać Orders, których ShipCountry = ‘France’
WITH CTE_ZADANIA_3_1 AS 
	(
		SELECT *
		FROM [dbo].[Customers]
		WHERE [Country] = 'France'
	),
	CTE_ZADANIA_3_2 AS 
	(
		SELECT *
		FROM [dbo].[Orders]
		WHERE [ShipCountry] = 'France'
	)
SELECT *
FROM CTE_ZADANIA_3_1 AS c 
JOIN CTE_ZADANIA_3_2 AS o ON c.CustomerID = o.CustomerID;
 
--Napisz zapytanie z wykorzystaniem 2 CTE:
--a.Pierwsze CTE ma pobrać zamówienia (Orders) które ShipCountry = ‘France’ 
--b.Drugie CTE ma pobrać z pierwszego CTE tylko takie wiersze, których fracht (Freight) > 20
--c.Jako wynik wyświetl CustomerId, ShipCountry, Freight
WITH CTE_ZADANIA4_1 AS
	(
		SELECT * 
		FROM [dbo].[Orders]
		WHERE [ShipCountry] = 'USA'
	),
	CTE_ZADANIA4_2 AS
	(
		SELECT *
		FROM CTE_ZADANIA4_1
		WHERE [Freight] > 20
	)
SELECT [CustomerID], [ShipCountry], [Freight]
FROM CTE_ZADANIA4_2
ORDER BY [Freight] DESC

--Napisz polecenie INSERT z wykorzystaniem CTE, które wiersze do tabeli TestTable.
--a.Tabela TestTable   ma posiadać kolumny CustomerId, Freight, ShipCountry
--b.Polecenie ma wstawić takie wiersze Freight < 1 i ShipCountry = ‘Germany’
ALTER TABLE [dbo].[TEST_TABLE]
ADD 
	CustomerId NCHAR(5),
	Freight MONEY,
	ShipCountry NVARCHAR(15)

ALTER TABLE [dbo].[TEST_TABLE]
DROP COLUMN [NAME], [PHONE], [SHIPERSID]

SELECT *
FROM [dbo].[TEST_TABLE];

WITH CTE_ZADANIA5_1 AS 
	(
		SELECT [CustomerID], [Freight], [ShipCountry]
		FROM [dbo].[Orders]
		WHERE [Freight] < 1 
	)
INSERT INTO [dbo].[TEST_TABLE]
SELECT * FROM CTE_ZADANIA5_1;

--Napisz polecenie UPDATE z wykorzystaniem CTE
--a.Polecenie ma zmienić ShipCountry na ‘Mexico’ w tabeli TestTable pod warunkiem, że CustomerId zaczyna się na literę ‘K’
WITH CTE_ZADANIA6_1 AS
	(
		SELECT [ShipCountry]
		FROM [dbo].[TEST_TABLE]
		WHERE [CustomerId] LIKE 'K%'
	)
UPDATE CTE_ZADANIA6_1
SET [ShipCountry] = 'Mexico';

--Napisz polecenie DELETE z wykorzystaniem CTE
--a.Polecenie ma usunąć wiersze z tabeli TestTable pod warunkiem, że ShipCountry = ‘Germany’
WITH CTE_ZADANIE7_1 AS
	(
		SELECT *
		FROM [dbo].[TEST_TABLE]
		WHERE [CustomerId] IS NULL
	)
DELETE FROM CTE_ZADANIE7_1;

--Napisz zapytanie, które zwróci w jednym wierszu Maksymalną i Minimalną wartość pojedynczego zamówienia.
WITH CTE_ZADANIA_8 AS
(
    SELECT [OrderID]
    , MIN([Freight]) OVER (PARTITION BY [OrderID]) AS MINIMALNE
    , MAX([Freight]) OVER (PARTITION BY [OrderID]) AS MAXYMALNE 
    FROM [dbo].[Orders] 
)
SELECT DISTINCT [OrderID], MINIMALNE, MAXYMALNE
FROM CTE_ZADANIA_8
ORDER BY [OrderID];

SELECT  CustomerID, COUNT(CustomerID) AS Ilosc_zamowien FROM Orders GROUP BY CustomerID;

--Policz Ile średnio zamówień złożyli klienci
WITH CTE_ZADANIA_9 AS
	(
	  SELECT  CustomerID, COUNT(CustomerID) AS Ilosc_zamowien FROM Orders 
	  GROUP BY CustomerID	
	),
	--select AVG(Ilosc_zamowien) AS [SREDNIA ILOSC ZAMOWIEN] From CTE_ZADANIA_9
	CTE_ZADANIA_9_1 AS
	(
	Select o.CustomerID,  avg(Freight) as avge 
	From Orders o	
	group by o.CustomerID	
	)
	 select c1.CustomerID, c1.Ilosc_zamowien, c2.avge From CTE_ZADANIA_9 c1
	 join CTE_ZADANIA_9_1 c2 on c1.CustomerID=c2.CustomerID;

--Policz, ile średnio zamówień złożyli klienci w roku 1997
WITH CTE_ZADANIA_10 AS
	(
	  SELECT YEAR([OrderDate]) AS Year1, CustomerID, COUNT(CustomerID) AS Ilosc_zamowien FROM Orders 
	  GROUP BY CustomerID, [OrderDate]
	)
select AVG(Ilosc_zamowien) AS [SREDNIA ILOSC ZAMOWIEN w 1997] 
From CTE_ZADANIA_10
where Year1 = '1997'