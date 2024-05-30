--1
SELECT prod_id, title 
FROM products 
WHERE category = (
    SELECT category 
    FROM categories 
    WHERE categoryname = 'Documentary'
);

--2
SELECT prod_id, title, price
FROM products
WHERE LOWER(title) LIKE '%apollo%' AND price < 10;

--3
SELECT c.category, c.categoryname
FROM categories c
LEFT JOIN products p ON c.category = p.category
LEFT JOIN orderlines ol ON p.prod_id = ol.prod_id
WHERE ol.prod_id IS NULL;

--3 ver 2 --nguyen thi oanh???
select * from categories
where category not in(select distinct p.category
						from orderlines as ol join products as p on ol.prod_id = p.prod_id);

--4
SELECT DISTINCT country
FROM customers c
JOIN orders o ON c.customerid = o.customerid
ORDER BY country;

--5
SELECT COUNT(*) AS number_of_customers
FROM customers
WHERE country = 'Germany';

--6--nguyen thi oanh chua
select count(customerid) 
	from
	(select distinct customerid from orders) as ordersshort

--ver2	
select count(distinct customerid) 
	from orders


--7--nguyen thi oanh
select country, count(distinct o.customerid), count(o.customerid)
from customers c left join orders o on c.customerid = o.customerid
group by c.country;


--8--nguyen thi oanh
select c.customerid, firstname, lastname
from customers c, orders o, orderlines ol, products p
where c.customerid = o.customerid and o.orderid = ol.orderid
	and ol.prod_id = p.prod_id
	and (title = 'AIRPORT ROBBERS' or title = 'AGENT ORDER')
group by c.customerid having count (distinct p.title) >= 2;

--9
SELECT 
    ol.orderlineid, 
    ol.prod_id, 
    p.title AS product_title, 
    ol.quantity, 
    p.price, 
    (ol.quantity * p.price) AS amount
FROM 
    orderlines ol
JOIN 
    products p ON ol.prod_id = p.prod_id
WHERE 
    ol.orderid = 942;

--10
SELECT 
    MAX(totalamount) AS max_totalamount,
    MIN(totalamount) AS min_totalamount,
    AVG(totalamount) AS avg_totalamount
FROM 
    orders;

--11

SELECT 
    c.categoryname,
    cu.gender,
    COUNT(ol.orderlineid) AS purchase_count
FROM 
    customers cu
JOIN 
    orders o ON cu.customerid = o.customerid
JOIN 
    orderlines ol ON o.orderid = ol.orderid
JOIN 
    products p ON ol.prod_id = p.prod_id
JOIN 
    categories c ON p.category = c.category
GROUP BY 
    c.categoryname, cu.gender
ORDER BY 
    purchase_count DESC;

--12
SELECT 
    c.customerid, 
    c.firstname, 
    c.lastname, 
    SUM(o.totalamount) AS total_spent
FROM 
    customers c
JOIN 
    orders o ON c.customerid = o.customerid
GROUP BY 
    c.customerid, 
    c.firstname, 
    c.lastname
HAVING 
    SUM(o.totalamount) > 2000;

--13
SELECT 
    p.prod_id, 
    p.title
FROM 
    orderlines ol
JOIN 
    products p ON ol.prod_id = p.prod_id
WHERE 
    ol.orderdate = CURRENT_DATE;

--14
SELECT 
    p.title, 
    i.quan_in_stock
FROM 
    products p
JOIN 
    inventory i ON p.prod_id = i.prod_id
LEFT JOIN 
    orderlines ol ON p.prod_id = ol.prod_id 
    AND EXTRACT(MONTH FROM ol.orderdate) = 12 
    AND EXTRACT(YEAR FROM ol.orderdate) = 2004
WHERE 
    ol.prod_id IS NULL;

--15
SELECT 
    p.prod_id, 
    p.title, 
    SUM(ol.quantity) AS total_sold
FROM 
    products p
JOIN 
    orderlines ol ON p.prod_id = ol.prod_id
WHERE 
    EXTRACT(MONTH FROM ol.orderdate) = 12 
    AND EXTRACT(YEAR FROM ol.orderdate) = 2004
GROUP BY 
    p.prod_id, p.title
ORDER BY 
    total_sold DESC
--LIMIT 1;

--16
CREATE VIEW frequent_customers AS
SELECT 
    c.customerid, 
    c.firstname, 
    c.lastname, 
    c.address1, 
    c.address2, 
    c.city, 
    c.state, 
    c.zip, 
    c.country, 
    c.region, 
    c.income, 
    c.gender
FROM 
    customers c
JOIN 
    orders o ON c.customerid = o.customerid
WHERE 
    (
        SELECT COUNT(*) 
        FROM orders o2 
        WHERE o2.customerid = c.customerid
    ) > 2
AND 
    (
        SELECT MAX(EXTRACT(YEAR FROM o3.orderdate))
        FROM orders o3 
        WHERE o3.customerid = c.customerid
    ) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
    c.customerid, 
    c.firstname, 
    c.lastname, 
    c.address1, 
    c.address2, 
    c.city, 
    c.state, 
    c.zip, 
    c.country, 
    c.region, 
    c.income, 
    c.gender;
