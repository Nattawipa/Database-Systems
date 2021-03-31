/***************************************************************
 * ITCS393 Database Systems Lab (Year 2/2020)
 * Faculty of ICT, Mahidol University 
 * Updated on 30 March 2021
 */

/***************************************************************
 * STEP 0
 * Create PremierProduct11 database by 
 * executing PremierProduct11.sql to load data into the database
 */


/***************************************************************
 * Working with VIEWS
 *
 */
USE PremierProduct11

-- Q1 --
CREATE VIEW Housewares AS
SELECT PartNum, Description, OnHand, Price
FROM Part
WHERE Class = 'HW';

SELECT * FROM Housewares

-- Q1.1 --
CREATE VIEW SalesRepCust (SNum, SLast, SFirst, CNum) AS
SELECT Rep.RepNum, LastName, FirstName, CustomerNum
FROM Rep, Customer
WHERE Rep.RepNum = Customer.RepNum;

-- Q1.2 --
CREATE VIEW RepAvgBalance AS
SELECT RepNum, COUNT(*) AS NumCustomers, AVG(Balance) AS AvgBalance
FROM Customer
GROUP BY RepNum;

-- Q2 --
DROP VIEW Housewares;

-- Q3 --
-- If you drop view using Q2 script, you have to run Q1 to create view again
SELECT * FROM Housewares;

-- Q4 --
SELECT PartNum, Description, OnHand, Price
FROM Part
WHERE Class = 'HW'

-- Q5 --
SELECT * FROM Housewares 
WHERE OnHand < 25;

-- Q6 --
/** YOUR CODE GOES HERE **/
SELECT PartNum, Description, OnHand, Price
FROM Part
WHERE Class = 'HW' AND OnHand < 25;

-- Q7 --
UPDATE Housewares
SET Price = 229.90
WHERE PartNum = 'DL71';

SELECT PartNum, Description, OnHand, Price
FROM Part

-- Q8 --
/** YOUR CODE GOES HERE **/
UPDATE Part
SET Price = 229.90
WHERE PartNum = 'DL71';

-- Join Data from multiple tables --
SELECT RepNum, LastName, FirstName FROM Rep;

SELECT CustomerNum, RepNum FROM Customer;

SELECT Rep.RepNum , LastName, FirstName, CustomerNum
FROM Rep, Customer
WHERE Rep.RepNum = Customer.RepNum;

-- Q9 --
CREATE VIEW SalesCust (SNum, SLast, SFirst, CNum) 
AS
SELECT Rep.RepNum, LastName, FirstName, CustomerNum
FROM Rep, Customer
WHERE Rep.RepNum = Customer.RepNum;

SELECT * FROM SalesCust;

-- Q10 --
SELECT SNum, SLast, SFirst
FROM SalesCust
WHERE CNum = '282';

-- Q11 --
/** YOUR CODE GOES HERE **/
SELECT Rep.RepNum AS SNum, LastName AS SLast, FirstName AS SFirst
FROM Rep, Customer
WHERE Rep.RepNum = Customer.RepNum
AND CustomerNum = '282'

-- Q12 --
UPDATE SalesCust 
SET SLast = 'AAA'
WHERE CNum = '282';

-- review updated data
SELECT SNum, SLast, SFirst
FROM SalesCust
WHERE CNum = '282';

-- Q13 -- INVALID FK
UPDATE SalesCust 
SET SNum = '70'
WHERE CNum = '282';

-- Q14 --
CREATE VIEW CustCountPerRep AS
SELECT RepNum, COUNT(*) AS NumCustomers
FROM Customer
GROUP BY RepNum;

-- Q15 --
SELECT * 
FROM CustCountPerRep;

-- Q16 --
UPDATE CustCountPerRep 
SET RepNum = 10;

-- Q17 --
ALTER VIEW Housewares AS
SELECT PartNum, Description, OnHand, Price
FROM Part
WHERE Class = 'HW' AND OnHand < 25;

