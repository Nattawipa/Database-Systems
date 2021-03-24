-- Q1 Find all parts with a price greater than or equal to average parts price.

SELECT *
FROM [PremierProducts].[dbo].[Part]
WHERE Part.Price >= (
						SELECT AVG(Part.Price) AS Avg_Price
						FROM [PremierProducts].[dbo].[Part]
					)

-- Q2 Write a query to find the names of all customer who made an order before '2010-10-22'

SELECT Customer.CustomerName
FROM [PremierProducts].[dbo].[Customer]
WHERE Customer.CustomerName IN (
									SELECT Customer.CustomerName
									FROM [PremierProducts].[dbo].[Customer]
									JOIN [PremierProducts].[dbo].[Orders] ON Orders.CustomerNum = Customer.CustomerNum
									WHERE Orders.OrderDate < '2010-10-22'
								)

-- Q3 Write a query to find the names of the customer who were contacted by Representaive name Valerie Kaiser.

SELECT Customer.CustomerName
FROM [PremierProducts].[dbo].[Customer]
WHERE Customer.CustomerName IN (
									SELECT Customer.CustomerName
									FROM [PremierProducts].[dbo].[Customer]
									JOIN [PremierProducts].[dbo].[Rep] ON Rep.RepNum = Customer.RepNum
									WHERE Rep.FirstName = 'Valerie' AND Rep.LastName = 'Kaiser'
								)

-- Q4 Write a query to find the names and the balance of the customer who have a higher balance than the customer whose Name = 'Brookings Direct'.

SELECT Customer.CustomerName, Customer.Balance
FROM [PremierProducts].[dbo].[Customer]
WHERE Customer.Balance > (
							 SELECT Customer.Balance
							 FROM [PremierProducts].[dbo].[Customer]
							 WHERE Customer.CustomerName = 'Brookings Direct'
					      )