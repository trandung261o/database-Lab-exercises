
--tạo bảng GiangVien(MaGV, HoTen, DiaChi, NgaySinh)
CREATE TABLE GiangVien(
	MaGV char(4) NOT NULL,
	HoTen nchar(30) NOT NULL,
	DiaChi nvarchar(50) NOT NULL,
	NgaySinh date NOT NULL,
	CONSTRAINT KhoaChinhGiangVien PRIMARY KEY (MaGV)
)

-- tạo bảng DeTai(MaDT, TenDt, Cap, KinhPhi)
CREATE TABLE DeTai(
	MaDT char(4) NOT NULL,
	TenDT nvarchar(50) NOT NULL,
	Cap nchar(12) NOT NULL,
	KinhPhi integer,
	CONSTRAINT KhoaChinhDeTai PRIMARY KEY (MaDT)
)

-- tạo bản ThamGia(MaGV, MaDT, SoGio)
CREATE TABLE ThamGia(
	MaGV char(4) NOT NULL,
	MaDT char(4) NOT NULL,
	SoGio smallint,
	CONSTRAINT KhoaChinhThamGia PRIMARY KEY (MaGV, MaDT),
	CONSTRAINT KhoaNgoai1 FOREIGN KEY (MaGV) REFERENCES GiangVien (MaGV),
	CONSTRAINT KhoaNgoai2 FOREIGN KEY (MaDT) REFERENCES DeTai (MaDT)
)

--xóa bảng ThamGia
drop table ThamGia

--xóa bảng GiangVien
drop table GiangVien

--xóa bảng DeTai
drop table DeTai