-- review data from the modified view
SELECT * FROM Housewares;

-- Q18 --
EXEC sp_helptext Housewares;
EXEC sp_helptext SalesCust;
EXEC sp_helptext CustCountPerRep;

/********************************** * Working with INDEX * **********************************/
  
 -- LAB Page 24
CREATE VIEW vwCustomerRep 
AS
SELECT CustomerNum, CustomerName, Customer.Zip AS Zip, Rep.FirstName AS RepFName, Rep.LastName AS RepLName
FROM Rep, Customer
WHERE Rep.RepNum = Customer.RepNum;

SELECT * FROM vwCustomerRep

-- LAB Page 25
ALTER VIEW vwCustomerRep 
AS
SELECT CustomerNum, CustomerName, Customer.Zip AS Zip, Rep.FirstName AS RepFName, Rep.LastName AS RepLName, Commission, Rate
FROM Rep, Customer
WHERE Rep.RepNum = Customer.RepNum;

SELECT * FROM vwCustomerRep

-- LAB Page 26
CREATE VIEW vwTotalOrder_Customer 
AS 
SELECT Customer.CustomerNum, CustomerName, COUNT(*) AS totalOrders
FROM Customer
INNER JOIN Orders ON Orders.CustomerNum = Customer.CustomerNum
GROUP BY Customer.CustomerNum, CustomerName, Orders.CustomerNum

SELECT * FROM vwTotalOrder_Customer

/********************************** * Working with INDEX * **********************************/

-- See execution plan of the following queries
SELECT * FROM OrderLine;

SELECT * FROM Orders;

SELECT OrderNum FROM Orders WHERE OrderNum = 21619;

SELECT CustomerNum FROM Orders WHERE CustomerNum = 282;


-- Create a DataStore Table
CREATE TABLE DataStore (
Run INT IDENTITY(1,1) NOT NULL,
KeyID INT NOT NULL,
AccountDesc NVARCHAR(50),
AccountType NVARCHAR(50),
CodeAltKey INT
);

-- Create a DataStore_IDX Table
CREATE TABLE DataStore_IDX (
Run INT IDENTITY(1,1) NOT NULL,
KeyID INT NOT NULL,
AccountDesc NVARCHAR(50),
AccountType NVARCHAR(50),
CodeAltKey INT
);

-- ////////////////////////////////////////////////////////////////////////////////
-- Generate LARGE data and insert into the DataStore and DataStore_IDX table
-- This may take several minutes
DECLARE @loop INT;
DECLARE @keyID INT, @Description NVARCHAR(50), @Type NVARCHAR(50), @CodeAltKey INT;

SELECT @loop = 0
BEGIN TRAN
WHILE (@loop < 2700000)
BEGIN

-- set value to column --
SELECT @KeyID = CAST(RAND()*10000000 as int);
SELECT @Description = 'accountdesc' + CONVERT(varchar(20), @KeyID);
SELECT @Type = 'AccountType' + CONVERT(varchar(20), @KeyID);
SELECT @CodeAltKey = CAST(RAND()*10000000 as int);

-- insert column into tables
INSERT INTO [DataStore] VALUES (@KeyID, @Description, @Type, @CodeAltKey);
INSERT INTO [DataStore_IDX] VALUES (@KeyID, @Description, @Type, @CodeAltKey);

-- increment loop
SELECT @loop = @loop + 1;
END
COMMIT

-- End generate LARGE data into tables
-- ////////////////////////////////////////////////////////////////////////////////

-- Q1 --
CREATE INDEX idx_target_keyID ON DataStore_IDX (KeyID);

-- Q2 --
CREATE CLUSTERED INDEX idx_target_run ON DataStore_IDX (Run);

-- Q3 --
DROP INDEX idx_target_keyID on DataStore_IDX

-- Q4 --
SELECT * FROM DataStore

-- Q5 --
SELECT * FROM DataStore_IDX

