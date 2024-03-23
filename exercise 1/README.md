    cho cơ sở dữ liệu gồm các quan hệ sau
    
    GiangVien:
    
    GV#	HoTen			DiaChi			NgaySinh
    GV01	Vũ Tuyết Trinh		Hoàng Mai, Hà nội	10/10/1975
    GV02	Nguyễn Nhật Quang	Hai Bà Trưng, Hà Nội	03/11/1976
    GV03	Trần Đức Khánh		Đống Đa, Hà Nội		04/06/1977
    GV04	Nguyễn Hồng Phương	Tây Hồ, Hà Nội		10/12/1983
    GV05	Lê Thanh Hương		Hai Bà Trưng, Hà Nội	10/10/1976
    
    DeTai:
    
    DT#	TenDT			Cap		KinhPhi
    DT01	Tính Toán Lưới		Nhà Nước	700
    DT02	Phát hiện tri thức	Bộ		300
    DT03	Phân loại văn bản	Bộ		270
    DT04	Dịch tự động Anh Việt	Trường		30
    
    ThamGia:
        
    GV#	DT#	SoGio
    GV01	DT01	100
    GV01	DT02	80
    GV01	DT03	80
    GV02	DT01	120
    GV02	DT03	140
    GV03	DT03	150
    GV04	DT04	180
    
    Yêu cầu:
    A. Tạo CSDL có tên là QLKH, tạo các bảng trên và nhập dữ liệu như trên. Chú ý: Hai thuộc tính GV# và DT# 
    trong bảng ThamGia tham chiếu đến thuộc tính cùng tên trong bảng GiangVien và bảng DeTai
    
    B. Hãy viết các câu lệnh SQL để:
     1. Đưa ra thông tin giảng viên có địa chỉ ở quận "Hai Bà Trưng", sắp xếp theo thứ tự giảm dần của họ tên
     2. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài "Tính toán lưới"
     3. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài "Phân loại văn bản" 
     hoặc "Dịch tự động Anh Việt"
     4. Cho biết thông tin giảng viên tham gia ít nhất 2 đề tài
     5. cho biết tên giảng viên tham gia nhiều đề tài nhất
     6. đề tài nào tốn ít kinh phí nhất 
     7. cho biết tên và ngày sinh của giảng viên sống ở quân Tây Hồ và tên các đề tài mà giảng viên này tham gia 
     8. cho biết tên những giảng viên sinh trước năm 1980 và có tham gia đề tài "Phân loại văn bản" 
     9. đưa ra mã giảng viên, tên giảng viên và tổng số giờ tham gia nghiên cứu khoa học của từng giảng viên
     10. giảng viên Ngô Tuấn Phong sinh ngày 8/9/1986 địa chỉ Đống Đa, Hà Nội mới tham gia nghiên cứu đề tài khoa học. 
     hãy thêm thông tin giảng viên này vào bảng GiangVien
     11. Giảng viên Vũ Tuyết Trinh mới chuyển về sống tại quận Tây Hồ, Hà Nội. hãy cập nhật thông tin này
     12. giảng viên có mã GV02 không tham gia bất kỳ đề tài nào nữa. Hãy xóa tất cả thông tin liên quan đến giảng viên này trong CSDL
    
    
    
    
    
    
