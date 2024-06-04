-- Tạo các bảng
CREATE TABLE KhachHang (
    MaKhachHang INTEGER PRIMARY KEY,
    Ho VARCHAR(50) NOT NULL,
    Ten VARCHAR(50) NOT NULL,
	GioiTinh char(8),
    NgaySinh DATE NOT NULL,
    DiaChi VARCHAR(200)
);

CREATE TABLE Phong (
    MaPhong INTEGER PRIMARY KEY,
    SoPhong VARCHAR(10) NOT NULL UNIQUE,
    LoaiPhong VARCHAR(50) NOT NULL,
    Gia NUMERIC(10, 2) NOT NULL
);

CREATE TABLE DatPhong (
    MaDatPhong INTEGER PRIMARY KEY,
    MaKhachHang INT,
    MaPhong INT,
    NgayNhanPhong DATE NOT NULL,
    NgayTraPhong DATE NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
);

CREATE TABLE DichVu (
    MaDichVu INTEGER PRIMARY KEY,
    TenDichVu VARCHAR(100) NOT NULL,
    Gia NUMERIC(10, 2) NOT NULL
);

CREATE TABLE SuDungDichVu (
    MaSuDungDichVu INTEGER PRIMARY KEY,
    MaDatPhong INT,
    MaDichVu INT,
    FOREIGN KEY (MaDatPhong) REFERENCES DatPhong(MaDatPhong),
    FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu)
);

	
--5 cầu truy vấn về thông tin khách hàng
-- 1. Danh sách các khách hàng và phòng, loại phòng họ đã đặt
select ho || ' ' || ten as "Ten khach hang", sophong as "Dat phong", loaiphong "Loai phong"
from khachhang join datphong using (makhachhang) 
	join phong using (maphong)
	order by "Ten khach hang";

-- 2. danh sách ngày nhận phòng, trả phòng của các khách hàng
select ho || ' ' || ten as "Khach hang", sophong "Phong",
	ngaynhanphong as "Ngay nhan phong", 
	ngaytraphong as "Ngay tra phong"
	from khachhang join datphong using(makhachhang)
		join phong using(maphong)
	order by "Khach hang";

-- 3. ngày sinh và số tuổi của các khách hàng đã đặt phòng
select ho || ' ' || ten as "Khach hang", ngaysinh as "Sinh nhat", 
	extract(year from age(ngaysinh)) as "So tuoi"
	from khachhang 
	where makhachhang in 
		(select makhachhang from datphong);

-- 4. Số ngày ở của các khách hàng
select ho || ' ' || ten as "Khach hang", sum(ngaytraphong - ngaynhanphong) "So ngay o"
	from khachhang join datphong using(makhachhang)
	group by "Khach hang"
	order by "So ngay o"
	desc;

-- 5. Những khách hàng có địa chỉ ở thành phố Hồ Chí Minh
select ho || ' ' || ten as "Khach hang", diachi as "Dia chi"
	from khachhang where diachi like '%TP.HCM%'

-- 6. Những khách hàng là nam và đặt phòng loại suite
select ho || ' ' || ten as "Khach hang", gioitinh "Gioi tinh", 
	sophong "Dat phong", loaiphong "Loai phong"
	from khachhang join datphong using(makhachhang)
		join phong using(maphong)
	where loaiphong = 'Suite' and gioitinh = 'Male';

-- 7. khách hàng họ "Nguyen" đã đặt phòng trong tháng 5 năm 2024
select ho || ' ' || ten "Khach hang", ngaynhanphong "Ngay nhan phong"
	from khachhang join datphong using(makhachhang)
	where khachhang.ho = 'Nguyen'
		and extract(month from ngaynhanphong) = 5
		and extract(year from ngaynhanphong) = 2024;


-- 5 câu truy vấn về thông tin phòng
-- 8. Loại phòng và số lượng của loại phòng đó mà khách sạn có
select loaiphong "Loai phong", count(sophong) "So phong"
	from phong
	group by loaiphong;

-- 9. số ngày trung bình mà khách ở của mỗi loại phòng
select loaiphong "Loai phong", avg(ngaytraphong - ngaynhanphong) "TB Ngay o"
	from phong join datphong using(maphong)
	group by loaiphong;


-- 10. danh sách phòng loại double có khách hàng từ 30-35 tuổi
select sophong "Phong", loaiphong "Loai phong", ho || ' ' || ten "Khach hang", 
	extract (year from age(ngaysinh)) "So tuoi"
	from datphong join phong using(maphong)
		join khachhang using(makhachhang)
	where extract (year from age(ngaysinh)) between 30 and 35
		and loaiphong = 'Double';

select * from datphong
-- 5 câu truy vấn về thông tin đặt phòng
-- 11. Số phòng đã được đặt của mỗi loại phòng trong tháng 6
select loaiphong "Loai phong", count(sophong) as "So phong duoc dat" 
	from datphong join phong using(maphong)
	where extract(month from ngaynhanphong) = 6
	group by loaiphong;
	

