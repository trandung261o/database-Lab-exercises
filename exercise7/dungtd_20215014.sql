--1. (2 đ) Tạo các bảng trong cơ sở dữ liệu. Cần đảm bảo các ràng buộc trong cơ sở dữ liệu được thỏa mãn. satisfied.
CREATE TABLE Book (
	book_id char(10) PRIMARY KEY,
	title char(50) NOT NULL,
	publisher char(20) NOT NULL,
	published_year integer CHECK(published_year > 1900),
	total_number_of_copies integer CHECK(total_number_of_copies >= 0),
	current_number_of_copies integer CHECK(current_number_of_copies >= 0),
	CHECK(total_number_of_copies >= current_number_of_copies)
);

CREATE TABLE Borrower(
	borrower_id char(10) PRIMARY KEY,
	name char(50) NOT NULL,
	address text,
	telephone_number char(12)
);

CREATE TABLE BorrowCard(
	card_id serial PRIMARY KEY,
	borrower_id char(10),
	borrow_date date NOT NULL,
	expected_return_date date NOT NULL,
	actual_return_date date,
	FOREIGN KEY (borrower_id) REFERENCES Borrower(borrower_id)
);

CREATE TABLE BorrowCardItem (
	card_id int,
	book_id char(10),
	number_of_copies int,
	PRIMARY KEY(card_id, book_id),
	FOREIGN KEY (card_id) REFERENCES BorrowCard(card_id),
	FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

--2. (1 đ) Liệt kê các cuốn sách xuất bản trong năm 2020 bởi nhà xuất bản Wiley.
select * from book
where published_year = 2020 and publisher = 'Wiley';

--3. (1 đ) Liệt kê tổng số đầu sách trong thư viện cho từng nhà xuất bản (publisher, total)
select book.publisher, sum(total_number_of_copies) as total from book
group by book.publisher;

--4. (1 đ) Liệt kê top 5 cuốn sách (ID, title) “hottest” trong năm 2020 (top 5 cuốn sách được mượn nhiều nhất trong năm 2020)
select book.book_id, book.title
from borrowcarditem join book using (book_id) join borrowcard using (card_id) 
where extract(year from borrow_date) = 2020
group by book.book_id, book.title
order by count(*) desc
limit 5;

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

--8. (1 đ) Thêm 10 copies cho 5 cuốn sách được mượn nhiều nhất của nhà xuất bản Wiley
update book
set total_number_of_copies = total_number_of_copies + 10,
	current_number_of_copies = current_number_of_copies + 10
where book_id in (
	select book_id from book where publisher = 'Wiley'
	order by current_number_of_copies desc
	limit 5
);

--9. (1 đ) Liệt kê các bạn đọc (id, name) mượn sách của cả nhà xuất bản Wiley và nhà xuất bản Addison-Wesle
select distinct borrower.borrower_id, borrower.name 
from borrower join borrowcard using (borrower_id)
			  join borrowcarditem using (card_id)
			  join book using (book_id)
where book.publisher = 'Wiley'
	INTERSECT
select distinct borrower.borrower_id, borrower.name 
from borrower join borrowcard using (borrower_id)
			  join borrowcarditem using (card_id)
			  join book using (book_id)
where book.publisher = 'Addison-Wesle';
