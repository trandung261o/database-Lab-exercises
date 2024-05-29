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
-- -> ko thể insert vào view -> có thể dùng instead of trigger

--trigger func for instead of trigger
create or replace function tf_insert_view() returns trigger as
$$begin
	insert into student(student_id, last_name, first_name, gender, dob)
				values (new.student_id, new.last_name, new.first_name,
						new.gender, new.dob);
	return new;
end;$$
LANGUAGE plpgsql;

--instead of trigger
create or replace trigger tg_insteadof_insert_view
instead of insert on student_class_shortinfos
for each row -- mỗi khi insert một bản ghi thì thực hiện trigger func
execute procedure tf_insert_view();

select * from student;
