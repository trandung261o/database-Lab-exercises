Tạo CSDL  "dellstore" và import CSDL từ file sql được cung cấp (dellstore2-normal-1.0.sql) 

Mở CMD:
- psql –h localhost postgres postgres

(psql [options] [databasename [username]])
  
  o create database dellstore;
  
  o \q 
- psql -d dellstore -U postgres -f [path/]dellstore2-normal-1.0.sql
#### Hãy viết các câu lệnh SQL cho các yêu cầu sau: 
1. Đưa ra danh sách các sản phẩm (prod_id, title) thuộc loại (category) "Documentary". 
2. Đưa ra danh sách các sản phẩm mà tiêu đề (title) có chứa "Apollo" (không quan trọng chữ hoa, chữ 
thường) và có giá ít hơn 10$. 
3. Đưa ra danh sách loại sản phẩm mà không có mặt hàng nào được đặt mua. 
4. Đưa ra danh sách tên các nước có khách hàng đã đặt hàng. Sắp xếp theo thứ tự alphabet. 
5. Cho biết có bao nhiêu khách hàng từ "Germany"? 
6. Hãy cho biết có bao nhiêu khách hàng khác nhau đã từng mua ít nhất 1 sản phẩm. 
7. Đưa ra danh sách tên nước, số lượng khách hàng và số lượt khách hàng đã mua hàng đến từ mỗi 
nước. 
8. Đưa ra danh sách các khách hàng (mã khách hàng, họ và tên) đã mua cả hai sản phẩm có title 
"AIRPORT ROBBERS" và " AGENT ORDER" (không phân biệt chữ hoa, chữ thường). 
9. Đưa ra thông tin chi tiết về sản phẩm trong hóa đơn có mã số 942. Thông tin chi tiết: orderlineid, 
prod_id, product title, quantiy, price, amount. 
10. Hiển thị ra tổng tiền (totalamount) lớn nhất, nhỏ nhất, và trung bình trên hóa đơn. 
11. Đưa ra thống kê theo giới tính về số lượt khách hàng mua cho mỗi loại sản phẩm (category). Sắp 
xếp giảm dần  theo số lượt mua của loại sản phẩm. 
12. Đưa ra danh sách khách hàng đã có tổng hóa đơn mua hàng vượt quá 2.000. 
13. Lập danh sách các sản phẩm đã được mua trong ngày (orderdate) (ngày lập danh sách). 
14. Đưa ra danh sách tên các mặt hàng và số lượng tồn của các mặt hàng không có người mua trong 
tháng 12/2004. 
15. Đưa ra danh sách sản phẩm (prod_id, title, số lượng đã bán) bán chạy nhất (sản phẩm được bán 
với số lượng lớn nhất) trong tháng 12/2004. 
16. Hãy tạo ra 1 view chưa thông tin khách hàng thường xuyên của cửa hàng: thông tin gồm mã số 
khách hàng, họ  tên, địa chỉ, thu nhập (income), giới tính (gender). Khách hàng thường xuyên là 
khách hàng có số lần mua nhiều hơn 2 lần và lần mua gần nhất là trong năm hiện tại.
