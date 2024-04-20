-- Tạo bảng Student
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(50)
);

-- Insert dữ liệu vào bảng Student
INSERT INTO Student (StudentID, Name, Address)
VALUES
    (1108, 'Robert', 'Kew'),
    (3936, 'Glen', 'Bundoora'),
    (8507, 'Norman', 'Bundoora'),
	(2610, 'Osborn', 'Bundoora'),
	(3389, 'Monkey', 'Bundoora'),
    (8452, 'Mary', 'Balwyn');

-- Tạo bảng Takes
CREATE TABLE Takes (
    StudentID INT,
    SubjectCode INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Insert dữ liệu vào bảng Takes
INSERT INTO Takes (StudentID, SubjectCode)
VALUES
    (1108, 21),
    (1108, 23),
    (8507, 23),
    (8507, 29);

-- Tạo bảng Enrol
CREATE TABLE Enrol (
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Insert dữ liệu vào bảng Enrol
INSERT INTO Enrol (StudentID, CourseID)
VALUES
    (3936, 101),
    (1108, 113),
    (8507, 101);

-- Tạo bảng Course
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    Name VARCHAR(50),
    Faculty VARCHAR(50)
);

-- Insert dữ liệu vào bảng Course
INSERT INTO Course (CourseID, Name, Faculty)
VALUES
    (113, 'BCS', 'CSCE'),
    (101, 'MCS', 'CSCE');

-- Tạo bảng Subject
CREATE TABLE Subject (
    SubjectCode INT PRIMARY KEY,
    Name VARCHAR(50),
    Faculty VARCHAR(50)
);

-- Insert dữ liệu vào bảng Subject
INSERT INTO Subject (SubjectCode, Name, Faculty)
VALUES
    (21, 'Systems', 'CSCE'),
    (23, 'Database', 'CSCE'),
    (29, 'VB', 'CSCE'),
    (18, 'Algebra', 'Maths');



--tìm thông tin từ cột Name của bảng Student
SELECT Name from Student;

--tìm thông tin của các sinh viên có địa chỉ ở 'Bundoora'
SELECT * from Student
WHERE Address = 'Bundoora';

--đưa ra danh sách tên các khoa (Faculty) tương ứng với các khóa học (Course). Mỗi giá trị chỉ hiển thị một lần
SELECT DISTINCT Faculty FROM Course;

--đưa ra danh sách mã sinh viên (StudentID), tên sinh viên (Name), thành phố (Address), mã khóa học (CourseID)
SELECT Student.StudentID, Student.Name, Address, CourseID
FROM Student, Enrol
WHERE Student.StudentID = Enrol.StudentID;

--đưa ra danh sách tên các sinh viên theo thứ tự tăng dần
SELECT Name FROM Student
ORDER BY Name ASC

--đưa ra tên các SV nhóm theo thành phố của SV đó
SELECT Address, Name
FROM Student
GROUP BY Address, Name

--đưa ra tên các thành phố có nhiều hơn 3 SV
SELECT Address, COUNT(StudentID)
FROM Student
GROUP BY Address HAVING COUNT(StudentID) > 3


--đưa ra danh sách tên các môn học không có SV nào tham dự
SELECT DISTINCT Subject.Name FROM Subject
EXCEPT
SELECT DISTINCT Subject.Name FROM Student, Takes, Subject
WHERE Student.StudentID = Takes.StudentID AND Takes.SubjectCode = Subject.SubjectCode;

--chèn thông tin vào bảng
INSERT INTO Student VALUES ('1179', 'Jane', 'Califonia');

INSERT INTO Student(StudentID, Name, Address) VALUES
('1180', 'David', 'NewYork');

--xóa bản ghi trong bảng
DELETE FROM Student
WHERE Address = 'Indiana';


--xóa bảng
DROP TABLE Student
DROP TABLE Course
DROP TABLE Enrol
DROP TABLE Subject
DROP TABLE Takes


-- hiện thị bảng
SELECT * from Course
SELECT * from Enrol
SELECT * from Student
SELECT * from Subject
SELECT * from Takes
