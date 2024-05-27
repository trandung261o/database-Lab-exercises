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
