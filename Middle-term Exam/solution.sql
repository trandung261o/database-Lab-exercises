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

--4
SELECT DISTINCT country
FROM customers c
JOIN orders o ON c.customerid = o.customerid
ORDER BY country;

--5
SELECT COUNT(*) AS number_of_customers
FROM customers
WHERE country = 'Germany';

--6
