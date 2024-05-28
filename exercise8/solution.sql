select * from student;
select * from clazz;

--1. tạo view student_shortinfos
create view student_shortinfos as
select student_id, first_name, last_name, gender, dob, clazz_id
from student;

--1.1. hiện thị toàn bộ bản ghi của vew student_shortinfos
select * from student_shortinfos;

--1.2. thử insert 1 bản ghi	 vào trong view student_shortinfos
insert into student_shortinfos
values('20215014', 'Dinh Dung', 'Tran', 'M', '2003-10-26', '20162101');
--bản ghi này có được insert vào bảng student! -> view có thể cập nhật

--xóa bản ghi
delete from student_shortinfos where student_id = '20215014';
--bản ghi này được xóa khỏi bảng student

--1.3.a. được truy cập view student_shortinfos và bảng clazz
--hiển thị danh sách sinh viên: student_id, fullname, gender và class name.
select student_id, last_name || ' ' || first_name as fullname, gender, c.name as class_name
from student_shortinfos s, clazz c
where s.clazz_id = c.clazz_id;

--1.3.b hiển thị danh sách lớp (class id, class name) và số sinh viên mỗi lớp
select c.clazz_id, c.name, count(s.student_id)
from student_shortinfos s right join clazz c using (clazz_id)
group by c.clazz_id;

--1.4. sửa trường address trong bảng student thành NOT NULL
alter table student alter column address set NOT NULL;

--thử insert bản ghi mới vào student_shortinfos 
insert into student_shortinfos
values('20215014', 'Dinh Dung', 'Tran', 'M', '2003-10-26', '20162101');
--LỖI: vì bản ghi mới thiếu địa chỉ

--1.5. thử thay đổi dob của một sinh viên và kiểm tra xem 
--nó có được cập nhật trên view student_shortinfos 
update student set dob = '1991-02-12'
where student_id = '20160001';

select * from student_shortinfos;
-- -> có được cập nhật

--1.6. insert 1 bản ghi mới vào bảng table và kiểm tra xem 
--bạn có thể thấy bản ghi mới này trong view student_shortinfos không
insert into student 
values ('20201000', 'Khanh', 'Nguyen Nam', '1990-02-24', 'M', 'Hai Ba Trung, HN');

select * from student_shortinfos;
select * from student;
-- -> có được cập nhật

--3. tạo một view trong eduDB, đặt tên là class_infos, 
--bao gồm: class_id, class name, number of students trong lớp này
create view class_infos as
select c.clazz_id, c.name, count(student_id) as number_of_students
from student s right join clazz c using (clazz_id) 
group by c.clazz_id;

--3.1. hiện thị toàn bộ bản ghi trong view
select * from class_infos;

--3.2. thử insert/update/delete một bản ghi trong view class_infos
--thử insert
insert into class_infos values ('20200001', 'CSDL', 0);
--thu update
update class_infos set name = 'Thuc Hanh CSDL' where clazz_id = '20170000';
--thu delete
delete from class_infos where clazz_id = '20170000';

--Ở đây ta thấy trong view class_infos có chứa các mệnh đề như: GROUP BY, COUNT.
-- -> đây là khung nhìn không thể cập nhật được
-- nên các thao tác như insert/update/delete ko thể thực hiện được
