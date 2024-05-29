--định nghĩa trigger function
create or replace function tf_demo_beforetrigger() returns trigger as
$$begin
	raise notice 'before trigger được kích hoạt';
	-- xu ly
	--...
	--return
	return new; -- lệnh insert/update được thực thi
	--return NULL; --lệnh insert/update/delete sẽ bị hủy
end;$$
language plpgsql;


--định nghĩa trigger
create or replace trigger tg_bf_clazz
before insert on clazz
for each row 
--định nghĩa mức hàng: mỗi khi một hàng được insert vào bảng clazz 
--thì gọi trigger 1 lần
--bỏ qua when do ko có điều kiện gì cả
execute procedure tf_demo_beforetrigger();
--thực thi trigger function tf_demo_beforetrigger()

--test
insert into clazz(clazz_id, name) values ('20211220', NULL);
select * from clazz;
insert into clazz(clazz_id, name) values ('20211220', 'demo trigger');
insert into clazz(clazz_id, name) values ('20211221', 'demo return NULL');


-------------------
--định nghĩa AFTER trigger function
create or replace function tf_demo_aftertrigger() returns trigger as
$$begin
	raise notice 'after trigger được kích hoạt';
	-- xu ly
	--...
	--return
	--return new; -- lệnh insert/update được thực thi
	return NULL; --lệnh insert/update/delete sẽ bị hủy
end;$$
language plpgsql;


--định nghĩa AFTER trigger
create or replace trigger tg_af_clazz
after insert on clazz
for each row 
execute procedure tf_demo_aftertrigger();

--test
insert into clazz(clazz_id, name) values ('20211220', 'demo trigger'); --false
--nếu insert thành công thì mới gọi đến trigger after

insert into clazz(clazz_id, name) values ('20211221', 'demo return NULL');
select * from clazz;

---------------INSTEAD OF-----
--tạo view
create or replace view student_class_shortinfos AS
	select student_id, last_name, first_name, gender, dob, name 
	from student s left join clazz c using(clazz_id);

--xem thông tin view
select * from student_class_shortinfos;

--thử insert
insert into student_class_shortinfos values('20150111', 'Nguyen', 'Thi Oanh', 'F', '1990-01-01', NULL);
insert into student_class_shortinfos values('20150104', 'Nguyen', 'Thi Oanh 1', 'F', '1990-01-01', 'CNTT1.01-K61');

-- -> ko thể insert vào view -> có thể dùng instead of trigger

--trigger func for instead of trigger
create or replace function tf_insert_view() returns trigger as
$$declare v_clazz_id char(8);
begin
	if new.name is NULL then
		insert into student(student_id, last_name, first_name, gender, dob)
			values (new.student_id, new.last_name, new.first_name, new.gender, new.dob);
		return new;
	else
		select clazz_id into v_clazz_id
		from clazz where lower(name) = lower(new.name);
		if v_clazz_id is null then
			raise notice 'Tên lớp (%) của sinh viên chưa tồn tại', new.name;
			return NULL;
		else
			insert into student(student_id, last_name, first_name, gender, dob, clazz_id)
				values (new.student_id, new.last_name, new.first_name, new.gender, new.dob, v_clazz_id);
		end if;
		return new;
	end if;
end;$$
LANGUAGE plpgsql;

--instead of trigger
create or replace trigger tg_insteadof_insert_view
instead of insert on student_class_shortinfos
for each row -- mỗi khi insert một bản ghi thì thực hiện trigger func
execute procedure tf_insert_view();


select * from student;
select * from clazz;
select update_number_students();
delete from student where student_id = '20150104';

--định nghĩa trigger func cho trigger update student number
create or replace function tf_update_student_number() returns trigger as
$$begin
	update clazz set number_students = number_students +1 where clazz_id = new.clazz_id;
	return NULL; --trigger after => return gì cũng đc
end;$$
language plpgsql;

--trigger tự động cập nhật number_students trong bảng clazz 
--khi thêm sinh viên vào bảng student hoặc chuyển lớp của 1 sinh viên
create trigger tg_update_student_number
after insert on student --sau khi insert thành công trên bảng student
for each row -- mỗi khi 1 sv đc insert => tăng số sv lên 1
when (new.clazz_id is not null) --đk kích hoạt: chỉ kích hoạt trigger khi clazz_id ko rỗng
execute procedure tf_update_student_number();

--test
insert into student (student_id, last_name, first_name, dob)
	values ('20211111', 'Vu', 'An', '1996-12-15');
--ko thay đổi do clazz_id là NULL

insert into student (student_id, last_name, first_name, dob, clazz_id)
	values ('20211112', 'Vu 2', 'An 2', '1996-12-15', '20162101');
--cột number_students của clazz có id = 20162101 tăng lên 1

