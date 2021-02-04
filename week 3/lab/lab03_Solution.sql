-- Q1 List students� ID, first name, last name, and Age of every students who use �Hotmail� internet account

select studentID, firstname, lastname, year(getdate())-year(birthdate) as age
from student 
where charindex('hotmail',Email,1) > 0

-- Q2 List students� full name and Age of all students whose age is older than 20 years old.

select Fullname=firstname+' '+lastname, 
	year(getdate())-year(birthdate) as age
from student
where year(getdate())-year(birthdate) > 20

-- Q3 List students� full name, email address and phone number who did not make the payment yet.

select s.firstname+' '+s.lastname, s.email, s.phone
from student s left join payment p on s.studentid=p.studentid
where p.transactionid is null

-- Q4  List students� ID, ExamID, full name, and examination score for all students.

select s.studentid, e.examid, 
	   Fullname=s.firstname+' '+s.lastname, e.score
from student s inner join practiceexam p 
	on s.studentid=p.studentid
	inner join examscore e on p.examid=e.examid

-- Q5 List  a students� name, and examination score who can earn the highest score.

select top 1 Full_Name=s.firstname+' '+s.lastname, e.score
from student s inner join practiceexam p on s.studentid=p.studentid
	inner join examscore e on p.examid=e.examid
order by e.score desc

-- Q6 Find the instructors' full name who teach for the most expensive course

select top 1 i.Firstname, i.Lastname
from course c inner join instructor i on i.instructorid=c.instructorid
order by courseamount desc

-- Q7 Show the top 5 students' name who enrolled for the course that are most expensive

select top 5 s.firstname, s.lastname, c.coursename, c.courseamount
from student s join enrollcourse e on s.studentid=e.studentid
	join course c on e.courseid=c.courseid
order by c.courseamount desc

-- Q8 Find the courses that are not recorded the ELearning VDO yet
select c.* 
from course c left join elearningvdo e on c.courseid=e.courseid
where e.lesson is null
   