-- nhập thông tin cho bảng GiangVien
INSERT INTO GiangVien VALUES('GV01',N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975/10/10'),
('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976/11/03'),
('GV03',N'Trần Đức Khánh',N'Đống Đa, Hà Nội','1977/06/04'),
('GV04',N'Nguyễn Hồng Phương',N'Tây Hồ, Hà Nội','1983/12/10'),
('GV05',N'Lê Thanh Hương',N'Hai Bà Trưng, Hà Nội','1976/10/10')

-- nhập thông tin cho bảng DeTai
INSERT INTO DeTai VALUES ('DT01',N'Tính toán lưới',N'Nhà nước','700'),
('DT02',N'Phát hiện tri thức',N'Bộ','300'),
('DT03',N'Phân loại văn bản',N'Bộ','270'),
('DT04',N'Dịch tự động Anh Việt',N'Trường','30')

-- nhập thông tin cho bảng ThamGia
INSERT INTO ThamGia VALUES ('GV01','DT01','100'),
('GV01','DT02','80'),
('GV01','DT03','80'),
('GV02','DT01','120'),
('GV02','DT03','140'),
('GV03','DT03','150'),
('GV04','DT04','180')

--1. Đưa ra thông tin giảng viên có địa chỉ ở quận "Hai Bà Trưng", 
--sắp xếp theo thứ tự giảm dần của họ tên

select * from GiangVien
where DiaChi like N'%Hai Bà Trưng%'
order by HoTen desc


--2. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên 
--có tham gia vào đề tài "Tính toán lưới"

--cách 1:
select HoTen, DiaChi, NgaySinh from GiangVien, ThamGia, DeTai
where GiangVien.MaGV = ThamGia.MaGV and ThamGia.MaDT = DeTai.MaDT and TenDT like N'%Tính toán lưới%'

--cách 2: (dùng inner join)
select HoTen, DiaChi, NgaySinh
from GiangVien inner join ThamGia on GiangVien.MaGV = ThamGia.MaGV inner join DeTai on ThamGia.MaDT = DeTai.MaDT
where TenDT like N'%Tính toán lưới%'


--3. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên 
--có tham gia vào đề tài "Phân loại văn bản" hoặc "Dịch tự động Anh Việt"

--cách 1:
select HoTen, DiaChi, NgaySinh 
from GiangVien, ThamGia, DeTai
where GiangVien.MaGV = ThamGia.MaGV and ThamGia.MaDT = DeTai.MaDT and (TenDT like N'%Phân loại văn bản%' or TenDT like N'%Dịch tự động Anh Việt%')

--cách 2: (dùng inner join)
select HoTen, DiaChi, NgaySinh
from GiangVien inner join ThamGia on GiangVien.MaGV = ThamGia.MaGV inner join DeTai on ThamGia.MaDT = DeTai.MaDT
where TenDT like N'%Phân loại văn bản%' or TenDT like N'%Dịch tự động Anh Việt%'

--cách 3: dùng in
select HoTen, DiaChi, Ngaysinh
from GiangVien, ThamGia, DeTai
where GiangVien.MaGV = ThamGia.MaGV and ThamGia.MaDT = DeTai.MaDT 
and TenDT in(N'Phân loại văn bản', N'Dịch tự động Anh Việt')

--4. Cho biết thông tin giảng viên tham gia ít nhất 2 đề tài

--cách 1:
select * from GiangVien 
where MaGV in(select MaGV from Thamgia group by MaGV having count(MaDt) >= 2)

--cách 2:
select GiangVien.MaGV, HoTen, DiaChi, NgaySinh from GiangVien, ThamGia
where GiangVien.MaGV = ThamGia.MaGV
group by GiangVien.MaGV, HoTen, DiaChi, NgaySinh having count(MaDT) >= 2



--5. cho biết tên giảng viên tham gia nhiều đề tài nhất
select HoTen from GiangVien
where MaGV in (select MaGV from ThamGia group by MaGV having count(MaDT) >= all(select count(MaDT) from ThamGia group by MaGV))


--6. đề tài nào tốn ít kinh phí nhất 

--cách 1:
select * from DeTai
where KinhPhi <= all(select KinhPhi from DeTai)

--cách 2:
select * from DeTai
where KinhPhi = (select min(KinhPhi) from DeTai)



--7. cho biết tên và ngày sinh của giảng viên sống ở quân Tây Hồ 
--và tên các đề tài mà giảng viên này tham gia 
select HoTen, NgaySinh, TenDT
from GiangVien, DeTai, Thamgia
where GiangVien.MaGV = ThamGia.MaGV and ThamGia.MaDT = DeTai.MaDT 
and DiaChi like N'%Tây Hồ%'


--8. cho biết tên những giảng viên sinh trước năm 1980 
--và có tham gia đề tài "Phân loại văn bản" 

--cách 1: dùng year()
select HoTen 
from GiangVien, DeTai, Thamgia
where GiangVien.MaGV = ThamGia.MaGV and ThamGia.MaDT = DeTai.MaDT 
and year(Ngaysinh) <= 1980 and TenDT like N'%Phân loại văn bản%'

--cách 2: dùng datepart()
select HoTen 
from GiangVien, DeTai, Thamgia
where GiangVien.MaGV = ThamGia.MaGV and ThamGia.MaDT = DeTai.MaDT 
and datepart(year, Ngaysinh) <= 1980 and TenDT like N'%Phân loại văn bản%'



--9. đưa ra mã giảng viên, tên giảng viên và 
--tổng số giờ tham gia nghiên cứu khoa học của từng giảng viên
select GiangVien.MaGV, HoTen, sum(SoGio)
from GiangVien, ThamGia
where GiangVien.MaGV = ThamGia.MaGV
group by GiangVien.MaGv, HoTen




--10. giảng viên Ngô Tuấn Phong sinh ngày 8/9/1986 
--địa chỉ Đống Đa, Hà Nội mới tham gia nghiên cứu đề tài khoa học. 
--hãy thêm thông tin giảng viên này vào bảng GiangVien
insert into GiangVien
values ('GV06', N'Ngô Tuấn Phong', N'Đống Đa, Hà Nội', '08/09/1986')

	--xem lại bảng GiangVien sau khi insert:
select * from GiangVien

--11. Giảng viên Vũ Tuyết Trinh mới chuyển về sống tại quận Tây Hồ, Hà Nội. 
--hãy cập nhật thông tin này
update GiangVien
set DiaChi = N'Tây Hồ, Hà Nội'
where HoTen = N'Vũ Tuyết Trinh'

	--xem lại bảng GiangVien sau khi update:
select * from GiangVien


--12. giảng viên có mã GV02 không tham gia bất kỳ đề tài nào nữa. 
--Hãy xóa tất cả thông tin liên quan đến giảng viên này trong CSDL

--ở đây ta phải xóa từ bảng ThamGia trước rồi mới xóa từ bảng GiangVien. Do ThamGia.MaGV là khóa ngoài của ThamGia tham chiếu đến GiangVien
delete from ThamGia where MaGV = 'GV02'
delete from GiangVien where MaGV = 'GV02'


--nhưng nếu từ đầu ta tạo bảng ThamGia như sau thì có thể xóa ngay từ bảng GiangVien và MaGV ở bảng ThamGia sẽ tự động xóa theo
CREATE TABLE ThamGia(
	MaGV char(4) NOT NULL,
	MaDT char(4) NOT NULL,
	SoGio smallint,
	CONSTRAINT KhoaChinhThamGia PRIMARY KEY (MaGV, MaDT),
	CONSTRAINT KhoaNgoai1 FOREIGN KEY (MaGV) REFERENCES GiangVien (MaGV) on update cascade on delete cascade,
	CONSTRAINT KhoaNgoai2 FOREIGN KEY (MaDT) REFERENCES DeTai (MaDT) on update cascade on delete cascade
)

	--xem lại bảng GiangVien, ThamGia sau khi delete:
select * from GiangVien
select * from ThamGia


--13. đưa ra thông tin giảng viên không tham gia đề tài nào

--cách 1: dùng 'not in'
select * from GiangVien
where MaGV not in (select MaGV from ThamGia)

--cách 2: dùng 'not exists'
select * from GiangVien
where not exists (select * from ThamGia where GiangVien.MaGV = ThamGia.MaGV)

--cách 3: dùng 'except'
select * from GiangVien where MaGV 
in(select MaGV from GiangVien 
except 
select MaGV from ThamGia)
