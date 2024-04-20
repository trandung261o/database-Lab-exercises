--create table Supplier(sid, sname, size, city)
CREATE TABLE Supplier(
	--columns
		sid char(4) NOT NULL PRIMARY KEY,
		sname varchar(30) NOT NULL,
		size smallint,
		city varchar(20)

	--CONSTRAINT KhoachinhS primary key(sid)
);

--create table Product(pid, pname, colour, weight, city)
CREATE TABLE Product(
	--columns
		pid char(4) NOT NULL,
		pname varchar(30) NOT NULL,
		colour char(8),
		weight int,
		city varchar(20), 

	--constrains
		CONSTRAINT KhoachinhP primary key(pid)
);

--create table SupplyProduct(sid, pid, quantity)
CREATE TABLE SupplyProduct(
	--columns
		sid char(4) NOT NULL,
		pid char(4) NOT NULL,
		quantity smallint, 

	--constrains
		primary key(sid,pid),
		foreign key(sid) references Supplier(sid),
		foreign key(pid) references Product(pid),
		check(quantity >0) --khi insert thi cot quantity phai > 0
);

-- Insert values into Supplier table
INSERT INTO Supplier (sid, sname, size, city) 
VALUES 
    ('S1', 'Dustin', 100, 'London'),
    ('S2', 'Rusty', 70, 'Paris'),
    ('S3', 'Lubber', 120, 'London'),
    ('S4', 'M&M', 60, 'NewYork'),
    ('S5', 'MBI', 1000, 'NewOrlean'),
    ('S6', 'Panda', 150, 'London');

-- Insert values into Product table
INSERT INTO Product (pid, pname, colour)
VALUES 
    ('P1', 'Screw', 'red'),
    ('P2', 'Screw', 'green'),
    ('P3', 'Nut', 'red'),
    ('P4', 'Bolt', 'blue'),
    ('P5', 'Plier', 'green'),
    ('P6', 'Scissors', 'blue');

-- Insert values into SupplyProduct table
INSERT INTO SupplyProduct (sid, pid, quantity)
VALUES 
    ('S1', 'P1', 500),
    ('S1', 'P2', 400),
    ('S1', 'P3', 100),
    ('S2', 'P2', 200),
    ('S3', 'P4', 100),
    ('S2', 'P3', 155),
    ('S3', 'P1', 300),
    ('S3', 'P2', 350),
    ('S3', 'P6', 200),
    ('S4', 'P1', 10),
    ('S5', 'P2', 200);


--thêm cột: price, kiểu DL real vào bảng SupplyProduct
ALTER TABLE SupplyProduct
ADD price real NOT NULL;

--xóa cột: price trong bảng SupplyProduct
ALTER TABLE SupplyProduct
DROP COLUMN price;

--sửa cột: kiểu DL của sname thành varchar(20)
ALTER TABLE Supplier
ALTER COLUMN sname varchar(20);


--Đưa ra tên của các mặt hàng
SELECT pname FROM Product;

--Đưa ra tên khác nhau của các mặt hàng
SELECT DISTINCT pname
FROM Product;

--Đưa ra toàn bộ thông tin về các hãng cung ứng
SELECT * FROM Supplier;

--Đưa ra mã số hãng cung ứng, mã mặt hàng được cung ứng và 10 lần số lượng mặt hàng đã được cung ứng
SELECT sid, pid, quantity*10
FROM SupplyProduct;


--đưa ra tên của các hãng cung ứng có trụ sở tại London
SELECT sname FROM Supplier
WHERE city = 'London';

--đưa ra mã số và tên của các hãng cung ứng nằm ở London và có số nhân viên lớn hơn 75
SELECT sid, sname from Supplier
WHERE city = 'London' AND size > 75;


--đưa ra thông tin của các hãng cung ứng có số nhân viên trong khoảng từ 100 đến 150
SELECT * from Supplier
WHERE size BETWEEN 100 AND 150

-- đưa ra mã số của hãng cung ứng mặt hàng P1 hoặc P2
--cách 1:
SELECT sid from SupplyProduct 
WHERE pid = 'P1' OR pid = 'P2'

--cách 2:
SELECT sid from SupplyProduct
where pid IN('P1', 'P2');

--đưa ra thông tin của hãng sản xuất có trụ sở đặt tại thành phố bắt đầu bằng chữ New
SELECT * from Supplier
WHERE city LIKE 'New%'


--đưa ra tên và số nhân viên của các hãng cung ứng ở Paris
SELECT sname AS HangOParis, size AS SoNhanVien FROM Supplier
WHERE city LIKE '%Paris%';