-- 12. những phòng chưa từng được ai đặt 
select sophong "So phong", loaiphong "Loai phong", gia "Gia phong"
	from phong where maphong not in
		(select maphong from datphong);

-- 13. Danh sách các phòng đã được đặt trong trong tháng 7 năm 2024
select sophong "So phong", ngaynhanphong "Ngay nhan phong" 
	from phong join datphong using(maphong) 
	where extract(month from ngaynhanphong) = 7
		and extract(year from ngaynhanphong) = 2024;


-- 14. danh sách các phòng và số lần chúng từng được đặt
select maphong, sophong, loaiphong, 
	count(datphong.madatphong) "So lan duoc dat"
	from phong left join datphong using(maphong) 
		group by maphong,sophong,loaiphong
		order by "So lan duoc dat" desc;


-- 15. Danh sách các phòng Suite được ở dưới 10 ngày và tên khách hàng đặt phòng
select sophong "So phong", loaiphong "Loai phong", 
	ngaynhanphong "Ngay nhan phong", ngaytraphong "Ngay tra phong",
	ho || ' ' || ten "Khach hang dat phong"
	from phong join datphong using(maphong)
		join khachhang using(makhachhang)
	where ngaytraphong - ngaynhanphong < 10 and loaiphong = 'Suite';


-- 16. thông tin đặt phòng của những khách hàng có địa chỉ ở Hà Nội hoặc Thanh Hóa
select ho || ' ' || ten "Khach hang", diachi "Dia chi", madatphong "Ma dat phong", sophong "Dat phong", 
	ngaynhanphong "Ngay nhan phong", ngaytraphong "Ngay tra phong"
	from khachhang join datphong using(makhachhang)
		join phong using(maphong)
	where diachi like '%Ha Noi%' or diachi like '%%Thanh Hoa';


select * from dichvu
--5 câu truy vấn về dịch vụ
-- 17. 3 dịch vụ có giá cao nhất
select tendichvu "Dich vu", gia "Gia" from dichvu
	order by gia
	desc
	limit 3;

-- 18. danh sách dịch vụ có giá từ 200.000 đến 500.000
select tendichvu "Dich vu", gia "Gia" 
	from dichvu
	where gia between 200000 and 500000;

select * from sudungdichvu
--5 câu truy vấn về sử dụng dịch vụ
-- 19. Danh sách các dịch vụ đã sử dụng của mỗi phòng
select sophong as "Phong", tendichvu as "Dich vu da su dung" 
	from datphong join sudungdichvu using(madatphong)
		 join dichvu using(madichvu)
		 join phong using(maphong);


-- 20. Danh sách các khách hàng chưa sử dụng dịch vụ nào và phòng của họ
select ho || ' ' || ten as "Khach hang", sophong as "Phong"
	from khachhang join datphong using(makhachhang)
		join phong using(maphong)
		left join sudungdichvu using(madatphong)
	where sudungdichvu.masudungdichvu is null;

-- 21. Danh sách các dịch vụ được sử dụng nhiều nhất
select tendichvu as "Dich vu", count(*) as "So lan su dung"
	from sudungdichvu join dichvu using(madichvu)
	group by tendichvu
	order by "So lan su dung" desc;

-- 22. 3 khách hàng sử dụng nhiều dịch vụ nhất và phòng của họ
select ho || ' ' || ten "Khach hang", sophong "Phong", count(sudungdichvu.madichvu) "So dich vu su dung"
	from khachhang join datphong using (makhachhang)
		join sudungdichvu using(madatphong)
		join phong using(maphong)
	group by "Khach hang", "Phong"
	order by "So dich vu su dung" desc
	limit 3;

-- 23. Lấy danh sách dịch vụ không được sử dụng
select tendichvu, sudungdichvu.madichvu 
	from dichvu left join sudungdichvu using(madichvu) 
	where sudungdichvu.madichvu is null;


-- 24. danh sách các phòng có khách hàng là nữ và sử dụng dịch vụ "Breakfast"
select sophong "Phong", ho || ' ' || ten "Khach hang", tendichvu "Dich vu"
	from sudungdichvu join datphong using(madatphong)
		join dichvu using(madichvu)
		join khachhang using(makhachhang)
		join phong using(maphong)
	where tendichvu = 'Breakfast' and gioitinh = 'Female';

--5 câu truy vấn về tiền
-- 25. Tính tổng số tiền phòng mà mỗi khách hàng phải trả
select ho || ' ' || ten as "Khach hang", maphong "Ma phong", 
	sophong "Phong", 
	sum(gia * (ngaytraphong - ngaynhanphong)) as "Tong tien phong"
from khachhang join datphong using(makhachhang)
	join phong using(maphong)
	group by ho, ten, maphong, sophong
	order by "Tong tien phong"
	desc;

