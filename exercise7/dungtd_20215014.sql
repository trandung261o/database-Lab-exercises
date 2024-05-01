--2. (1 đ) Liệt kê các cuốn sách xuất bản trong năm 2020 bởi nhà xuất bản Wiley.
select * from book
where published_year = 2020 and publisher = 'Wiley';

--3. (1 đ) Liệt kê tổng số đầu sách trong thư viện cho từng nhà xuất bản (publisher, total)
select book.publisher, sum(total_number_of_copies) as total from book
group by book.publisher;

--5. (1 đ) Liệt kê tất cả bạn đọc (id, name, telephone number, address) chưa trả sách.
select Borrower.borrower_id, name, telephone_number, address 
from Borrower join borrowcard using (borrower_id) 
where actual_return_date is NULL;

--6. (1 đ) Liệt kê tất cả bạn đọc (id, name, telephone number, address) trả sách muộn, sắp xếp theo thứ tự alphabet của tên.
select borrower.borrower_id, name, telephone_number, address
from Borrower join borrowcard using (borrower_id)
where actual_return_date > expected_return_date
order by name;

--7. (1 đ) Xóa những cuốn sách không có ai mượn
delete from book
where book.book_id not in (select book_id from borrowCardItem);
