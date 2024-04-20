Một thư viện lưu trữ các thông tin về sách, bạn đọc, phiếu mượn sách trong các bảng sau:

Book (book_id, title, publisher, published_year, total_number_of_copies, current_number_of_copies);
- book_id: char(10), primary key
- tittle: char(50), not null
- publisher: char(20), not null
- published_year: integer, > 1900
- total_number_of_copies: integer, >= 0
- current_number_of_copies: integer, >= 0
- total_number_of_copies >= current_number_of_copies

Borrower(borrower_id, name, address, telephone_number);
- borrower_id: char(10), primary key
- name: char(50), not null
- address: text
- telephone_number: char(12)

BorrowCard(card_id, borrower_id, borrow_date, expected_return_date, actual_return_date);
- card_id : int identity, primary key (auto increment)
- borrower_id: char(10), foreign key → Borrower(borrower_id)
- borrow_date: date, not null
- expected_return_date: date, not null
- actual_return_date: date

BorrowCardItem(card_id, book_id, number_of_copies)
- card_id, book_id: primary key
- card_id: foreign key → BorrowCard(card_id)
- book_id: foreign key → Book(book_id)

Hãy viết các câu lệnh SQL thực hiện những công việc sau:

1. (2 đ) Tạo các bảng trong cơ sở dữ liệu. Cần đảm bảo các ràng buộc trong cơ sở dữ liệu được 
thỏa mãn. satisfied.
2. (1 đ) Liệt kê các cuốn sách xuất bản trong năm 2020 bởi nhà xuất bản Wiley.
3. (1 đ) Liệt kê tổng số đầu sách trong thư viện cho từng nhà xuất bản (publisher, total)
4. (1 đ) Liệt kê top 5 cuốn sách (ID, title) “hottest” trong năm 2020 (top 5 cuốn sách được mượn 
nhiều nhất trong năm 2020)
5. (1 đ) Liệt kê tất cả bạn đọc (id, name, telephone number, address) chưa trả sách.
6. (1 đ) Liệt kê tất cả bạn đọc (id, name, telephone number, address) trả sách muộn, sắp xếp theo 
thứ tự alphabet của tên.
7. (1 đ) Xóa những cuốn sách không có ai mượn
8. (1 đ) Thêm 10 copies cho 5 cuốn sách được mượn nhiều nhất của nhà xuất bản Wiley
9. (1 đ) Liệt kê các bạn đọc (id, name) mượn sách của cả nhà xuất bản Wiley và nhà xuất bản 
Addison-Wesley
