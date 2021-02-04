USE Assignment_01;


--Q1
SELECT Student.Student_Firstname AS Student_Name, COUNT (Student.Student_ID) AS Number_Of_Course
FROM EnrollCourse 
INNER JOIN Student ON EnrollCourse.Student_ID = Student.Student_ID
GROUP BY Student.Student_Firstname
HAVING COUNT(Student.Student_ID) > 1;


--Q2
SELECT Student.Student_Firstname AS Student_Name
FROM Student_Transaction
INNER JOIN Payment ON Student_Transaction.Transaction_ID = Payment.Transaction_ID
INNER JOIN Student ON Payment.Student_ID = Student.Student_ID 
WHERE Student_Transaction.Amount > 50000
GROUP BY Student.Student_Firstname;


--Q3 
SELECT Student.Student_FirstName AS Student_Name
FROM Student 
INNER JOIN PracticeExam ON Student.Student_ID = PracticeExam.Student_ID
INNER JOIN ExamScore ON PracticeExam.Exam_ID = ExamScore.Exam_ID
WHERE ExamScore.Score > (SELECT AVG(Score)
FROM ExamScore)
GROUP BY Student.Student_FirstName, ExamScore.Score;


--Q4
SELECT CONCAT(Instructor.Instructor_Firstname, ' ', Instructor.Instructor_Lastname) AS Instructor_Fullname, COUNT (Course.Instructor_ID) AS Number_Of_Course
FROM Course
RIGHT JOIN Instructor ON Course.Instructor_ID = Instructor.Instructor_ID
GROUP BY Instructor.Instructor_Firstname, Instructor.Instructor_Lastname
HAVING COUNT(Course.Instructor_ID) = 0;


--Q5 
SELECT Student.Student_FirstName, Course.Course_Name, (SELECT SUM(BookStocking.Price)
FROM BookStocking 
WHERE Student.Student_ID = EnrollCourse.Student_ID and EnrollCourse.Course_ID = Course.Course_ID and Course.Course_ID = BookStocking.Course_ID)
FROM Student 
INNER JOIN EnrollCourse ON Student.Student_ID = EnrollCourse.Student_ID
INNER JOIN Course ON Course.Course_ID = EnrollCourse.Course_ID


--Q6 : Show instructor ID, firstname, lastname of every students who use ''mahidol'' account.
SELECT Instructor_ID, Instructor_FirstName, Instructor_LastName
FROM Instructor
WHERE Instructor_Email LIKE '%mahidol%'


--Q7 : Show instructor fullname and age whose age is younger than 35 years old.
SELECT CONCAT(Instructor.Instructor_Firstname, ' ', Instructor.Instructor_Lastname) AS Instructor_Fullname, 2021-YEAR(Instructor_Birthday) AS AGE
FROM Instructor
WHERE 2021-YEAR(Instructor_Birthday) < 35;


--Q8 : Show instructor firstname, email, and phone number whose age is older than 35 years old.
SELECT Instructor_Firstname, Instructor_Lastname, 2021-YEAR(Instructor_Birthday) AS AGE, Instructor_Email, Instructor_Phone  
FROM Instructor
WHERE 2021-YEAR(Instructor_Birthday) > 35;
 

--Q9 : Show all students fullname, address, and phone nunmber who got the summarized examination score less than the average score of all students.
SELECT CONCAT(Student.Student_FirstName, ' ', Student.Student_Lastname) AS Student_Fullname, Student.Student_Address, Student.Student_Phone
FROM Student 
INNER JOIN PracticeExam ON Student.Student_ID = PracticeExam.Student_ID
INNER JOIN ExamScore ON PracticeExam.Exam_ID = ExamScore.Exam_ID
WHERE ExamScore.Score < (SELECT AVG(Score)
FROM ExamScore)
GROUP BY Student.Student_FirstName, Student.Student_Lastname, Student.Student_Address, Student.Student_Phone, ExamScore.Score;


--Q10 : Show the courses name that are already recorded an E-Learning video.
SELECT Course.Course_Name, COUNT (Course.Course_ID) AS Number_Of_VIDEO
FROM Course
INNER JOIN ElearningVideo ON Course.Course_ID = ElearningVideo.Course_ID
GROUP BY Course.Course_Name
HAVING COUNT (Course.Course_ID) != 0;


