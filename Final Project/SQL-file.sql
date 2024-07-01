CREATE TABLE khachhang (
    makh INTEGER PRIMARY KEY,
    ho VARCHAR(10),
    ten VARCHAR(10),
    ngaysinh DATE,
    gioitinh VARCHAR(8),
    diachi VARCHAR(200),
    phone VARCHAR(10)
);

CREATE TABLE nhanvien (
    manv INTEGER PRIMARY KEY,
    tennv VARCHAR(50),
    chucvu VARCHAR(50),
    mota VARCHAR(50),
    luongcb NUMERIC(12, 2)
);

CREATE TABLE phongnghi (
    maphong INTEGER PRIMARY KEY,
    tenphong CHAR(5),
    loaiphong CHAR(10),
    giaphong NUMERIC(12, 2),
    quanly_phong INTEGER,
    FOREIGN KEY (quanly_phong) REFERENCES nhanvien(manv)
);

CREATE TABLE dichvu (
    madv INTEGER PRIMARY KEY,
    tendv CHAR(20),
    giadv NUMERIC(12, 2),
    quanly_DV INTEGER,
    FOREIGN KEY (quanly_DV) REFERENCES nhanvien(manv)
);

CREATE TABLE csvc (
    matb INTEGER PRIMARY KEY,
    tentb VARCHAR(50),
    giatb NUMERIC(12, 2)
);

CREATE TABLE trangbi (
    maphong INTEGER,
    matb INTEGER,
    soluong INTEGER,
    PRIMARY KEY (maphong, matb),
    FOREIGN KEY (maphong) REFERENCES phongnghi(maphong),
    FOREIGN KEY (matb) REFERENCES csvc(matb)
);

CREATE TABLE quanly (
    quanly INTEGER,
    biquanly INTEGER,
    PRIMARY KEY (quanly, biquanly),
    FOREIGN KEY (quanly) REFERENCES nhanvien(manv),
    FOREIGN KEY (biquanly) REFERENCES nhanvien(manv)
);

CREATE TABLE datphong (
    madatphong INTEGER PRIMARY KEY,
    maphong INTEGER,
    makh INTEGER,
    ngaynhanphong DATE,
    ngaytraphong DATE,
    FOREIGN KEY (maphong) REFERENCES phongnghi(maphong),
    FOREIGN KEY (makh) REFERENCES khachhang(makh)
);

CREATE TABLE sudungdv (
    masddv INTEGER PRIMARY KEY,
    makh INTEGER,
    madv INTEGER,
    ngaysddv DATE,
    FOREIGN KEY (makh) REFERENCES khachhang(makh),
    FOREIGN KEY (madv) REFERENCES dichvu(madv)
);

CREATE TABLE con (
    macon INTEGER PRIMARY KEY,
    hoten VARCHAR(50),
    tuoi INTEGER
);

CREATE TABLE co (
    makh INTEGER,
    macon INTEGER,
    PRIMARY KEY (makh, macon),
    FOREIGN KEY (makh) REFERENCES khachhang(makh),
    FOREIGN KEY (macon) REFERENCES con(macon)
);

--1. Lấy danh sách tất cả các khách hàng đã đặt phòng trong năm 2024. 
SELECT kh.makh, kh.ho, kh.ten 
FROM khachhang kh 
JOIN datphong dp ON kh.makh = dp.makh 
WHERE EXTRACT(YEAR FROM dp.ngaynhanphong) = 2024; 

--2. Tính tổng số tiền các khách hàng đã trả cho các dịch vụ trong năm 
2024. 
SELECT kh.makh, kh.ho, kh.ten, SUM(dv.giadv) AS tong_tien_dv 
FROM khachhang kh 
JOIN sudungdv sd ON kh.makh = sd.makh 
JOIN dichvu dv ON sd.madv = dv.madv 
WHERE EXTRACT(YEAR FROM sd.ngaysddv) = 2024 
GROUP BY kh.makh, kh.ho, kh.ten; 

