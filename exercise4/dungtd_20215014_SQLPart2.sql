	--11. Students aged 25 and above. Given information: student name, age
SELECT last_name || ' ' || first_name AS student_name, EXTRACT('year' FROM age(dob)) AS age 
FROM student 
WHERE EXTRACT('year' FROM age(dob)) >= 25;

--11b. number of subjects that student whose ID is '20160001' studied
SELECT student_id, COUNT(DISTINCT subject_id) AS number_of_subjects FROM enrollment
WHERE student_id = '20160001'
GROUP BY student_id;

--12.students were born in October 1988
SELECT student.student_id, last_name || ' ' || first_name AS name FROM student
WHERE extract('year' FROM dob) = 1988 AND extract('month' FROM dob) = 10;

--13. Display class name and number of students corresponding in each class. 
--Sort the result in descending order by the number of students
SELECT clazz.name, COUNT(student.student_id) AS number_of_students
FROM clazz LEFT JOIN student ON clazz.clazz_id = student.clazz_id
GROUP BY clazz.name
ORDER BY number_of_students DESC;

--14. display the lowest, highest and average scores on the mid-term test of "Mạng máy tính" in semester 20172
SELECT min(enrollment.midterm_score) AS min,
	   max(enrollment.midterm_score) AS max,
	   avg(enrollment.midterm_score) AS avg
FROM enrollment INNER JOIN subject ON subject.subject_id = enrollment.subject_id
WHERE subject.name = 'Mạng máy tính' AND semester = '20172';

--15. give number of subjects that each lecturer can teach. List must contain: lecturer id, lecturer's full name
--number of subjests

--16. List of subjects which have at least 2 lecturers in charge
SELECT teaching.subject_id, COUNT(teaching.lecturer_id) AS number_of_lecturers FROM teaching
GROUP BY teaching.subject_id HAVING COUNT(teaching.lecturer_id) >= 2
ORDER BY COUNT(teaching.lecturer_id) DESC;


--17. list of subjects which have less than 2 lecturer in charge
SELECT subject.subject_id, subject.name, COUNT(teaching.lecturer_id) AS number_of_lecturers
FROM subject LEFT JOIN teaching USING(subject_id)
GROUP BY subject_id HAVING COUNT(teaching.lecturer_id) < 2;

--18. list of students who obtained the highest score in subjects whose id is 'IT3080', in the semester 20172
