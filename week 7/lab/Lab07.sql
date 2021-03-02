-- Q1 Write a query that returns OrderNum and Customer's name (Using both APPLY and JOIN operator)

-- Q1 using APPLY operator

SELECT OrderNum, C.CustomerName
FROM Orders
CROSS APPLY
(
	SELECT CustomerName
	FROM Customer
	WHERE Customer.CustomerNum = Orders.CustomerNum
) AS C

-- Q1 using JOIN operator

SELECT OrderNum, Customer.CustomerName 
FROM Orders
INNER JOIN Customer ON Customer.CustomerNum = Orders.CustomerNum

-- Q2 Write a query to select all customer information with OrderNum (Using APPLY operator)

SELECT *
FROM Customer
OUTER APPLY
(
	SELECT OrderNum
	FROM Orders
	WHERE Orders.CustomerNum = Customer.CustomerNum 
) AS O

-- Q3 List all Order Number of the CustomerNumber greater than 400 that appear in OrderLine (except the Order Number 21617) using SET operation

SELECT OrderNum FROM Orders
GROUP BY Orders.OrderNum, Orders.CustomerNum
HAVING Orders.CustomerNum > 400
EXCEPT
SELECT OrderNum FROM OrderLine
WHERE OrderNum = 21617