--3. Tìm các phòng nghỉ không được đặt trong tháng 2 năm 2024. 
SELECT pn.maphong, pn.tenphong 
FROM phongnghi pn 
WHERE pn.maphong NOT IN ( 
SELECT dp.maphong 
FROM datphong dp 
WHERE EXTRACT(MONTH FROM dp.ngaynhanphong) = 2 
AND EXTRACT(YEAR FROM dp.ngaynhanphong) = 2024 
); 


--4. Lấy thông tin về các dịch vụ được sử dụng nhiều nhất trong năm 2024. 
SELECT dv.madv, dv.tendv, COUNT(sd.madv) AS so_lan_su_dung 
FROM dichvu dv 
JOIN sudungdv sd ON dv.madv = sd.madv 
WHERE EXTRACT(YEAR FROM sd.ngaysddv) = 2024 
GROUP BY dv.madv, dv.tendv 
ORDER BY so_lan_su_dung DESC 
LIMIT 1; 

--5. Tìm các nhân viên quản lý nhiều dịch vụ nhất. 
SELECT nv.manv, nv.tennv, COUNT(dv.madv) AS so_luong_dv 
FROM nhanvien nv 
JOIN dichvu dv ON nv.manv = dv.quanly_DV 
GROUP BY nv.manv, nv.tennv 
ORDER BY so_luong_dv DESC 
LIMIT 1; 

--6. Tính tổng số tiền cơ sở vật chất hiện có trong các phòng. 
SELECT SUM(giatb * tb.soluong) AS tong_gia_tri_csvc 
FROM trangbi tb 
JOIN csvc cs ON tb.matb = cs.matb; 


--7. Tìm các phòng nghỉ có ít nhất 4 thiết bị khác nhau. 
SELECT tb.maphong, COUNT(tb.matb) AS so_thiet_bi 
FROM trangbi tb 
GROUP BY tb.maphong 
HAVING COUNT(tb.matb) >= 4; 


--8. Lấy danh sách các khách hàng và số lượng dịch vụ họ đã sử dụng trong 
năm 2024. 
SELECT kh.makh, kh.ho, kh.ten, COUNT(sd.madv) AS so_dv_da_sd 
FROM khachhang kh 
JOIN sudungdv sd ON kh.makh = sd.makh 
WHERE EXTRACT(YEAR FROM sd.ngaysddv) = 2023 
GROUP BY kh.makh, kh.ho, kh.ten; 


--9. Tìm nhân viên có mức lương cơ bản cao nhất. 
SELECT nv.manv, nv.tennv, nv.luongcb 
FROM nhanvien nv 
ORDER BY nv.luongcb DESC 
LIMIT 1; 


--10. Lấy danh sách các khách hàng có ít nhất 2 con. 
SELECT kh.makh, kh.ho, kh.ten, COUNT(macon) AS so_con 
FROM khachhang kh 
JOIN co c ON kh.makh = c.makh 
GROUP BY kh.makh, kh.ho, kh.ten 
HAVING COUNT(macon) >= 2;


--11. Tính tổng số phòng mỗi nhân viên quản lý. 
SELECT nv.manv, nv.tennv, COUNT(pn.maphong) AS so_phong_quan_ly 
FROM nhanvien nv 
JOIN phongnghi pn ON nv.manv = pn.quanly_phong 
GROUP BY nv.manv, nv.tennv;

--12. Tìm các dịch vụ có giá cao nhất. 
SELECT dv.madv, dv.tendv, dv.giadv 
FROM dichvu dv 
ORDER BY dv.giadv DESC 
LIMIT 1; 


--13. Tính tổng số ngày khách hàng đã lưu trú trong năm 2024. 
SELECT kh.makh, kh.ho, kh.ten, SUM(dp.ngaytraphong - dp.ngaynhanphong) 
AS tong_so_ngay 
FROM khachhang kh 
JOIN datphong dp ON kh.makh = dp.makh 
WHERE EXTRACT(YEAR FROM dp.ngaynhanphong) = 2023 
GROUP BY kh.makh, kh.ho, kh.ten;

--14. Tìm các khách hàng đã sử dụng dịch vụ nhiều nhất. 
SELECT kh.makh, kh.ho, kh.ten, COUNT(sd.madv) AS so_dv_da_sd 
FROM khachhang kh 
JOIN sudungdv sd ON kh.makh = sd.makh 
GROUP BY kh.makh, kh.ho, kh.ten 
ORDER BY so_dv_da_sd DESC 
LIMIT 1; 


