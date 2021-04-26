/***************************************************************
 * ITCS393 Database Systems Lab (Year 2/2020)
 * Faculty of ICT, Mahidol University 
 * Updated on 20 April 2021
 */

------------------------------------------------------------
-- TOPIC: Database Transaction
------------------------------------------------------------
USE PremierProducts
GO

-- ****************************************************************************************************
-- Lesson 3 & 4: Transaction Begin and End
-- ****************************************************************************************************

-- What is @@TRANCOUNT? --
SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: 0

SELECT TOP 2 CustomerNum, CustomerName 
FROM Customer ORDER BY CustomerName;

SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: 0

-- [Execute this transaction several times and describe what happens]

-- Create a transaction's name TB with "BEGIN TRANSACTION" --   one run time = +1 transaction
BEGIN TRANSACTION TB
    SELECT TOP 2 CustomerNum, CustomerName 
    FROM Customer ORDER BY CustomerName;          

SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: 1, 2, 3, ....

-- [Execute this transaction several times and describe what happens]


-- Introduce "COMMIT"
SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: X

BEGIN TRANSACTION TB
    PRINT 'AFTER BEGIN TRANSACTION ' + CAST(@@TRANCOUNT AS CHAR)
    SELECT TOP 2 CustomerNum, CustomerName 
    FROM Customer ORDER BY CustomerName;
COMMIT TRANSACTION TB
PRINT 'AFTER COMMIT TRANSACTION ' + CAST(@@TRANCOUNT AS CHAR)

SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: X

-- [Describe what happens]
-- [Describe what @@TRANCOUNT is]

-- Introduce "ROLLBACK"
SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: X

BEGIN TRANSACTION TB
    PRINT 'AFTER BEGIN TRANSACTION ' + CAST(@@TRANCOUNT AS CHAR)
    SELECT TOP 2 CustomerNum, CustomerName 
    FROM Customer ORDER BY CustomerName;
ROLLBACK TRANSACTION TB
PRINT 'AFTER ROLLBACK TRANSACTION ' + CAST(@@TRANCOUNT AS CHAR)

SELECT @@TRANCOUNT AmountTransaction;   -- OUTPUT: 0

-- [Describe what happens]

-- ****************************************************************************************************
-- Lesson 5: Table Locking
-- ****************************************************************************************************

-- Transaction with update
BEGIN TRANSACTION TB
    DECLARE @id INT = 995
    INSERT INTO Customer 
    VALUES (@id, 'Mahidol University', 'Phuttamonthon 4 Road', 'Salaya', 'NP', 73170, 6000, 90000, 20);

    SELECT TOP 2 CustomerNum, CustomerName FROM Customer ORDER BY CustomerNum DESC;

    SELECT @@TRANCOUNT AmountTransaction;

-- ** in another query editor window ** run this script
SELECT * FROM Customer;
-- [Describe what happens. Can you see theresult in another query editor?]

-- COMMIT Transaction and go to see the result in another query editor
COMMIT TRANSACTION TB

-- [Try to execute transaction with insert statement, and run select command in another query editor]
BEGIN TRANSACTION TB
    DECLARE @id2 INT = 999
    INSERT INTO Customer 
    VALUES (@id2, 'Mahidol University', 'Phuttamonthon 4 Road', 'Salaya', 'NP', 73170, 6000, 90000, 20);

    SELECT TOP 2 CustomerNum, CustomerName FROM Customer ORDER BY CustomerNum DESC;

-- ROLLBACK Transaction and go to see the result in another query editor
ROLLBACK TRANSACTION TB

-- [Describe what happens. Can you see theresult in another query editor?]

-- ****************************************************************************************************
-- Lesson 6: Try... Catch
-- ****************************************************************************************************

-- Let's try to run this insert statement without TRY CATCH
INSERT INTO Customer
VALUES  (994, 'Mahidol', 'Phuttamonthon 4 Rd', 'Salaya', 'HP', '73170', 6000, 90000, 20),
        (995, 'Mahidol', 'Phuttamonthon 4 Rd', 'Salaya', 'HP', '73170', 6000, 90000, 20),
        (996, 'Mahidol', 'Phuttamonthon 4 Rd', 'Salaya', 'HP', '73170', 6000, 90000, 20)
-- [Decribe what happens.]

