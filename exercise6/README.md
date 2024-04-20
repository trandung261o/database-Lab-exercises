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