--15. Tìm các khách hàng chưa sử dụng dịch vụ nào trong năm 2024. 
SELECT kh.makh, kh.ho, kh.ten 
FROM khachhang kh 
WHERE kh.makh NOT IN ( 
SELECT sd.makh 
FROM sudungdv sd 
WHERE EXTRACT(YEAR FROM sd.ngaysddv) = 2024 
);

--16. Lấy danh sách các thiết bị và tổng số tiền đã chi cho các thiết bị đó. 
SELECT cs.matb, cs.tentb, SUM(cs.giatb * tb.soluong) AS tong_gia_tri 
FROM csvc cs 
JOIN trangbi tb ON cs.matb = tb.matb 
GROUP BY cs.matb, cs.tentb; 


--17. Tìm các phòng nghỉ có giá cao nhất. 
SELECT pn.maphong, pn.tenphong, pn.giaphong 
FROM phongnghi pn 
ORDER BY pn.giaphong DESC 
LIMIT 1;

--18. Lấy danh sách các dịch vụ mà một nhân viên quản lý trong năm 2024. 
SELECT nv.manv, nv.tennv, dv.tendv 
FROM nhanvien nv 
JOIN dichvu dv ON nv.manv = dv.quanly_DV 
join sudungdv using(madv) 
WHERE EXTRACT(YEAR FROM ngaysddv) = 2024;

--19. Tìm các khách hàng có ngày sinh nhật trong tháng hiện tại. 
SELECT kh.makh, kh.ho, kh.ten, kh.ngaysinh 
FROM khachhang kh 
WHERE EXTRACT(MONTH FROM kh.ngaysinh) = EXTRACT(MONTH FROM 
CURRENT_DATE); 

--20. Tính tổng số tiền mỗi khách hàng đã trả cho các dịch vụ trong năm 
2024, bao gồm cả những khách hàng không sử dụng dịch vụ nào. 
SELECT kh.makh, kh.ho, kh.ten, COALESCE(SUM(dv.giadv), 0) AS tong_tien_dv 
FROM khachhang kh 
LEFT JOIN sudungdv sd ON kh.makh = sd.makh 
LEFT JOIN dichvu dv ON sd.madv = dv.madv 
AND EXTRACT(YEAR FROM sd.ngaysddv) = 2024 
GROUP BY kh.makh, kh.ho, kh.ten;

--21. Tìm các nhân viên quản lý nhiều phòng nhất. 
SELECT nv.manv, nv.tennv, COUNT(pn.maphong) AS so_phong_quan_ly 
FROM nhanvien nv 
JOIN phongnghi pn ON nv.manv = pn.quanly_phong 
GROUP BY nv.manv, nv.tennv 
ORDER BY so_phong_quan_ly DESC 
LIMIT 1; 


--22. Lấy danh sách các khách hàng đã đặt phòng và sử dụng dịch vụ trong 
cùng một ngày. 
SELECT kh.makh, kh.ho, kh.ten 
FROM khachhang kh 
JOIN datphong dp ON kh.makh = dp.makh 
JOIN sudungdv sd ON kh.makh = sd.makh 
WHERE dp.ngaynhanphong = sd.ngaysddv;

--23. Tìm các dịch vụ chưa được sử dụng lần nào. 
SELECT dv.madv, dv.tendv 
FROM dichvu dv 
LEFT JOIN sudungdv sd ON dv.madv = sd.madv 
WHERE sd.madv IS NULL; 


--24. Lấy danh sách các nhân viên quản lý có số lượng nhân viên bị quản lý 
lớn nhất. 
SELECT nv.manv, nv.tennv, COUNT(q.biquanly) AS so_luong_nv_bi_quan_ly 
FROM nhanvien nv 
JOIN quanly q ON nv.manv = q.quanly 
GROUP BY nv.manv, nv.tennv 
ORDER BY so_luong_nv_bi_quan_ly DESC 
LIMIT 1; 

