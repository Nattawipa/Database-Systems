use AdventureWorks2014
/*  Student Name__Nattawipa Saetae_________________________ ID__6188089_____*/

/*  Q1 Write a query that returns BusinessEntityID, LastName, NationalIDNumber, and JobTitle of all Person.
	[Table: Person, Employee]
 */
-- Your Solution is here!
SELECT HumanResources.Employee.BusinessEntityID, Person.LastName, HumanResources.Employee.NationalIDNumber, HumanResources.Employee.JobTitle
FROM HumanResources.Employee
JOIN Person.Person ON Employee.BusinessEntityID = Person.BusinessEntityID


 
/*	Q2 Write a query that returns FirstName, LastName and CreditCardID of Person who have credit cards. 
	[Table: Person, PersonCreditCard]	
*/
-- Your Solution is here!
SELECT Person.FirstName, Person.LastName, Sales.PersonCreditCard.CreditCardID
FROM Person.Person
JOIN Sales.PersonCreditCard ON  Person.BusinessEntityID = Sales.PersonCreditCard.BusinessEntityID
WHERE Sales.PersonCreditCard.CreditCardID IS NOT NULL



/*	Q3 Write a query that returns Name, LogInID and DepartmentName of Employee who were assigned the department and  loginID.
     [Table: Person, Employee, Department, EmployeeDepartmentHistory]
	*/
-- Your Solution is here! 
SELECT Name = Person.FirstName +' '+ Person.LastName, HumanResources.Employee.LoginID, HumanResources.Department.Name AS Department_Name
FROM Person.Person
JOIN HumanResources.Employee ON Employee.BusinessEntityID = Person.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory ON Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID
JOIN HumanResources.Department ON EmployeeDepartmentHistory.DepartmentID = Department.DepartmentID


/*	Q4 Write a query that returns one column called Result and contains the last name of the employee with NationalIDNumber 112457891.
    [Table: Person, Employee]
*/ 
-- Your Solution is here!
SELECT CONCAT(Person.Person.LastName,' ',HumanResources.Employee.NationalIDNumber) AS Result
FROM Person.Person
JOIN HumanResources.Employee ON Employee.BusinessEntityID = Person.BusinessEntityID
WHERE HumanResources.Employee.NationalIDNumber = '112457891'