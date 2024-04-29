Given the database consisting of the following relations:

    Supplier:
    sid	sname	size	city
    S1	Dustin	100	London
    S2	Rusty	70	Paris
    S3	Lubber	120	London
    S4      M&M     60      NewYork
    S5      MBI     1000    NewOrlean
    S6      Panda   150     London
    
    Product:
    pid	pname	    colour
    P1	Screw	    red
    P2	Screw	    green
    P3	Nut	    red
    P4	Bolt	    blue
    P5      Plier       green
    P6      Scissors    blue
    
    SupplyProduct:
    sid	pid	quantity
    S1	P1	500
    S1	P2	400
    S1	P3	100
    S2	P2	200
    S3	P4	100
    S2	P3	155
    S3      P1      300
    S3      P2      350
    S3      P6      200
    S4      P1      10
    S5      P2      200

- thêm cột: price, kiểu DL real vào bảng SupplyProduct
- xóa cột: price trong bảng SupplyProduct
- sửa cột: kiểu DL của sname thành varchar(20)
- Đưa ra tên của các mặt hàng
- Đưa ra tên khác nhau của các mặt hàng
- Đưa ra toàn bộ thông tin về các hãng cung ứng
- Đưa ra mã số hãng cung ứng, mã mặt hàng được cung ứng và 10 lần số lượng mặt hàng đã được cung ứng
- đưa ra tên của các hãng cung ứng có trụ sở tại London
- đưa ra mã số và tên của các hãng cung ứng nằm ở London và có số nhân viên lớn hơn 75
-đưa ra thông tin của các hãng cung ứng có số nhân viên trong khoảng từ 100 đến 150
- đưa ra mã số của hãng cung ứng mặt hàng P1 hoặc P2
- đưa ra thông tin của hãng sản xuất có trụ sở đặt tại thành phố bắt đầu bằng chữ New
- đưa ra tên và số nhân viên của các hãng cung ứng ở Paris
- đưa ra tên của hãng có cung ứng mặt hàng P1
- đưa ra tên và mã số của hãng cung ứng ít nhất một mặt hàng màu đỏ
- tìm sid của hãng cung ứng đồng thời 2 mặt hàng P1 và P2
- tìm mã số của hãng không cung ứng mặt hàng nào
- tìm thông tin hãng cung ứng có số nhân viên lớn nhất
- tìm sid của hãng cung ứng đồng thời 2 mặt hàng P1 và P2
- đưa ra sid của hãng không cung ứng mặt hàng P3
- đưa ra sid của hãng cung ứng một mặt hàng với số lượng bằng ít nhất 1 trong số lượng các mặt hàng được cung ứng bởi S2	
- đưa ra thông tin của các hãng cung ứng đã cung ứng ít nhất một mặt hàng
- đưa ra thông tin của hãng không cung ứng mặt hàng nào
- có bao nhiêu mặt hàng khác nhau được cung ứng
- có tổng cộng bao nhiêu nhân viên làm cho các hãng ở Paris
- đưa ra số lượng mặt hàng trung bình mà hãng S1 cung ứng
- đưa ra tên của hãng S1 và tổng số lượng các mặt hàng mà hãng đó cung ứng 
- đưa ra mã số các hãng cung ứng và số lượng trung bình các mặt hàng được cung ứng bởi từng hãng
- đưa ra mã số các hãng cung ứng mà số lượng mặt hàng trung bình được cung cấp bởi hãng đó là trong khoảng từ 75 đến 100
- Sửa dữ liệu: hãng S1 chuyển tới Milan
- tất cả mặt hàng được cung cấp với số lượng < 100 đều tăng số lượng lên 1.5 lần