-- Q6 --
SELECT * FROM DataStore 
WHERE Run = 255

-- Q7 --
SELECT run FROM DataStore_IDX 
WHERE Run = 255


-- Q8 --
/** YOUR CODE GOES HERE **/
CREATE VIEW vw_datastore
AS
SELECT KeyID, AccountDesc, AccountType
FROM DataStore
WHERE KeyID > 5000000;

SELECT * FROM vw_datastore;

-- Q9 --
/** YOUR CODE GOES HERE **/
CREATE VIEW vw_datastore_idx
AS
SELECT KeyID, AccountDesc, AccountType
FROM DataStore
WHERE KeyID > 5000000;

SELECT * FROM vw_datastore_idx;

/********************************** * Homework Assignment * **********************************/

--  Create a new view named " vwTotalPaidBillofCustomer"

CREATE VIEW vwTotalPaidBillofCustomer 
AS
SELECT TableA.CustomerNum, TableA.CustomerName, TableA.Zip, TableA.RepFName, TableA.RepLName,
	   CONVERT(DECIMAL(10,4),SUM (TableA.TotalPaid)) AS TotalPaid
FROM (
		SELECT Customer.CustomerNum, Customer.CustomerName, Customer.Zip AS Zip, Rep.FirstName AS RepFName, 
			   Rep.LastName AS RepLName, SUM (OrderLine.QuotedPrice * OrderLine.NumOrdered) AS TotalPaid
		FROM Orders
		INNER JOIN Customer ON Customer.CustomerNum = Orders.CustomerNum
		INNER JOIN OrderLine ON OrderLine.OrderNum = Orders.OrderNum
		INNER JOIN Rep ON Rep.RepNum = Customer.RepNum
		GROUP BY Customer.CustomerNum, Customer.CustomerName, Customer.Zip, Rep.FirstName , Rep.LastName 
	) AS TableA
GROUP BY TableA.CustomerNum, TableA.CustomerName, TableA.Zip, TableA.RepFName, TableA.RepLName
HAVING SUM (TableA.TotalPaid) > 1000

SELECT * FROM vwTotalPaidBillofCustomer 

-- Alter the view named " vwTotalPaidBillofCustomer

ALTER VIEW vwTotalPaidBillofCustomer 
AS
SELECT TableA.CustomerNum, TableA.CustomerName, TableA.Zip, TableA.RepFName, TableA.RepLName, TableA.No_Order,
	   CONVERT(DECIMAL(10,4),SUM (TableA.TotalPaid)) AS TotalPaid
FROM (
		SELECT Customer.CustomerNum, Customer.CustomerName, Customer.Zip AS Zip, Rep.FirstName AS RepFName, 
			   Rep.LastName AS RepLName, COUNT(CustomerName) AS No_Order, SUM (OrderLine.QuotedPrice * OrderLine.NumOrdered) AS TotalPaid
		FROM Orders
		INNER JOIN Customer ON Customer.CustomerNum = Orders.CustomerNum
		INNER JOIN OrderLine ON OrderLine.OrderNum = Orders.OrderNum
		INNER JOIN Rep ON Rep.RepNum = Customer.RepNum
		GROUP BY Customer.CustomerNum, Customer.CustomerName, Customer.Zip, Rep.FirstName , Rep.LastName 
	) AS TableA
GROUP BY TableA.CustomerNum, TableA.CustomerName, TableA.Zip, TableA.RepFName, TableA.RepLName, TableA.No_Order
HAVING SUM (TableA.TotalPaid) > 1000

SELECT * FROM vwTotalPaidBillofCustomer 

/*********** Create two tables from given quey ***********/

   -- table 1 
SELECT KeyID INTO SmallDataKey
FROM DataStore_IDX
WHERE KeyID < 500;

   -- table 2
SELECT KeyID INTO LargeDataKey
FROM DataStore_IDX
WHERE KeyID > 500000;

-- compare the execution times and execution plans between running the following queries 