-- Using try... catch...
BEGIN TRY
    BEGIN TRANSACTION
        PRINT 'Try to insert three records with customer IDs: 994, 995, and 996'
        INSERT INTO Customer
        VALUES  (994, 'Mahidol', 'Phuttamonthon 4 Rd', 'Salaya', 'HP', '73170', 6000, 90000, 20),
                (995, 'Mahidol', 'Phuttamonthon 4 Rd', 'Salaya', 'HP', '73170', 6000, 90000, 20),
                (996, 'Mahidol', 'Phuttamonthon 4 Rd', 'Salaya', 'HP', '73170', 6000, 90000, 20)
    COMMIT
    PRINT 'Successfully inserted customers'
END TRY
BEGIN CATCH
    PRINT 'Fail to insert customers'
    ROLLBACK
END CATCH

-- see the result
SELECT * FROM Customer;

-- Let's try again with unique customer's ID
BEGIN TRY
    BEGIN TRANSACTION
        PRINT 'Try to insert three records with customer IDs: 997, 998, and 999'
        INSERT INTO Customer
        VALUES  (997, 'MU', 'Phut 4 Rd', 'Salaya', 'HP', '73170', 600, 9000, 20),
                (998, 'MU', 'Phut 4 Rd', 'Salaya', 'HP', '73170', 600, 9000, 20),
                (999, 'MU', 'Phut 4 Rd', 'Salaya', 'HP', '73170', 600, 9000, 20)
    COMMIT
    PRINT 'Successfully inserted customers'
END TRY
BEGIN CATCH
    PRINT 'Fail to insert customers'
    ROLLBACK    
END CATCH

-- see the result
SELECT * FROM Customer;


-- Lab Exercise --
-- Run this script to create BankAccount table for your lab exercise

DROP TABLE IF EXISTS BankAccount;

CREATE TABLE BankAccount (
    AccountNum INT NOT NULL PRIMARY KEY,
    CustomerNum INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerNum),
    AccountBalance MONEY 
)

-- Ex 1: Create 'AddAccounts' transaction to insert 3 records with Try... Catch... --

-- YOUR CODE GOES HERE --

BEGIN TRY
	BEGIN TRANSACTION AddAccounts
		PRINT 'Try to insert 3 records'
		INSERT INTO BankAccount
		VALUES (117, 997, 1000), 
			   (118, 998, 2000), 
			   (119, 999, 500)
	COMMIT
	PRINT 'Successfully inserted customers'
END TRY

BEGIN CATCH
	PRINT 'Fail to insert customers'
	ROLLBACK
END CATCH

SELECT * from BankAccount;

-- Ex 2: Create 'TransferMoney' transaction to transfer money from one account to another account

DECLARE @from INT = 117
DECLARE @to INT = 118
DECLARE @amount MONEY = 550

-- YOUR CODE GOES HERE --

BEGIN TRANSACTION TransferMoney
		
	IF  (SELECT AccountBalance From BankAccount where AccountNum = @from) < @amount
		PRINT 'Not enough money to do a transaction'

	ELSE 
		BEGIN
			UPDATE BankAccount
			SET AccountBalance = AccountBalance - @amount 
			WHERE AccountNum = @from;

			UPDATE BankAccount
			SET AccountBalance = AccountBalance + @amount 
			WHERE AccountNum = @to;
		END
 
COMMIT TRANSACTION TransferMoney;

SELECT * from BankAccount;

--------------------------- HOMEWORK --------------------------- Develop a stored procedure ---------------------------

CREATE PROCEDURE sp_UPDATECustomer 
	@customerNum    INT,
	@customerName	NVARCHAR(255),
	@street			NVARCHAR(255),
	@city			NVARCHAR(100),
	@state			NVARCHAR(30),
	@zip			NVARCHAR(30),
	@balance		MONEY,
	@creditLine		MONEY,
	@repNum			INT
AS
BEGIN
	SET NOCOUNT ON;	 
	BEGIN TRANSACTION
		IF NOT EXISTS (SELECT CustomerNum From Customer where CustomerNum = @customerNum AND Customer.RepNum = @repNum) 
			BEGIN
				PRINT  'The update cannot be done. The transaction will be rolled back'
				ROLLBACK
			END
		ELSE
			BEGIN
				UPDATE Customer
				SET CustomerName = @customerName, Street = @street, City = @city, State = @state, Zip = @zip, Balance = @balance, CreditLine = @creditLine,	RepNum = @repNum
				WHERE CustomerNum = @customerNum
				
				SELECT *           -- to print out an update row
				FROM Customer
				WHERE CustomerNum = @customerNum

				COMMIT TRANSACTION 
				PRINT 'Successfully updated customers'
			END 
END

