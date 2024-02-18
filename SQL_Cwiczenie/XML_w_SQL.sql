SELECT CustomerId, City
FROM [dbo].[Customers]
FOR XML RAW

SELECT CustomerID, City
FROM [dbo].[Customers]
FOR XML RAW, ELEMENTS

SELECT c.CustomerID
		,c.City
		,o.OrderDate
		,od.UnitPrice
FROM [dbo].[Customers] AS c
JOIN [dbo].[Orders] AS o ON c.CustomerID = o.CustomerID
JOIN [dbo].[Order Details] AS od ON o.OrderID = od.OrderID
FOR XML RAW ('Customer'), ROOT ('root'), ELEMENTS

SELECT CustomerID
		,City
FROM Customers
FOR XML AUTO

SELECT CustomerID
		,City
FROM [dbo].[Customers]
FOR XML AUTO, ROOT('ROOT'), ELEMENTS

SELECT Customer.CustomerID
		,Customer.City
		,Orders.OrderDate
		,Order_Details.Quantity
		,Order_Details.UnitPrice
FROM [dbo].[Customers] AS Customer
JOIN [dbo].[Orders] as Orders ON Customer.CustomerID = Orders.CustomerID
JOIN [dbo].[Order Details] AS Order_Details ON Orders.OrderID = Order_Details.OrderID
FOR XML AUTO, ROOT('root'), ELEMENTS


-- Odczytanie całego XML’a (wszystkich obiektów)
DECLARE @xmldata XML
SELECT @xmldata = BulkColumn
FROM OPENROWSET (Bulk 'D:\XML_F.xml', SINGLE_BLOB) AS x
SELECT 
    Customer.element.value('CustomerID[1]', 'nvarchar(5)') as CustomerID,
    Customer.element.value('City[1]', 'nvarchar(15)') as City,
    Orders.element.value('OrderDate[1]', 'datetime') as OrderDate,
    OrderDetail.element.value('Quantity[1]', 'smallint') as Quantity,
    OrderDetail.element.value('UnitPrice[1]', 'money') as UnitPrice
FROM @xmldata.nodes('/root/Customer') AS Customer(element)
CROSS APPLY @xmldata.nodes('/root/Customer/Orders') AS Orders(element)
CROSS APPLY @xmldata.nodes('/root/Customer/Orders/Order_Details') AS OrderDetail(element)


DECLARE @xmldata1 XML
SELECT @xmldata1 = BulkColumn
FROM OPENROWSET (Bulk 'D:\XML_F5.xml', SINGLE_BLOB) AS x
SELECT 
    Customer.element.value('CustomerID[1]', 'nvarchar(5)') as CustomerID,
    Customer.element.value('City[1]', 'nvarchar(15)') as City
FROM @xmldata1.nodes('/ROOT/dbo.Customers') AS Customer(element)

-- Odczytanie pierwszego elementu
DECLARE @xmldata2 XML
SELECT @xmldata2 = BulkColumn
FROM OPENROWSET (Bulk 'D:\XML_F5.xml', SINGLE_BLOB) AS x
SELECT @xmldata2.query('/ROOT/dbo.Customers[1]') AS QUERY

-- Odszukanie elmentów gdzie CustomerID = DRACD
DECLARE @xmldata3 XML
SELECT @xmldata3 = BulkColumn
FROM OPENROWSET (Bulk 'D:\XML_F5.xml', SINGLE_BLOB) AS x
SELECT @xmldata3.query('/ROOT/dbo.Customer[CustomerID = DRACD]') AS Customer