-- 1. SELECT the records which KeyID larger than 5000000

	-- DataStore
SELECT KeyID 
FROM DataStore
WHERE KeyID > 5000000;

	-- DataStore_IDX
SELECT KeyID 
FROM DataStore_IDX
WHERE KeyID > 500000;

-- 2. SELECT the records which KeyID larger than 5000000 but show only KeyID, AccountDesc and AccountType attributes

	-- DataStore
SELECT KeyID, AccountDesc, AccountType
FROM DataStore
WHERE KeyID > 5000000;
	
	-- DataStore_IDX
SELECT KeyID, AccountDesc, AccountType
FROM DataStore_IDX
WHERE KeyID > 5000000;

-- 3. INNER JOIN with the SmallDataKey table on KeyID and shows SmallDataKey.KeyID and AccountDesc (from DataSotre or from DataStore_IDX)
	
	-- DataStore
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore
INNER JOIN SmallDataKey ON DataStore.KeyID = SmallDataKey.KeyID
	
	-- DataStore_IDX
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore_IDX
INNER JOIN SmallDataKey ON DataStore_IDX.KeyID = SmallDataKey.KeyID

-- 4. INNER JOIN with the LargeDataKey table on KeyID and shows LargeDataKey.KeyID and AccountDesc (from DataSotre or from DataStore_IDX)

	-- DataStore
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore
INNER JOIN LargeDataKey ON DataStore.KeyID = LargeDataKey.KeyID
	
	-- DataStore_IDX
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore_IDX
INNER JOIN LargeDataKey ON DataStore_IDX.KeyID = LargeDataKey.KeyID

-- 5. How about LEFT JOIN, RIGHT JOIN and OUTER JOIN? (optional)

/********************** LEFT JOIN **********************/
-- SmallDataKey

	-- DataStore     
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore
LEFT JOIN  SmallDataKey ON DataStore.KeyID = SmallDataKey.KeyID
	
	-- DataStore_IDX    
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore_IDX
LEFT JOIN  SmallDataKey ON DataStore_IDX.KeyID = SmallDataKey.KeyID

-- LargeDataKey

	-- DataStore
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore
LEFT JOIN LargeDataKey ON DataStore.KeyID = LargeDataKey.KeyID
	
	-- DataStore_IDX
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore_IDX
LEFT JOIN LargeDataKey ON DataStore_IDX.KeyID = LargeDataKey.KeyID

/********************** RIGHT JOIN **********************/
-- SmallDataKey

	-- DataStore     
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore
RIGHT JOIN  SmallDataKey ON DataStore.KeyID = SmallDataKey.KeyID
	
	-- DataStore_IDX    
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore_IDX
RIGHT JOIN  SmallDataKey ON DataStore_IDX.KeyID = SmallDataKey.KeyID

-- LargeDataKey

	-- DataStore
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore
RIGHT JOIN LargeDataKey ON DataStore.KeyID = LargeDataKey.KeyID
	
	-- DataStore_IDX
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore_IDX
RIGHT JOIN LargeDataKey ON DataStore_IDX.KeyID = LargeDataKey.KeyID

/********************** OUTER JOIN **********************/
-- SmallDataKey 

	-- DataStore     
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore
FULL OUTER JOIN  SmallDataKey ON DataStore.KeyID = SmallDataKey.KeyID
	
	-- DataStore_IDX    
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore_IDX
FULL OUTER JOIN  SmallDataKey ON DataStore_IDX.KeyID = SmallDataKey.KeyID

-- LargeDataKey 

	-- DataStore
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore
FULL OUTER JOIN LargeDataKey ON DataStore.KeyID = LargeDataKey.KeyID
	
	-- DataStore_IDX
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore_IDX
FULL OUTER JOIN LargeDataKey ON DataStore_IDX.KeyID = LargeDataKey.KeyID

/********************************** * Homework Assignment * **********************************/













