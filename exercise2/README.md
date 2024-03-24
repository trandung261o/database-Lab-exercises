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

REPRESENT THE FOLLOWING QUERIES USING RELATIONAL ALGEBRA EXPRESSIONS:

1. Retrieve {sid, sname, size, city} of Suppliers located in London.
2. Retrieve {pname} of all products.
3. Retrieve {sid} of Suppliers supplying either product P1 or P2.
4. Retrieve {sname} of Suppliers supplying product P3.
5. Retrieve {sname} of Suppliers supplying at least one red-colored product.
6. Retrieve {sid} of Suppliers supplying all red-colored products.
7. Retrieve {sname} of Suppliers supplying products in red or green color.
8. Retrieve {sname} of Suppliers supplying at least one red-colored product and at least one green-colored product.
9. Retrieve {sid} of Suppliers not supplying any product.
