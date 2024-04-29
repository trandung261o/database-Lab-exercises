    Student:
    StudentID    Name       Address
    ------------------------------------
    1108         Robert     Kew
    3936         Glen       Bundoora
    8507         Norman     Bundoora
    8452         Mary       Balwyn

    Takes:
    StudentID    SubjectCode
    -------------------------------------
    1108         21
    1108         23
    8507         23
    8507         29

    Enrol:
    StudentID    CourseID
    --------------------------------------
    3936         101
    1108         113
    8507         101

    Course:
    CourseID     Name       Faculty
    --------------------------------------
    113          BCS        CSCE
    101          MCS        CSCE

    Subject:
    SubjectCode   Name         Faculty
    ---------------------------------------
    21            Systems      CSCE
    23            Database     CSCE
    29            VB           CSCE
    18            Algebra      Maths

- tìm thông tin từ cột Name của bảng Student
- tìm thông tin của các sinh viên có địa chỉ ở 'Bundoora'
- đưa ra danh sách tên các khoa (Faculty) tương ứng với các khóa học (Course). Mỗi giá trị chỉ hiển thị một lần
- đưa ra danh sách mã sinh viên (StudentID), tên sinh viên (Name), thành phố (Address), mã khóa học (CourseID)
- đưa ra danh sách tên các sinh viên theo thứ tự tăng dần
- đưa ra tên các SV nhóm theo thành phố của SV đó
- đưa ra tên các thành phố có nhiều hơn 3 SV
- đưa ra danh sách tên các môn học không có SV nào tham dự
