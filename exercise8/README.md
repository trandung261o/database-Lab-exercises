Bài tập về VIEW

Dùng các mệnh đề SQL để làm các bài tập sau
1. Tạo một view từ eduDB, đặt tên là student_shortinfos, view này chứa vài thông tin từ bảng student: student_id, firstname, lastname, gender, dob, clazz_id.

   1.1. hiển thị toàn bộ bản ghi của view này.

   1.2. thử insert/update/delete 1 bản ghi vào trong student_shortinfos

   -> kiểm tra xem bản ghi này có được insert/update/delete vào trong bảng student không?

   1.3. giả sử bạn không có quyền truy cập bảng student, nhưng bạn được truy cập view student_shortinfos và bảng clazz, viết mệnh đề SQL để hiển thị

     a) danh sách sinh viên: student_id, fullname, gender và class name.

     b) danh sách lớp (class id, class name) và số học sinh mỗi lớp

   1.4. sửa trường address trong bảng student thành NOT NULL

   -> thử insert 1 bản ghi mới vào view student_shortinfos: kiểm tra xem bản ghi có được insert vào bảng student không?

   1.5. thử thay đổi dob của một sinh viên và kiểm tra xem nó có được cập nhật trên view student_shortinfos không?

   1.6. thử insert 1 bản ghi mới vào bảng table và kiểm tra xem bạn có thể thấy bản ghi mới này trong view student_shortinfos không?

2. tạo một view trong eduDB, đặt tên là student_class_shortinfos, bao gồm: student_id, firstname, lastname, gender, class name.

thử insert/update/delete một bản ghi trong view student_class_shortinfos

-> kiểm tra xem bản ghi này có được insert/update/delete trong bảng student/class không?

3. tạo một view trong eduDB, đặt tên là class_infos, bao gồm: class_id, class name, number of students trong lớp này

   3.1. hiển thị toàn bộ bản ghi trong view này

   3.2. thử insert/update/delete một bản ghi trong view class_infos
