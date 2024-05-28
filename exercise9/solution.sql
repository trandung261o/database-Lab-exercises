create table store.customer (
	customerid char(6) primary key,
	lastname varchar,
	firstname varchar,
	address varchar,
	city varchar, 
	state char(2),
	zip char(5),
	phone varchar
)

create table store.product (
	productid char(6) not null primary key,
	productname varchar,
	model varchar,
	manufacturer varchar,
	unitprice money,
	inventory int4
)

create table store.order (
	orderid char(6) not null primary key,
	customerid char(6) not null,
	productid char(6) not null,
	purchasedate date,
	quantity int4,
	totalcost money,
	foreign key (customerid) references store.customer(customerid),
	foreign key (productid) references store.product(productid)
)

------------------------------------VIEW---------------------------------------------
--tạo view customer_order
create view customer_order as
	select c.firstname, c.lastname, p.productid, p.productname, o.quantity
	from store.customer c, store.order o, store.product p
	where c.customerid = o.customerid and o.productid = p.productid;

--hiển thị toàn bộ thông tin view customer_order
select * from customer_order;

--chèn thông tin vào view customer_order (lỗi)
insert into customer_order values('Nam', 'Vu', 'LAP002', 'HP AZE', 5);

--tạo view chỉ làm việc trên 1 bảng (có thể cập nhật được)
create view sub_customer as
	select c.customerid, c.firstname, c.lastname
	from store.customer c
	where c.city = 'Hammond';

select * from sub_customer;
select * from store.customer;

--cập nhật view sub_customer
update sub_customer set lastname = 'Frank'
where customerid = 'WIL001';

--
insert into sub_customer values ('AA001', 'Oanh', 'Nguyen');
delete from sub_customer where customerid = 'AA001';

----------------------------------------FUNCTION----------------------------------------
CREATE OR REPLACE FUNCTION store.test(IN val1 int4, IN val2 int4, OUT result int4) AS
$$ DECLARE vmultiplier int4 := 3;
BEGIN
	result := val1 * vmultiplier + val2;
END; $$
LANGUAGE plpgsql
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY INVOKER;
--

SELECT store.test(2, 5);

SELECT store.test(NULL, 5);

GRANT USAGE ON SCHEMA store TO joe;

GRANT EXECUTE ON FUNCTION store.test TO joe;

--
CREATE OR REPLACE FUNCTION store.extended_sales(p_itemno char(6)) 
RETURNS TABLE(quantity int, total money) AS $$
BEGIN
	RETURN QUERY SELECT s.quantity, s.totalcost
				FROM store.order AS s
				WHERE s.productid = p_itemno;
END;
$$ LANGUAGE plpgsql
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY DEFINER;
--

SELECT * FROM store.order;

SELECT store.extended_sales('LAP001');
