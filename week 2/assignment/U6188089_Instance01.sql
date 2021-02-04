INSERT INTO Student
VALUES (6188089, 'Nattawipa', 'Saetae', 'Bangkok', '2000-07-27', 'nattawipa.sae@student.mahidol.ac.th', '0851153939', 'u6188089', 'nam1'),
		(6188086, 'Kittikorn', 'Keeratikriengkrai', 'Bangkok', '1999-08-27', 'kittikorn.kee@student.mahidol.ac.th', '0961076727', 'u6188086', 'china2'),
		(6188102, 'Kasadin', 'Wisetprasit', 'Bangkok', '2000-04-14', 'kasadin.wis@student.mahidol.ac.th', '0639463871', 'u6188102', 'krit3'),
		(6188066, 'Phakin', 'A-yamaung', 'Bangkok', '1999-03-21', 'phakin.aya@student.mahidol.ac.th', '0982633863', 'u6188066', 'leo4'),
		(6188114, 'Patarapong', 'Jomkhamsri', 'Bangkok', '2000-03-22', 'patarapong.jom@student.mahidol.ac.th', '0967251783', 'u6188114', 'new5'),
		(6188126, 'Naphatr', 'Thaithaweetanakul', 'Bangkok', '2000-02-21', 'napathr.tha@student.mahidol.ac.th', '0909098422', 'u6188126', 'arm6'),
		(6188033, 'Nuttida', 'Napakas', 'Bangkok', '1999-07-11', 'nuttida.nap@student.mahidol.ac.th', '0610131064', 'u6188033', 'donut7'),
		(6188122, 'Ekkawit', 'Sangruengkit', 'Bangkok', '2000-03-19', 'ekkawit.san@student.mahidol.ac.th', '0992265656', 'u6188122', 'bonus8'),
		(6188080, 'Sarun', 'Junbang', 'Bangkok', '1999-11-11', 'sarun.jun@student.mahidol.ac.th', '0829436141', 'u6188080', 'mark9'),
		(6188019, 'Thanawat', 'Riamliw', 'Bangkok', '2000-01-19', 'thanawat.rim@student.mahidol.ac.th', '0985507941', 'u6188066', 'ford10');

INSERT INTO Instructor
VALUES (8888000, 'Preecha', 'Tangworakitthawon', 'Salaya', '1985-01-10', 'preecha.tan@.mahidol.ac.th', '0800000000', 'u8888000', 'ajarn1'),
		(8888001, 'Siripen', 'Pongpaichet', 'Salaya', '1987-02-10', 'siripen.pon@student.mahidol.ac.th', '0811111111', 'u8888001', 'ajarn2'),
		(8888002, 'Jidapa', 'Kraisangka', 'Salaya', '1985-03-10', 'jidapa.kra@mahidol.ac.th', '0822222222', 'u8888002', 'ajarn3'),
		(8888003, 'Pawitra', 'Chairavirakul', 'Salaya', '1987-04-10', 'pawitra.cha@mahidol.ac.th', '0833333333', 'u8888003', 'ajarn4'),
		(8888004, 'Apirak', 'Hoonlor', 'Salaya', '1985-05-10', 'apirak.hoo@mahidol.ac.th', '0844444444', 'u8888004', 'ajarn5'),
		(8888005, 'Akara', 'Supratak', 'Salaya', '1987-06-10', 'akara.sup@mahidol.ac.th', '0855555555', 'u8888005', 'ajarn6'),
		(8888006, 'Damras', 'Wongsawang', 'Salaya', '1985-07-10', 'damras.won@mahidol.ac.th', '0866666666', 'u8888006', 'ajarn7'),
		(8888007, 'Ittipon', 'Rassameeroj', 'Salaya', '1987-08-10', 'ittipon.ras@mahidol.ac.th', '0877777777', 'u8888007', 'ajarn8'),
		(8888008, 'Mores', 'Prahyabrued', 'Salaya', '1985-09-10', 'mores.pra@mahidol.ac.th', '0888888888', 'u8888008', 'ajarn9'),
		(8888009, 'Woraluck', 'Wongse-Ek', 'Salaya', '1987-10-10', 'woraluk.won@mahidol.ac.th', '0899999999', 'u8888009', 'ajarn10'),
		(8888010, 'Mathaneeya', 'Juthapuwadol', 'Bangkok', '1960-11-10', 'mathaneeya.jut@mahidol.ac.th', '0810101010', 'u8888010', 'ajarn10'),
		(8888011, 'Arnon', 'Maskhao', 'Bangkok', '1960-12-10', 'arnon.mas@mahidol.ac.th', '0812111111', 'u8888011', 'ajarn11');


INSERT INTO Student_Transaction 
VALUES (001,74000),
		(002,75000),
		(003,74000),
		(004,75000),
		(005,74000),
		(006,75000),
		(007,74000),
		(008,75000),
		(009,74000),
		(0010,75000);

