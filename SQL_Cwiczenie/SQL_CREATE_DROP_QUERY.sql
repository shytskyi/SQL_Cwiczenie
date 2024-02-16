SELECT *
FROM Employees

INSERT INTO Employees
	(
		 LastName
		, FirstName
		, Title
		, TitleOfCourtesy
		, BirthDate
		, HireDate
		, Address
		, City
		, Region
		, PostalCode
		, Country
		, HomePhone
		, Extension
		, Notes
	)
VALUES 
	(
		'SHYTSKYI'
		, 'IVAN'
		, 'DEVELOPER'
		, 'MR'
		, 01-01-1900
		, 2024-02-21
		, 'POCHYLA'
		, 'WROCLAW'
		, 'PL'
		, '53-512'
		, 'POLAND'
		, '(48) 777111888'
		, '1'
		, 'EDUCATION IN UKRAINE
		, IFNTUNG'
	)

INSERT INTO Employees
	(
		 LastName
		, FirstName
		, Title
		, TitleOfCourtesy
		, BirthDate
		, HireDate
		, Address
		, City
		, Region
		, PostalCode
		, Country
		, HomePhone
		, Extension
		, Notes
	)
VALUES 
	(
		'KOWAL'
		, 'IVAN'
		, 'DEVELOPER'
		, 'MR'
		, 01-01-1900
		, 2024-02-21
		, 'POCHYLA'
		, 'KRAKOW'
		, 'PL'
		, '53-512'
		, 'POLAND'
		, '(48) 777111888'
		, '1'
		, 'EDUCATION IN UKRAINE
		, IFNTUNG'
	)

UPDATE [dbo].[Employees]
SET 
	BirthDate = '1900-01-01'
	,[HireDate] = '2024-02-21'
	,[Region] = 'EU'
	,[HomePhone] = '(48) 797211884'
WHERE [LastName] = 'SHYTSKYI' AND [FirstName] = 'IVAN' 

DELETE FROM [dbo].[Employees]
WHERE [LastName] = 'SHYTSKYI' AND [FirstName] = 'IVAN' 

SELECT *
FROM [dbo].[Customers]

INSERT INTO Customers
	(
		[CustomerID]
		,[CompanyName]
		,[Address]
		,[City]
		,[Country]
	)
VALUES 
	(
		'CID'
		,'MICROSOFT'
		,'STREET 1'
		,'NEW YORK'
		,'USA'
	)

UPDATE [dbo].[Customers]
SET [ContactName] = 'ALICE COOPER', [ContactTitle] = 'CTO'
WHERE [CustomerID] = 'CID'

UPDATE [dbo].[Customers]
SET [Phone] = '900100200'
WHERE [ContactName] = 'ALICE COOPER'

DELETE FROM [dbo].[Customers]
WHERE [CustomerID] = 'CID'

SELECT *
FROM [dbo].[Orders]
WHERE [CustomerID] = 'TORTU'

INSERT INTO [dbo].[Orders]
	(
		CustomerID 
		, EmployeeID 
		, OrderDate 
		, RequiredDate
		, ShippedDate 
	)
VALUES
	(
		'TORTU'
		,9
		,'2024-01-20'
		,'2024-01-21'
		,'2024-01-25'
	)

UPDATE [dbo].[Orders]
SET [Freight] = 100.58
WHERE [CustomerID] = 'TORTU' AND [EmployeeID] = 9

UPDATE [dbo].[Orders]
SET [ShipCity] = 'WROCLAW', [ShipAddress] = 'LOGISTYCZNA 8'
WHERE [CustomerID] = 'TORTU' AND [EmployeeID] = 9

UPDATE [dbo].[Orders]
SET [ShipCountry] = 'POLAND'
WHERE [CustomerID] = 'TORTU' AND [EmployeeID] = 9

INSERT INTO [dbo].[Orders]
	(
		[CustomerID]
		,[OrderDate]
		,[RequiredDate]
		,[ShippedDate]
		,[Freight]
	)
VALUES 
	(
		'TORTU'
		,'2024-01-01'
		,'2024-02-10'
		,'2024-02-11'
		,238.49
	)

