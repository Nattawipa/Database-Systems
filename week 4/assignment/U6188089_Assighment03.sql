--Q1
SELECT Course.Course_Name, COUNT (ElearningVideo.Course_ID) AS VDO_Records
FROM ElearningVideo
INNER JOIN Course ON Course.Course_ID = ElearningVideo.Course_ID
GROUP BY Course.Course_Name

--Q2
SELECT Instructor_Fullname = Instructor.Instructor_Firstname +' '+ Instructor.Instructor_Lastname, COUNT (Course.Instructor_ID) AS Total_Courses
FROM Course
INNER JOIN Instructor ON Instructor.Instructor_ID = Course.Instructor_ID
GROUP BY Instructor.Instructor_Firstname, Instructor.Instructor_Lastname

--Q3
SELECT Instructor_Fullname = Instructor.Instructor_Firstname +' '+ Instructor.Instructor_Lastname, AVG (Course.Course_Amount) AS Average_Amount
FROM Instructor
INNER JOIN Course ON Course.Instructor_ID = Instructor.Instructor_ID
WHERE Course.Course_Amount > 50000
GROUP BY Instructor.Instructor_Firstname, Instructor.Instructor_Lastname

--Q4
SELECT TOP 1 Student_Fullname = Student.Student_Firstname +' '+ Student.Student_Lastname, MAX (Course.Course_Amount) AS Average_Amount
FROM Course
INNER JOIN EnrollCourse ON EnrollCourse.Course_ID = Course.Course_ID
INNER JOIN Student ON Student.Student_ID = EnrollCourse.Student_ID
GROUP BY Student.Student_Firstname, Student.Student_Lastname
ORDER BY MAX (Course.Course_Amount) DESC

--Q5
SELECT AVG (ExamScore.Score) AS Average_Score, MAX (ExamScore.Score) AS Maximum_Score, MIN (ExamScore.Score) AS Minimum_Score, Student_Fullname = Student.Student_Firstname +' '+ Student.Student_Lastname
FROM ExamScore
INNER JOIN PracticeExam ON PracticeExam.Exam_ID = ExamScore.Exam_ID
INNER JOIN Student ON Student.Student_ID = PracticeExam.Student_ID
GROUP BY Student.Student_Firstname, Student.Student_Lastname
