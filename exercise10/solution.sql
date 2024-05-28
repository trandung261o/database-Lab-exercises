select * from student

--1. cho một classID, viết một hàm tên là "number_of_students" 
--dùng để tính toán số sinh viên trong lớp này
CREATE OR REPLACE FUNCTION number_of_students(IN classID char(8), OUT result integer)
AS $$
BEGIN 
	SELECT INTO result COUNT(student_id)
	FROM student s
	WHERE s.clazz_id = classID;
END; $$
LANGUAGE plpgsql
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY INVOKER;

--test
select number_of_students('20162101');
select * from clazz;
--2.thêm thuộc tính mới (named: number_students, datatype: integer) 
--vào bảng clazz để lưu số sinh viên trong lớp
ALTER TABLE clazz ADD number_students integer;

--viết một hàm (update_number_students()) dùng để tính toán số sinh viên 
--mỗi lớp và cập nhật giá trị đúng vào thuộc tính number_students

--ver1:
CREATE OR REPLACE FUNCTION update_number_students() RETURNS void AS
$$DECLARE i char(8);
BEGIN
	FOR i IN(SELECT clazz_id FROM clazz) LOOP
		UPDATE clazz SET number_students = number_of_students(i) WHERE clazz_id = i;
	END LOOP;
END$$
LANGUAGE plpgsql;

--ver2:
CREATE OR REPLACE FUNCTION update_number_students() RETURNS void AS
$$BEGIN
	UPDATE clazz SET number_students = number_of_students(clazz.clazz_id);
END$$
LANGUAGE plpgsql;

--kiểm tra giá trị của thuộc tính này trước và sau 
--khi gọi hàm update_number_students()
UPDATE clazz SET number_students = 0;
SELECT * FROM clazz;
SELECT update_number_students();
SELECT * FROM clazz;