UPDATE [dbo].[Orders]
SET [EmployeeID] = 9, [ShipCountry] = 'USA', [ShipCity] = 'LA'
WHERE [CustomerID] = 'TORTU' AND [ShippedDate] = '2024-02-11'

DELETE FROM [dbo].[Orders]
WHERE [OrderID] = 11080 






IF OBJECT_ID ('MY_TABLE','U') IS NULL
BEGIN
	CREATE TABLE MY_TABLE
		(
			ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			NAME VARCHAR(50) UNIQUE NOT NULL,
			AGE INT,
			CITY VARCHAR (255) DEFAULT 'WROCLAW',
			TYPEID INT FOREIGN KEY REFERENCES TYPES1(ID)
		)
END
GO

IF OBJECT_ID ('TYPES1','U') IS NULL
BEGIN
	CREATE TABLE TYPES1
		(
			ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			TYPE VARCHAR(50) UNIQUE NOT NULL,
		)
END
GO

SELECT *
FROM MY_TABLE

SELECT *
FROM TYPES1

INSERT INTO [dbo].[MY_TABLE]
	(
		[NAME]
		,[AGE]
		,[CITY]
	)
VALUES 
	(
		'NVIDIA'
		,38
		,'TEXAS'
	)

DELETE FROM [dbo].[MY_TABLE]
WHERE [CITY] = 'TEXAS'

INSERT INTO  [dbo].[TYPES1]
	(TYPE)
VALUES('WOOD')

INSERT INTO [dbo].[MY_TABLE]
	(NAME,TYPESID)
VALUES('MICROSOFT',2)

DROP TABLE [dbo].[MY_TABLE]

IF OBJECT_ID ('MY_TABLE', 'U') IS NULL
BEGIN
	CREATE TABLE MY_TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		NAME VARCHAR(255) UNIQUE,
		TYPESID INT FOREIGN KEY REFERENCES TYPES1(ID)
	)
END
GO

SELECT *
FROM [dbo].[MY_TABLE]

IF OBJECT_ID ('NEW_TABLE', 'U') IS NULL
BEGIN 
	CREATE TABLE NEW_TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		PRODECT VARCHAR(50) UNIQUE NOT NULL
	)
END
GO

IF OBJECT_ID('MUSHROOMS', 'U') IS NULL
BEGIN
	CREATE TABLE MUSHROOMS
	(
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		NAME VARCHAR UNIQUE DEFAULT 'MICELIJ'
	)
END
GO

IF OBJECT_ID ('MY', 'U') IS NULL
BEGIN
	CREATE TABLE MY
	(
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		NAME VARCHAR(255) UNIQUE NOT NULL,
		COUNT INT DEFAULT 0,
		MID INT FOREIGN KEY REFERENCES MUSHROOMS(ID)
	)
END
GO

DROP TABLE [dbo].[MY_TABLE]

DROP TABLE [dbo].[TYPES1]

DROP TABLE [dbo].[NEW_TABLE]

DROP TABLE [dbo].[MUSHROOMS]

IF OBJECT_ID('NEW_TABLE', 'U') IS NULL
BEGIN
	CREATE TABLE NEW_TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		NAME VARCHAR(50) UNIQUE,
		AGE INT,
		ADRESS VARCHAR(100),
		COUNT_NUM INT DEFAULT 0
	)
END
GO

SELECT *
FROM NEW_TABLE

INSERT INTO NEW_TABLE
	(NAME, AGE, ADRESS)
 VALUES
	('BUS', 22, 'SREET 1'),
	('CAR', 3, 'LEO 4')

UPDATE NEW_TABLE
SET COUNT_NUM = 3
WHERE ID = 1

INSERT INTO NEW_TABLE
	(NAME)
VALUES
	('E-BIKE')

DELETE FROM NEW_TABLE
WHERE NAME = 'E-BIKE'

ALTER TABLE NEW_TABLE
ADD 
	NEW_COLUMN VARCHAR(50),
	NEW_OLD_COLUM VARCHAR(50)

ALTER TABLE NEW_TABLE
DROP COLUMN NEW_OLD_COLUM 