INSERT INTO Payment
VALUES (6188089,001),
		(6188086,002),
		(6188102,003),
		(6188066,004),
		(6188114,005),
		(6188126,006),
		(6188033,007),
		(6188122,008),
		(6188080,009),
		(6188019,0010);

INSERT INTO Course
VALUES (393,8888000,'Database Systems Lab',1),
		(394,8888001,'Database Systems Lab',1),
		(212,8888002,'Web Programming',3),
		(337,8888003,'Human Computer Interaction',3),
		(498,8888004,'Special Topics in Computer Science',3),
		(499,8888005,'Special Topics in Computer Science',3),
		(461,8888006,'Computer and Communication Security',3),
		(462,8888007,'Computer and Communication Security',3),
		(481,8888008,'Computer Graphic',3),
		(338,8888009,'Human Computer Interaction',3);

INSERT INTO ElearningVideo
VALUES (393, '01', 'Introduction to the DBMS and Installation'),
		(393, '02', 'Database Definition Language (DDL)'),
		(212, '01', 'Introduction to HTML'),
		(337, '01', 'Introduction to HCI'),
		(498, '01', 'Introduction to Computer Science'),
		(498, '02', 'Basic Computer Science concepts'),
		(461, '01', 'Security Overview'),
		(461, '01', 'Symmetric Encryption'),
		(481, '01', 'Introduction to Computer Graphic'),
		(212, '02', 'Create a link to HTML');

INSERT INTO BookStocking
VALUES (120, 393, 'Database Design', 'Michael J. Hernandez', 10, 69.99),
		(121, 393, 'Database Systems', 'Jeffrey Ullman and Jennifer Widom', 15, 79.99),
		(122, 393, 'Database Design Solutions', 'Rod Stephens', 7, 59.99),
		(123, 393, 'SQL Antipatterns', 'Bill Karwin', 3, 79.99),
		(124, 212, 'HTML & CSS: Design and Build Web Sites', 'Jon Duckett', 30, 69.99),
		(125, 461, 'Hacking','Jon Erickson', 21, 49.99),
		(126, 461, 'Security Analysis', 'Warren Buffet', 17, 39.99),
		(127, 337, 'Human-Computer Interaction', 'Janet E. Finlay', 4, 99.99),
		(128, 337, 'Interaction Design', 'Jennifer Preece', 1, 79.99),
		(129, 498, 'Introduction to Algorithms', 'Thomas H. Cormen', 9, 69.99);

INSERT INTO Seat
VALUES (010, 393, 6188089, 'A', 8),
		(015, 212, 6188089, 'B', 9),
		(020, 337, 6188089, 'E', 6),
		(025, 498, 6188089, 'H', 7),
		(030, 461, 6188089, 'A', 8),
		(035, 481, 6188089, 'B', 2),
		(040, 337, 6188086, 'B', 10),
		(045, 498, 6188086, 'C', 2),
		(050, 461, 6188086, 'D', 7),
		(055, 481, 6188086, 'E', 8);

INSERT INTO EnrollCourse
VALUES (6188089,393),
		(6188089,212),
		(6188089,337),
		(6188089,498),
		(6188089,461),
		(6188089,481),
		(6188086,337),
		(6188086,498),
		(6188086,461),
		(6188086,481);

INSERT INTO ExamScore
VALUES (2020, 89.98),
		(2021, 69.45),
		(2022, 89.99),
		(2023, 29.50),
		(2024, 37.26),
		(2025, 93.48),
		(2026, 80.00),
		(2027, 73.90),
		(2028, 0.05),
		(2029, 88.00);

INSERT INTO PracticeExam
VALUES (6188089, 2020),
		(6188086, 2021),
		(6188102, 2022),
		(6188066, 2025),
		(6188114, 2027),
		(6188126, 2029),
		(6188033, 2023),
		(6188122, 2024),
		(6188080, 2025),
		(6188019, 2026);

INSERT INTO CheckAttendance
VALUES (6188089, 1, '2021-01-18', 'Present'),
		(6188089, 1, '2021-01-19', 'Present'),
		(6188089, 1, '2021-01-20', 'Present'),
		(6188089, 1, '2021-01-21', 'Present'),
		(6188089, 1, '2021-01-22', 'Present'),
		(6188089, 2, '2021-01-25', 'Present'),
		(6188089, 2, '2021-01-26', 'Present'),
		(6188086, 1, '2021-01-18', 'Present'),
		(6188086, 1, '2021-01-19', 'Present'),
		(6188086, 1, '2021-01-20', 'Present'),
		(6188086, 1, '2021-01-21', 'Present'),
		(6188086, 1, '2021-01-22', 'Present'),
		(6188086, 2, '2021-01-25', 'Present'),
		(6188086, 2, '2021-01-26', 'Present');