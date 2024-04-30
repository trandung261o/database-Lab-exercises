THAMGIADT
	(
		MAGV,
		MADT,
		STT,
		PHUCAP,
		KETQUA,
		Primary Key (MAGV,MADT,STT)
	)

	
KHOA
	(
		MAKHOA,
		TENKHOA,
		NAMTL,
		PHONG,
		DIENTHOAI,
		TRUONGKHOA,
		NGAYNHANCHUC,
		primary key (MAKHOA)
	)

	
 BOMON
	(
		MABM,
		TENBM,
		PHONG,
		DIENTHOAI,
		TRUONGBM,
		MAKHOA,
		NGAYNHANCHUC,
		primary key (MABM)
	)

	
CONGVIEC 
	(
		MADT,
		SOTT,
		TENCV,
		NGAYBD,
		NGAYKT,
		primary key (MADT,SOTT)
	)
	
	
DETAI
	(
		MADT,
		TENDT,
		CAPQL,
		KINHPHI,
		NGAYBD,
		NGAYKT,
		MACD,
		GVCNDT,
		primary key (MADT)
	)

 
CHUDE
	(
		MACD,
		TENCD,
		primary key (MACD)
	)
	
	
GIAOVIEN
	(
		MAGV,
		HOTEN,
		LUONG,
		PHAI,
		NGSINH,
		DIACHI,
		GVQLCM,
		MABM,
		primary key (MAGV)
	)
	
	
NGUOITHAN
	(
		MAGV,
		TEN,
		NGSINH,
		PHAI,
		primary key (MAGV,TEN)
	)
	
	
GV_DT
	(
		MAGV,
		DIENTHOAI,
		primary key (MAGV,DIENTHOAI)
	)
	
