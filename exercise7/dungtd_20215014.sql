--2. (1 đ) Liệt kê các cuốn sách xuất bản trong năm 2020 bởi nhà xuất bản Wiley.
select * from book
where published_year = 2020 and publisher = 'Wiley';

--3. (1 đ) Liệt kê tổng số đầu sách trong thư viện cho từng nhà xuất bản (publisher, total)
select book.publisher, sum(total_number_of_copies) as total from book
group by book.publisher;
