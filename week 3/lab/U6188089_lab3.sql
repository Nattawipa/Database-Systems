SELECT Student_ID, Student_FirstName, Student_LastName, 2021-YEAR(Student_Birthday) AS AGE
FROM Student
WHERE Student_Email LIKE '%mahidol%'


SELECT Student_Firstname, Student_Lastname, 2021-YEAR(Student_Birthday) AS AGE
FROM Student
WHERE 2021-YEAR(Student_Birthday) > 20;


SELECT CONCAT(Student.Student_Firstname, ' ', Student.Student_Lastname) AS Fullname, Student.Student_Email, Student.Student_Phone
FROM Student 
LEFT JOIN Payment ON Student.Student_ID = Payment.Student_ID
WHERE Payment.Transaction_ID IS NULL;


SELECT Student.Student_ID, PracticeExam.Exam_ID, CONCAT(Student.Student_Firstname, ' ', Student.Student_Lastname) AS Fullname, ExamScore.Score
FROM Student 
INNER JOIN PracticeExam ON Student.Student_ID = PracticeExam.Student_ID 
RIGHT JOIN ExamScore ON PracticeExam.Exam_ID = ExamScore.Exam_ID


SELECT TOP 1 CONCAT(Student.Student_Firstname, ' ', Student.Student_Lastname) AS Fullname, ExamScore.Score
FROM Student 
JOIN PracticeExam ON Student.Student_ID = PracticeExam.Student_ID
JOIN ExamScore ON PracticeExam.Exam_ID = ExamScore.Exam_ID
ORDER BY ExamScore.Score DESC;


SELECT TOP 1 Instructor.Instructor_FirstName, Instructor.Instructor_LastName, Course.Course_Amount
FROM Instructor 
RIGHT JOIN Course ON Instructor.Instructor_ID = Course.Instructor_ID
ORDER BY Course.Course_Amount DESC;


SELECT TOP 5 Student.Student_Firstname
FROM Student 
JOIN EnrollCourse ON  Student.Student_ID = EnrollCourse.Student_ID
RIGHT JOIN  Course ON Course.Course_ID = EnrollCourse.Course_ID
ORDER BY Course.Course_Amount DESC;


SELECT Course.Course_Name, COUNT (Course.Course_ID) AS Number_Of_VIDEO
FROM Course
INNER JOIN ElearningVideo ON Course.Course_ID = ElearningVideo.Course_ID
GROUP BY Course.Course_Name
HAVING COUNT (Course.Course_ID) = 0;