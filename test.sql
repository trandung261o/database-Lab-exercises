CREATE TABLE GiangVien(
	MaGV char(4) NOT NULL,
	HoTen nchar(30) NOT NULL,
	DiaChi nvarchar(50) NOT NULL,
	NgaySinh date NOT NULL,
	CONSTRAINT KhoaChinhGiangVien PRIMARY KEY (MaGV)
)

CREATE TABLE DeTai(
	MaDT char(4) NOT NULL,
	TenDT nvarchar(50) NOT NULL,
	Cap nchar(12) NOT NULL,
	KinhPhi integer,
	CONSTRAINT KhoaChinhDeTai PRIMARY KEY (MaDT)
)

CREATE TABLE ThamGia(
	MaGV char(4) NOT NULL,
	MaDT char(4) NOT NULL,
	SoGio smallint,
	CONSTRAINT KhoaChinhThamGia PRIMARY KEY (MaGV, MaDT),
	CONSTRAINT KhoaNgoai1 FOREIGN KEY (MaGV) REFERENCES GiangVien (MaGV),
	CONSTRAINT KhoaNgoai2 FOREIGN KEY (MaDT) REFERENCES DeTai (MaDT)
)
