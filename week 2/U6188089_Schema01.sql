CREATE TABLE Student
(
	Student_ID			int				NOT NULL	PRIMARY KEY,
	Student_Firstname	varchar(50)		NOT NULL,
	Student_Lastname	varchar(50)		NOT NULL,
	Student_Address		varchar(100),
	Student_Birthday    date,
	Student_Email		varchar(50)		NOT NULL	DEFAULT '@student.mahidol.ac.th',
	Student_Phone		varchar(10)		NOT NULL,	
	Student_UserID		varchar(10)		NOT NULL,
	Student_Password	varchar(10)		NOT NULL,
);

CREATE TABLE Instructor 
(
	Instructor_ID			int				NOT NULL	PRIMARY KEY,
	Instructor_Firstname	varchar(50)		NOT NULL,
	Instructor_Lastname		varchar(50)		NOT NULL,
	Instructor_Address		varchar(100),
	Instructor_Birthday		date,        
	Instructor_Email		varchar(50)		NOT NULL	DEFAULT '@mahidol.ac.th',
	Instructor_Phone		varchar(10)		NOT NULL,
	Instructor_UserID		varchar(10)		NOT NULL,
	Instructor_Password		varchar(10)		NOT NULL
);

CREATE TABLE Student_Transaction 
(
	Transaction_ID	int		NOT NULL	PRIMARY KEY,
	Amount			int
);

CREATE TABLE Payment
(
	Student_ID		int		FOREIGN KEY REFERENCES Student(Student_ID),
	Transaction_ID	int		FOREIGN KEY REFERENCES Student_Transaction(Transaction_ID)
);

CREATE TABLE Course
(
	Course_ID		int				NOT NULL	PRIMARY KEY,
	Instructor_ID	int				FOREIGN KEY REFERENCES Instructor(Instructor_ID),
	Course_Name		varchar(50),
	Course_Amount	int 
);

CREATE TABLE ElearningVideo
(
	Course_ID	int				FOREIGN KEY REFERENCES Course(Course_ID),
	Lesson		varchar(50),
	Details		varchar(100)
);

CREATE TABLE BookStocking
(
	Book_ID		int				NOT NULL	PRIMARY KEY,
	Course_ID	int				FOREIGN KEY REFERENCES Course(Course_ID),
	BookName	varchar(50),
	Author		varchar(50),
	Remaining	int,
	Price		float
);

CREATE TABLE Seat 
(
	Seat_ID			int				NOT NULL	PRIMARY KEY,
	Course_ID		int				FOREIGN KEY REFERENCES Course(Course_ID),
	Student_ID		int				FOREIGN KEY REFERENCES Student(Student_ID),
	Seat_Row		varchar(10), 
	Seat_Number		int
);

CREATE TABLE EnrollCourse
(
	Student_ID	int		FOREIGN KEY REFERENCES Student(Student_ID),
	Course_ID	int		FOREIGN KEY REFERENCES Course(Course_ID)
);

CREATE TABLE ExamScore
(
	Exam_ID		int		NOT NULL	PRIMARY KEY,
	Score		float
);

CREATE TABLE PracticeExam
(
	Student_ID	int		FOREIGN KEY REFERENCES Student(Student_ID),
	Exam_ID		int		FOREIGN KEY REFERENCES ExamScore(Exam_ID),
);

CREATE TABLE CheckAttendance
(
	Student_ID				int		FOREIGN KEY REFERENCES Student(Student_ID),
	Week_Number				int,
	Attendance_Day			date,
	Attendance_Status		varchar(50)
);