--25. Tính tổng số lượng thiết bị mỗi phòng có. 
SELECT tb.maphong, SUM(tb.soluong) AS tong_so_luong_tb 
FROM trangbi tb 
GROUP BY tb.maphong; 


--26. Tìm các khách hàng có số lần đặt phòng nhiều nhất trong năm 2024. 
SELECT kh.makh, kh.ho, kh.ten, COUNT(dp.madatphong) AS 
so_lan_dat_phong 
FROM khachhang kh 
JOIN datphong dp ON kh.makh = dp.makh 
WHERE EXTRACT(YEAR FROM dp.ngaynhanphong) = 2023 
GROUP BY kh.makh, kh.ho, kh.ten 
ORDER BY so_lan_dat_phong DESC 
LIMIT 1;

--27. Lấy danh sách các phòng và tổng số tiền mà phòng đó đã kiếm được 
từ các lần đặt phòng trong năm 2024. 
SELECT pn.maphong, pn.tenphong, SUM(pn.giaphong) AS tong_tien_phong 
FROM phongnghi pn 
JOIN datphong dp ON pn.maphong = dp.maphong 
WHERE EXTRACT(YEAR FROM dp.ngaynhanphong) = 2024 
GROUP BY pn.maphong, pn.tenphong;

--28. liệt các khách hàng có con sử dụng dịch vụ childcare và tên, tuổi của 
con họ 
select makh as "makh", ho || ' ' || ten as "khach hang", con.hoten as "ten con", 
con.tuoi 
from khachhang join co using (makh) 
join sudungdv using(makh) 
join con using(macon) 
join dichvu using(madv) 
where tendv = 'childcare'; 

--29. 7 phòng có thiết bị đắt nhất 
select maphong, tenphong, loaiphong, sum(giatb * soluong) as 
tong_gia_trang_bi 
from phongnghi join trangbi using(maphong) 
join csvc using (matb) 
group by maphong, tenphong, loaiphong 
order by tong_gia_trang_bi desc 
limit 7;

--30. tổng tiền phòng của loại phòng vip được nhận trong tháng 5/2024 
select ho || ' ' || ten as "khach hang", tenphong as "phong", loaiphong as "loai 
phong", ngaynhanphong as "ngay nhan phong", 
sum(giaphong * (ngaytraphong - ngaynhanphong)) as "tong tien phong" 
from khachhang join datphong using(makh) 
join phongnghi using(maphong) 
where extract(month from ngaynhanphong) = 5 
and extract(year from ngaynhanphong) = 2024 
and loaiphong = 'vip' 
group by ho, ten, loaiphong, tenphong, ngaynhanphong 
order by "tong tien phong" desc; 

--trigger kiểm tra xem phòng đã có người đặt chưa
--trigger function
create or replace function check_phong() returns trigger as $$ begin	
if exists (select 1 from datphong 			
	where maphong = new.maphong			
	and ((new.ngaynhanphong between ngaynhanphong and ngaytraphong)			
	or (new.ngaytraphong between ngaynhanphong and ngaytraphong)				
	or (new.ngaynhanphong < ngaynhanphong and new.ngaytraphong > ngaytraphong)		
	)		
)		
then 			
	raise exception 'Phong nay da co nguoi dat!';		
	end if;	
return new;
end;$$	language plpgsql;
--trigger
create trigger check_phong
before insert or update on datphong
for each row
execute function check_phong();


--1. function tính tiền phòng
create or replace function tinh_tien_phong(makh int, thang int, nam int)
returns numeric as $$
declare
    tong_tien numeric := 0;
begin
    select sum(giaphong * (ngaytraphong - ngaynhanphong)) into tong_tien
    from khachhang join datphong using(makh)
                    join phongnghi using(maphong)
    where extract(month from ngaytraphong) = thang
        and extract(year from ngaytraphong) = nam
        and khachhang.makh = tinh_tien_phong.makh;
    
    return tong_tien;
end;
$$ language plpgsql;


--2. function tính tiền dịch vụ
create or replace function tinh_tien_dich_vu(makh int, thang int, nam int)
returns numeric as $$
declare
    tong_tien numeric := 0;
