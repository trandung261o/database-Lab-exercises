(DBMS: microsoft sql server management studio)

Given the database consisting of the following relations:
    
    GiangVien:
    MaGV	HoTen			DiaChi			NgaySinh
    GV01	Vũ Tuyết Trinh		Hoàng Mai, Hà nội	10/10/1975
    GV02	Nguyễn Nhật Quang	Hai Bà Trưng, Hà Nội	03/11/1976
    GV03	Trần Đức Khánh		Đống Đa, Hà Nội		04/06/1977
    GV04	Nguyễn Hồng Phương	Tây Hồ, Hà Nội		10/12/1983
    GV05	Lê Thanh Hương		Hai Bà Trưng, Hà Nội	10/10/1976
    
    DeTai:
    MaDT	TenDT			Cap		KinhPhi
    DT01	Tính Toán Lưới		Nhà Nước	700
    DT02	Phát hiện tri thức	Bộ		300
    DT03	Phân loại văn bản	Bộ		270
    DT04	Dịch tự động Anh Việt	Trường		30
    
    ThamGia:       
    MaGV	MaDT	SoGio
    GV01	DT01	100
    GV01	DT02	80
    GV01	DT03	80
    GV02	DT01	120
    GV02	DT03	140
    GV03	DT03	150
    GV04	DT04	180
    
Requirements:

A. Create a database named QLKH, create the tables as above, and input data as described. Note: The attributes MaGV and MaDT in the ThamGia table reference the attributes with the same name in the GiangVien and DeTai tables, respectively.

B. Write SQL statements to:

1. Provide information about professors residing in "Hai Bà Trưng" district, ordered by decreasing alphabetical order of their names.
2. Provide a list of full names, addresses, and dates of birth of professors who participated in the project "Tính toán lưới".
3. Provide a list of full names, addresses, and dates of birth of professors who participated in the projects "Phân loại văn bản" or "Dịch tự động Anh Việt".
4. Indicate the information of professors participating in at least 2 projects.
5. Provide the name of the professor who participated in the most projects.
6. Which project costs the least.
7. Provide the name and date of birth of professors living in Tây Hồ district and the names of the projects they participated in.
8. Provide the names of professors born before 1980 and participated in the project "Phân loại văn bản".
9. List the professor code, professor name, and the total number of hours participating in scientific research for each professor.
10. Professor Ngô Tuấn Phong, born on 8/9/1986, residing in Đống Đa, Hanoi, just joined a scientific research project. Add this information to the GiangVien table.
11. Professor Vũ Tuyết Trinh has recently moved to live in Tây Hồ district, Hanoi. Update this information.
12. Professor with the code GV02 is no longer participating in any projects. Delete all related information about this professor in the database.
13. Provide information about professors who are not participating in any projects.
    
    
    
    
    

