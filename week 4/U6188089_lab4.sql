--Q1
SELECT COUNT (Student_Address) AS Who_Live_in_BKK
FROM Student
where CharIndex('Bangkok',[Student_Address]) > 0

--Q2
SELECT COUNT (*) AS Summer_child
FROM Student
WHERE MONTH(Student_Birthday) BETWEEN 4 and 7

--Q3
SELECT COUNT (Course.Instructor_ID) AS Cnt_Courses, Instructor_name = Instructor.Instructor_Firstname +' '+ Instructor.Instructor_Lastname
FROM Course
INNER JOIN Instructor ON Instructor.Instructor_ID = Course.Instructor_ID
GROUP BY Instructor.Instructor_Firstname, Instructor.Instructor_Lastname

--Q4
 SELECT AVG (ExamScore.Score) AS Avg_Score, Course.Course_Name AS CourseName
 FROM Course
 INNER JOIN EnrollCourse ON EnrollCourse.Course_ID = Course.Course_ID
 INNER JOIN Student ON Student.Student_ID = EnrollCourse.Student_ID
 INNER JOIN PracticeExam ON PracticeExam.Student_ID = Student.Student_ID
 INNER JOIN ExamScore ON ExamScore.Exam_ID = PracticeExam.Exam_ID
 GROUP BY Course.Course_Name

--Q5
SELECT SUM (Student_Transaction.Amount) AS Tot_Amount, Student.Student_ID AS StudentID, fullname = Student.Student_Firstname +' '+ Student.Student_Lastname
FROM Student_Transaction
INNER JOIN Payment ON Payment.Transaction_ID = Student_Transaction.Transaction_ID
INNER JOIN Student ON Student.Student_ID = Payment.Student_ID
GROUP BY Student.Student_Firstname, Student.Student_Lastname, Student.Student_ID