begin
    select sum(giadv) into tong_tien
    from khachhang 
    join sudungdv using(makh)
    join dichvu using(madv)
    where extract(month from sudungdv.ngaysddv) = thang
        and extract(year from sudungdv.ngaysddv) = nam
        and khachhang.makh = tinh_tien_dich_vu.makh;
    
    return tong_tien;
end;
$$ language plpgsql;


--1. View để hiển thị thông tin chi tiết của khách hàng và các phòng mà họ đã đặt:
CREATE VIEW v_khachhang_datphong AS
SELECT kh.makh, kh.ho, kh.ten, kh.ngaysinh, kh.gioitinh, kh.diachi, kh.phone,
       dp.madatphong, dp.maphong, dp.ngaynhanphong, dp.ngaytraphong
FROM khachhang kh
JOIN datphong dp ON kh.makh = dp.makh;


--2. View để hiển thị thông tin chi tiết của các phòng nghỉ cùng với nhân viên quản lý:
CREATE VIEW v_phongnghi_nhanvien AS
SELECT pn.maphong, pn.tenphong, pn.loaiphong, pn.giaphong, 
       nv.manv, nv.tennv, nv.chucvu
FROM phongnghi pn
JOIN nhanvien nv ON pn.quanly_phong = nv.manv;


--3. View để hiển thị thông tin chi tiết của các dịch vụ cùng với nhân viên quản lý:
CREATE VIEW v_dichvu_nhanvien AS
SELECT dv.madv, dv.tendv, dv.giadv,
       nv.manv, nv.tennv, nv.chucvu
FROM dichvu dv
JOIN nhanvien nv ON dv.quanly_DV = nv.manv;

--1. Index trên cột ho và ten trong bảng khachhang:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm theo họ và tên của khách hàng.
CREATE INDEX idx_khachhang_ho_ten ON khachhang(ho, ten);

--2. Index trên cột ngaysinh trong bảng khachhang
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm khách hàng theo ngày sinh.
CREATE INDEX idx_khachhang_ngaysinh ON khachhang(ngaysinh);

--3. Index trên cột quanly_phong trong bảng phongnghi
   -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm phòng nghỉ theo mã nhân viên quản lý.
CREATE INDEX idx_phongnghi_quanly_phong ON phongnghi(quanly_phong);

--4. Index trên cột quanly_DV trong bảng dichvu
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm dịch vụ theo mã nhân viên quản lý.
CREATE INDEX idx_dichvu_quanly_dv ON dichvu(quanly_DV);

--5. Index trên cột maphong trong bảng trangbi:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm trang bị theo mã phòng.
CREATE INDEX idx_trangbi_maphong ON trangbi(maphong);

--6. Index trên cột matb trong bảng trangbi:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm trang bị theo mã thiết bị.
CREATE INDEX idx_trangbi_matb ON trangbi(matb);

--7. Index trên cột madatphong trong bảng datphong:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm các đơn đặt phòng theo mã đặt phòng.
CREATE INDEX idx_datphong_madatphong ON datphong(madatphong);

--8. Index trên cột maphong trong bảng datphong:
    - Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm các đơn đặt phòng theo mã phòng.
CREATE INDEX idx_datphong_maphong ON datphong(maphong);

--9. Index trên cột makh trong bảng datphong
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm các đơn đặt phòng theo mã khách hàng.
CREATE INDEX idx_datphong_makh ON datphong(makh);

--10. Index trên cột makh trong bảng sudungdv:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm các dịch vụ sử dụng theo mã khách hàng.
CREATE INDEX idx_sudungdv_makh ON sudungdv(makh);

--11. Index trên cột madv trong bảng sudungdv:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm các dịch vụ sử dụng theo mã dịch vụ.
CREATE INDEX idx_sudungdv_madv ON sudungdv(madv);

--12. Index trên cột hoten trong bảng con:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm con của khách hàng theo họ tên.

CREATE INDEX idx_con_hoten ON con(hoten);

--13. Index trên cột tuoi trong bảng con:
    -- Tạo index để cải thiện hiệu suất truy vấn khi tìm kiếm con của khách hàng theo tuổi.
CREATE INDEX idx_con_tuoi ON con(tuoi);


