cho các quan hệ sau:

    Supplier:
    sid	sname	size	city
    S1	Dustin	100	London
    S2	Rusty	70	Paris
    S3	Lubber	120	London
    
    Product:
    pid	pname	colour
    P1	Screw	red
    P2	Screw	green
    P3	Nut	red
    P4	Bolt	blue
    
    
    SupplyProduct:
    sid	pid	quantity
    S1	P1	500
    S1	P2	400
    S1	P3	100
    S2	P2	200
    S3	P4	100
    S2	P3	155

1) Đưa ra {sid,sname,size,city} của các Supplier có trụ sở tại London
2) Đưa ra {pname} của tất cả các mặt hàng
3) Đưa ra {sid} của các Supplier cung cấp mặt hàng P1 hoặc P2
4) Đưa ra {sname} của các Supplier cung cấp mặt hàng P3
5) Đưa ra {sname} của các hãng cung ứng ít nhất một mặt hàng màu đỏ
6) Đưa ra {sname} của các hãng cung ứng tất cả các mặt hàng màu đỏ
7) Đưa ra {sname} của các hãng có cung ứng mặt hàng màu đỏ hoặc màu xanh
8) Đưa ra {sname} của các hãng cung ứng ít nhất một mặt hàng màu đỏ và ít nhất một mặt hàng màu xanh
9) Đưa ra {sid} của các hãng không cung ứng mặt hàng nào