-- execute 1
EXEC sp_UPDATECustomer
	@customerNum = 997,
	@customerName = 'ICT',
	@street = 'Rama 6',
	@city = 'Phayathai',
	@state = 'BK',
	@zip = '10400',
	@balance = 5000.00,
	@creditLine = 7000.00,
	@repNum = 20

-- execute 2
EXEC sp_UPDATECustomer
	@customerNum = 998,
	@customerName = 'ICT',
	@street = 'Rama 6',
	@city = 'Phayathai',
	@state = 'BK',
	@zip = '10400',
	@balance = 5000.00,
	@creditLine = 7000.00,
	@repNum = 22          --not found rep no.22

-- execute 3
EXEC sp_UPDATECustomer
	@customerNum = 990, -- not found customer no. 990
	@customerName = 'ICT',
	@street = 'Rama 6',
	@city = 'Phayathai',
	@state = 'BK',
	@zip = '10400',
	@balance = 5000.00,
	@creditLine = 7000.00,
	@repNum = 20

	   
--------------------------- HOMEWORK --------------------------- without ROLLBACK version ----------------

DECLARE @cutNum INT = 997
DECLARE @partNum1 NVARCHAR(10) = 'CD52'
DECLARE @qty1 INT = 12 -- purchase quantity
DECLARE @partNum2 NVARCHAR(10) = 'KT03'
DECLARE @qty2 INT = 10 -- purchase quantity

BEGIN TRANSACTION CreateNewOrder

	DECLARE @currentOrderNum INT 
    IF EXISTS (SELECT OrderNum FROM Orders)  
        BEGIN
			SET  @currentOrderNum = (SELECT MAX(OrderNum) from Orders ) +1
        END  

	DECLARE @quotePrice1 MONEY
	BEGIN
		SET  @quotePrice1  = (SELECT Price from Part where PartNum = @partNum1) --not sure quoted price
    END 

	DECLARE @quotePrice2 MONEY
	BEGIN
		SET  @quotePrice2  = (SELECT Price from Part where PartNum = @partNum2) --not sure quoted price
    END 

	INSERT INTO Orders VALUES (@currentOrderNum, GETDATE(), @cutNum)

	INSERT INTO OrderLine VALUES (@currentOrderNum, @partNum1, @qty1, @quotePrice1), 
								 (@currentOrderNum, @partNum2, @qty2, @quotePrice2)
	
	UPDATE Part
	SET OnHand = OnHand - @qty1
	WHERE PartNum = @partNum1
		
	UPDATE Part
	SET OnHand = OnHand - @qty2
	WHERE PartNum = @partNum2

COMMIT TRANSACTION CreateNewOrder

SELECT * FROM Orders
SELECT * FROM OrderLine
SELECT * FROM Part


--------------------------- HOMEWORK --------------------------- with ROLLBACK version ----------------

DECLARE @cutNum INT = 997
DECLARE @partNum1 NVARCHAR(10) = 'CD52'
DECLARE @qty1 INT = 12 -- purchase quantity
DECLARE @partNum2 NVARCHAR(10) = 'KT03'
DECLARE @qty2 INT = 10 -- purchase quantity

BEGIN TRANSACTION CreateNewOrder

	DECLARE @currentOrderNum INT 
    IF EXISTS (SELECT OrderNum FROM Orders)  
        BEGIN
			SET  @currentOrderNum = (SELECT MAX(OrderNum) from Orders ) +1
        END  

	DECLARE @quotePrice1 MONEY
	BEGIN
		SET  @quotePrice1  = (SELECT Price from Part where PartNum = @partNum1) 
    END 

	DECLARE @quotePrice2 MONEY
	BEGIN
		SET  @quotePrice2  = (SELECT Price from Part where PartNum = @partNum2) 
    END 

	IF  (SELECT OnHand From Part where PartNum = @partNum1) < @qty1 OR (SELECT OnHand From Part where PartNum = @partNum2) < @qty2
		BEGIN
			ROLLBACK
			PRINT 'ROLLBACK: failed creating order'
		END
	
	ELSE 
		BEGIN 
			INSERT INTO Orders VALUES (@currentOrderNum, GETDATE(), @cutNum)

			INSERT INTO OrderLine VALUES (@currentOrderNum, @partNum1, @qty1, @quotePrice1),
										 (@currentOrderNum, @partNum2, @qty2, @quotePrice2)
			
			UPDATE Part
			SET OnHand = OnHand - @qty1
			WHERE PartNum = @partNum1
		
			UPDATE Part
			SET OnHand = OnHand - @qty2
			WHERE PartNum = @partNum2

			PRINT 'COMMIT: successfully created order'
			COMMIT TRANSACTION CreateNewOrder
		END

