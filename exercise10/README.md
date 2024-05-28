Trong eduDB

1. cho một classID, viết một hàm tên là "number_of_students" dùng để tính toán số sinh viên trong lớp này
- thử gọi hàm này bằng tài khoản superuser
- tạo một tài khoản tên là: joe, mk: 12345678
- đăng nhập bằng tk joe và thực thi hàm number_of_students(a_class_id)
- đăng nhập bằng tk superuser và trao quyền thực thi hàm cho joe
- đăng nhập bằng tk joe và thực thi lại hàm number_of_students(a_class_id)
2. thêm thuộc tính mới (named: number_students, datatype: integer) vào bảng clazz để lưu số sinh viên trong lớp
- viết một hàm (update_number_students()) dùng để tính toán số sinh viên mỗi lớp và cập nhật giá trị đúng vào thuộc tính number_students
- kiểm tra giá trị của thuộc tính này trước và sau khi gọi hàm update_number_students()
   