--đưa ra tên của hãng có cung ứng mặt hàng P1
SELECT sname FROM Supplier, SupplyProduct
WHERE Supplier.sid = SupplyProduct.sid AND SupplyProduct.pid = 'P1';

--đưa ra tên và mã số của hãng cung ứng ít nhất một mặt hàng màu đỏ
SELECT DISTINCT sname, Supplier.sid FROM Supplier, Product, SupplyProduct
WHERE Supplier.sid = SupplyProduct.sid AND SupplyProduct.pid = Product.pid AND Product.colour = 'red';

--tìm sid của hãng cung ứng đồng thời 2 mặt hàng P1 và P2
SELECT sid FROM SupplyProduct WHERE pid = 'P1'
INTERSECT 
SELECT sid FROM SupplyProduct WHERE pid = 'P2'

--tìm mã số của hãng không cung ứng mặt hàng nào
SELECT sid FROM Supplier
EXCEPT
SELECT sid FROM SupplyProduct

--tìm thông tin hãng cung ứng có số nhân viên lớn nhất
SELECT * FROM Supplier
WHERE size >= ALL(SELECT size FROM Supplier);

--tìm sid của hãng cung ứng đồng thời 2 mặt hàng P1 và P2
SELECT DISTINCT sid FROM SupplyProduct
WHERE pid = 'P1' AND sid IN(SELECT sid FROM
SupplyProduct WHERE pid = 'P2')

--đưa ra sid của hãng không cung ứng mặt hàng P3
SELECT DISTINCT sid FROM SupplyProduct
WHERE sid NOT IN (SELECT sid FROM 
SupplyProduct WHERE pid = 'P3');

--đưa ra sid của hãng cung ứng một mặt hàng với số lượng bằng ít nhất 1 trong số lượng các mặt hàng được cung ứng bởi S2	
SELECT sid FROM SupplyProduct
WHERE sid != 'S2' AND quantity = ANY(SELECT quantity FROM SupplyProduct WHERE sid = 'S2')

--đưa ra thông tin của các hãng cung ứng đã cung ứng ít nhất một mặt hàng
SELECT * FROM Supplier
WHERE EXISTS (SELECT sid FROM SupplyProduct WHERE Supplier.sid = SupplyProduct.sid)

--đưa ra thông tin của hãng không cung ứng mặt hàng nào
SELECT * FROM Supplier
WHERE NOT EXISTS (SELECT * FROM SupplyProduct WHERE Supplier.sid = SupplyProduct.sid)

--cách 2:
SELECT * FROM Supplier
WHERE Supplier.sid NOT IN(SELECT SupplyProduct.sid FROM SupplyProduct)

--có bao nhiêu mặt hàng khác nhau được cung ứng
SELECT COUNT(DISTINCT pid) FROM SupplyProduct;

--có tổng cộng bao nhiêu nhân viên làm cho các hãng ở Paris
SELECT SUM(size) FROM Supplier
WHERE city = 'Paris'

--đưa ra số lượng mặt hàng trung bình mà hãng S1 cung ứng
SELECT AVG(quantity)
FROM SupplyProduct WHERE sid = 'S1'

--đưa ra tên của hãng S1 và tổng số lượng các mặt hàng mà hãng đó cung ứng 
SELECT sname, SUM(quantity)
FROM Supplier, SupplyProduct WHERE Supplier.sid = SupplyProduct.sid AND Supplier.sid = 'S1'
GROUP BY sname

--đưa ra mã số các hãng cung ứng và số lượng trung bình các mặt hàng được cung ứng bởi từng hãng
SELECT sid, AVG(quantity) FROM SupplyProduct
GROUP BY sid

--đưa ra mã số các hãng cung ứng mà số lượng mặt hàng trung bình được cung cấp bởi hãng đó là trong khoảng từ 75 đến 100
SELECT sid, AVG(quantity) FROM SupplyProduct
GROUP BY sid HAVING AVG(quantity) BETWEEN 75 AND 100

--Sửa dữ liệu: hãng S1 chuyển tới Milan
UPDATE Supplier 
SET city = 'Milan'
WHERE sid = 'S1'

--tất cả mặt hàng được cung cấp với số lượng < 100 đều tăng số lượng lên 1.5 lần
UPDATE SupplyProduct
SET quantity = quantity * 1.5
WHERE quantity < 100;

--xóa bảng
DROP TABLE Supplier
DROP TABLE Product
DROP TABLE SupplyProduct

--hiện thị thông tin bảng
SELECT * FROM Supplier;

SELECT * from SupplyProduct;

SELECT * from Product;
