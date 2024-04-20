--1. List of subjects having 5 or more credits
SELECT * FROM subject WHERE credit >= 5;

--2. List of students in the class named "CNTT1.01-K61"
--c1: nối bảng
SELECT student.student_id, (last_name || '' || first_name) AS name 
FROM student, clazz WHERE student.clazz_id = clazz.clazz_id AND clazz.name = 'CNTT1.01-K61';

--c2: dùng join ... on
SELECT student.student_id, last_name || ' ' || first_name AS name
FROM student JOIN clazz ON student.clazz_id = clazz.clazz_id
WHERE clazz.name = 'CNTT1.01-K61';

--c3: dùng in(...)
SELECT student.student_id, last_name || ' ' || first_name AS name
FROM student WHERE student.clazz_id IN (SELECT clazz_id FROM clazz WHERE clazz.name = 'CNTT1.01-K61');


--3. List of students in classes whose name contains "CNTT"
--C1:
SELECT student.student_id, (last_name || ' ' || first_name) AS name 
FROM student, clazz WHERE student.clazz_id = clazz.clazz_id AND clazz.name LIKE '%CNTT%'

--C2:
SELECT student.student_id, student.last_name || ' ' || student.first_name
FROM student JOIN clazz ON student.clazz_id = clazz.clazz_id
WHERE clazz.name LIKE '%CNTT%';

--C3:
SELECT student.student_id, last_name || ' ' || first_name
FROM student WHERE clazz_id IN (SELECT clazz_id FROM clazz WHERE clazz.name LIKE '%CNTT%');

--4. Display a list of students who have enrolled in both "Tin học đại cương" and "Cơ sở dữ liệu" 
--c1:
SELECT student.student_id, last_name || ' ' || first_name AS name
FROM student, subject, enrollment WHERE student.student_id = enrollment.student_id AND subject.subject_id = enrollment.subject_id
AND subject.name = 'Cơ sở dữ liệu'
INTERSECT
SELECT student.student_id, last_name || ' ' || first_name AS name
FROM student, subject, enrollment WHERE student.student_id = enrollment.student_id AND subject.subject_id = enrollment.subject_id
AND subject.name = 'Tin học đại cương'

--c2:
SELECT student.student_id, last_name || ' ' || first_name AS name 
FROM student WHERE student_id IN 
(
SELECT student_id FROM enrollment WHERE subject_id IN
	(SELECT subject_id FROM subject WHERE name = 'Cơ sở dữ liệu')
INTERSECT
SELECT student_id FROM enrollment WHERE subject_id IN
	(SELECT subject_id FROM subject WHERE name = 'Tin học đại cương')
);


--5. Display a list of students who have enrolled in "Cơ sở dữ liệu" or "Tin học đại cương"
--c1:
SELECT DISTINCT student.student_id, last_name || ' ' || first_name AS name
FROM student, subject, enrollment
WHERE student.student_id = enrollment.student_id AND subject.subject_id = enrollment.subject_id
AND subject.name = 'Tin học đại cương' OR subject.name = 'Cơ sở dữ liệu'

--c2:
SELECT student.student_id, last_name || ' ' || first_name AS name
FROM student WHERE student_id IN
(SELECT student_id FROM enrollment WHERE subject_id IN
	(SELECT subject_id FROM subject WHERE name = 'Cơ sở dữ liệu' OR name = 'Tin học đại cương'));

--6. Display subjects that have never been registered by any students
SELECT * FROM subject WHERE subject_id NOT IN 
	(SELECT DISTINCT subject_id FROM enrollment)

--7. List of subjects (subject name and credit number corresponding) that student "Nguyễn Hoài An" have enrolled in the semester '20171'
SELECT name, credit FROM subject WHERE subject_id IN 
	(SELECT subject_id FROM enrollment WHERE semester = '20171' AND student_id IN
		(SELECT student_id FROM student WHERE first_name = 'Hoài An' AND last_name = 'Nguyễn'));
