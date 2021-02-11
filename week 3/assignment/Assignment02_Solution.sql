--Q1 Show all students' name who enrolled more than 1 course
Select		s.firstname+' '+s.lastname as StdName, 
			COUNT(courseID) as CntCourse
From		Enrollcourse e 
			Inner JOIN Student s on e.studentid=s.studentid
Group by	s.firstname+' '+s.lastname
having		COUNT(courseID) > 1


--Q2 Show all students' name who paid the payment costed higher than 50,000.00
Select		s.firstname+' '+s.lastname as StdName, 
			sum(t.amount) as CntAmount
From		Student s 
			Inner JOIN Payment p on s.studentid=p.studentid
			Inner join [transaction] t on p.TransactionID=t.transactionid
Group by	s.firstname+' '+s.lastname
Having		sum(t.amount) > 50000


/* Q3 Show all students' name who got the summarized score 
more than the average score of all students
*/
Select		s.firstname+' '+s.lastname as StdName, 
			sum(e.score) as SumScore
From		Student s 
			Inner join PracticeExam p on s.studentid=p.studentid
			Inner join Examscore e on p.examID=e.examid
Group by	s.firstname+' '+s.lastname
Having		sum(e.score) > (Select avg(score) From Examscore)

 
/* Q4 Show all instructors' full name who didn't teach any courses 
*/
Select		i.Firstname+' '+i.Lastname as [Full name]
From		Instructor i 
			Left join course c on i.instructorID=c.instructorID
Where		c.courseID is null			-- Use "is null" instead of "= null"!


/* Q5

Mr.A is a student who enrolls for a course named "B", 
show how much money he must pay for all books provided in this course.
(you can change the name of this student and course according to your data )
*/
Select		b.price, b.bookname,  
			s.firstname+' '+s.lastname as [student name]
From		Student s 
			Inner join Enrollcourse e on s.studentid=e.studentid
			Inner join Course c on e.courseID=c.courseID
			Inner join bookstocking b on c.courseID=b.courseID  
Where		s.studentid='u0001' and coursename='Introduction to database'