-- 26. Tính tổng tiền sử dụng dịch vụ của mỗi khách hàng khách hàng
select ho || ' ' || ten as "Khach hang", maphong "Ma phong", 
	sophong "Phong", 
	sum(dichvu.gia) as "Tong tien dich vu"
	from khachhang join datphong using(makhachhang)
		join phong using (maphong)
		left join sudungdichvu using(madatphong)
		left join dichvu using(madichvu)
	group by ho, ten, maphong, sophong
	order by "Tong tien dich vu"
	desc;

-- 27. tổng tiền phòng của loại phòng double được nhận trong tháng 6/2024
select ho || ' ' || ten as "Khach hang", 
	sophong "Phong", loaiphong "Loai phong",
	ngaynhanphong "Ngay nhan phong",
	sum(gia * (ngaytraphong - ngaynhanphong)) as "Tong tien phong"
from khachhang join datphong using(makhachhang)
	join phong using(maphong)
	where extract(month from ngaynhanphong) = 6
		and extract(year from ngaynhanphong) = 2024
		and loaiphong = 'Double'
	group by ho, ten, loaiphong, sophong, ngaynhanphong
	order by "Tong tien phong"
	desc;

-- 28. 5 Dịch vụ có doanh thu nhiều nhất
select tendichvu "Dich vu", 
	count(madatphong) * dichvu.gia "Doanh thu"
	from sudungdichvu join dichvu using(madichvu)
	group by tendichvu, gia
	order by "Doanh thu" 
	desc
	limit 5;


-- 29. 5 phòng có doanh thu nhiều nhất
select sophong "Phong", loaiphong "Loai phong",
	phong.gia * (ngaytraphong - ngaynhanphong) "Doanh thu"
	from phong join datphong using(maphong)
	order by "Doanh thu"
	desc
	limit 5;


-- 30. doanh thu của mỗi loại phòng
select loaiphong "Loai phong", 
	sum((ngaytraphong - ngaynhanphong) * phong.gia) "Doanh thu"
	from phong join datphong using(maphong)
	group by loaiphong;




--TRIGGER
--trigger kiểm tra xem phòng đã có người đặt chưa
--trigger function
create or replace function check_phong() returns trigger as
$$begin
	if exists(select 1 from datphong 
			where maphong = new.maphong
			and ((new.ngaynhanphong between ngaynhanphong and ngaytraphong)
				or (new.ngaytraphong between ngaynhanphong and ngaytraphong)
				or (new.ngaynhanphong < ngaynhanphong and new.ngaytraphong > ngaytraphong)
			)
		)
		then 
			raise notice 'Phong nay da co nguoi dat!';
			return null;
		end if;
	return new;
end;$$
language plpgsql;

--trigger
create trigger check_phong
before insert or update on datphong
for each row
execute function check_phong();

--test trigger
select * from datphong
INSERT INTO DatPhong (madatphong, MaKhachHang, MaPhong, NgayNhanPhong, NgayTraPhong) VALUES
(9, 4, 9, '2024-08-01', '2024-08-12'),
(10, 2, 3, '2024-09-01', '2024-09-11')
		






--FUNCTION
--1. function tính tiền phòng
create or replace function tien_phong(maphong_input int) 
returns numeric as $$
	declare tienphong numeric(10, 2);
begin 
	select gia*(ngaytraphong - ngaynhanphong) into tienphong
	from phong join datphong using(maphong)
	where maphong = maphong_input;
	return coalesce(tienphong, 0); --nếu tiền phòng NULL thì trả về 0
end;$$
language plpgsql;
	
select tien_phong(3)




--2. function tính tiền dịch vụ
create or replace function tien_dv(maphong_input int) 
returns numeric as $$
	declare tiendv numeric(10, 2);
begin 
	select sum(dichvu.gia) into tiendv
	from sudungdichvu join dichvu using(madichvu)
		join datphong using(madatphong)
	where maphong = maphong_input;
	return coalesce(tiendv, 0); --nếu tiền dịch vụ NULL thì trả về 0
end;$$
language plpgsql;

select tien_dv(3)

--3. function tính tổng tiền 
create or replace function tong_tien(maphong_input int) 
returns numeric as $$
	declare 
		tongtien numeric(10,2);
		tienphong numeric(10,2);
		tiendv numeric(10,2);
begin
	tienphong := tien_phong(maphong_input);
	tiendv := tien_dv(maphong_input);
	tongtien := tienphong + tiendv;
	return tongtien;
end;$$
language plpgsql;






--VIEW
--view hiển thị hóa đơn của khách hàng, gồm: số phòng, mã phòng, tiền phòng, tiền dịch vụ và tổng tiền
create or replace view hoadon as
select makhachhang "Ma KH", 
	ho || ' ' || ten "Khach hang", 
	sophong "O phong", 
	maphong "Ma phong", 
	loaiphong "Loai phong",
	tien_phong(maphong) "Tien phong",
	tien_dv(maphong) "Tien dich vu",
	tong_tien(maphong) "Tong"
from khachhang join datphong using (makhachhang)
	join phong using(maphong)
	order by "Tong" desc;

select * from hoadon


select * from khachhang;
select * from phong;
select * from datphong;
select * from dichvu;
select * from sudungdichvu;

























