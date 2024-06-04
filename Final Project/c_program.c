#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdlib.h>
#include <libpq-fe.h>

void do_exit(PGconn* conn) {
    PQfinish(conn);
    exit(1);
}

void add_customer(PGconn* conn) {
    
    int makh;
    char ho[51], ten[51], gioitinh[9], ngaysinh[11], diachi[201];
    
    printf("Enter Ma Khach hang: "); scanf_s("%d", &makh);
    printf("Enter Ho: ");
    scanf_s("%50s", ho, (unsigned)_countof(ho)); getchar();
    printf("Enter Ten: ");
    scanf_s("%[^\n]s", ten, (unsigned)_countof(ten)); getchar();
    printf("Enter GioiTinh: ");
    scanf_s("%8s", gioitinh, (unsigned)_countof(gioitinh)); getchar();
    printf("Enter NgaySinh (YYYY-MM-DD): ");
    scanf_s("%10s", ngaysinh, (unsigned)_countof(ngaysinh)); getchar();
    printf("Enter DiaChi: ");
    scanf_s("%[^\n]s", diachi, (unsigned)_countof(diachi)); getchar();


    char query[512];
    snprintf(query, sizeof(query),
        "INSERT INTO KhachHang (makhachhang, Ho, Ten, GioiTinh, NgaySinh, DiaChi) VALUES ('%d', '%s', '%s', '%s', '%s', '%s')",
        makh, ho, ten, gioitinh, ngaysinh, diachi);

    PGresult* res = PQexec(conn, query);

    PQclear(res);
}



void delete_customer(PGconn* conn) {
    int makhachhang;

    printf("Enter MaKhachHang to delete: ");
    scanf_s("%d", &makhachhang); getchar();

    char query[256];
    snprintf(query, sizeof(query), "DELETE FROM KhachHang WHERE MaKhachHang = %d", makhachhang);

    PGresult* res = PQexec(conn, query);

    PQclear(res);
}



void add_booking(PGconn* conn) {
    int makhachhang, maphong;
    char ngaynhanphong[11], ngaytraphong[11];

    printf("Enter MaKhachHang: ");
    scanf_s("%d", &makhachhang);
    printf("Enter MaPhong: ");
    scanf_s("%d", &maphong);
    printf("Enter NgayNhanPhong (YYYY-MM-DD): ");
    scanf_s("%s", ngaynhanphong, (unsigned)_countof(ngaynhanphong)); getchar();
    printf("Enter NgayTraPhong (YYYY-MM-DD): ");
    scanf_s("%s", ngaytraphong, (unsigned)_countof(ngaytraphong)); getchar();

    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO DatPhong (MaKhachHang, MaPhong, NgayNhanPhong, NgayTraPhong) VALUES (%d, %d, '%s', '%s')",
        makhachhang, maphong, ngaynhanphong, ngaytraphong);

    PGresult* res = PQexec(conn, query);

    PQclear(res);
}

void add_service_usage(PGconn* conn) {
    int madatphong, madichvu;

    printf("Enter MaDatPhong: ");
    scanf_s("%d", &madatphong);
    printf("Enter MaDichVu: ");
    scanf_s("%d", &madichvu);

    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO SuDungDichVu (MaDatPhong, MaDichVu) VALUES (%d, %d)",
        madatphong, madichvu);

    PGresult* res = PQexec(conn, query);

    PQclear(res);
}

void show_table(PGconn* conn, const char* table_name) {
    char query[256];
    snprintf(query, sizeof(query), "SELECT * FROM %s", table_name);
    PGresult* res = PQexec(conn, query);

    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "SELECT failed: %s\n", PQerrorMessage(conn));
        PQclear(res);
        return;
    }

    int nfields = PQnfields(res);
    for (int i = 0; i < nfields; i++) {
        if (strcmp(PQfname(res, i), "diachi") && strcmp(PQfname(res, i), "tendichvu") && strcmp(PQfname(res, i), "Khach hang")) {
            printf("%-15s", PQfname(res, i));
            continue;
        }
        printf("%-30s", PQfname(res, i));
    }
    printf("\n");

    int ntuples = PQntuples(res);
    for (int i = 0; i < ntuples; i++) {
        for (int j = 0; j < nfields; j++) {
            if (strcmp(PQfname(res, j), "diachi") && strcmp(PQfname(res, j), "tendichvu") && strcmp(PQfname(res, j), "Khach hang")) {
                printf("%-15s", PQgetvalue(res, i, j));
                continue;
            }
            printf("%-30s", PQgetvalue(res, i, j));
        }
        printf("\n");
    }

    PQclear(res);
}


void execute_query(PGconn* conn, const char* query) {
    PGresult* res = PQexec(conn, query);

    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "SELECT failed: %s\n", PQerrorMessage(conn));
        PQclear(res);
        return;
    }

    int nfields = PQnfields(res);
    for (int i = 0; i < nfields; i++) {
        printf("%-30s", PQfname(res, i));
    }
    printf("\n");

    int ntuples = PQntuples(res);
    for (int i = 0; i < ntuples; i++) {
        for (int j = 0; j < nfields; j++) {
            printf("%-30s", PQgetvalue(res, i, j));
        }
        printf("\n");
    }

    PQclear(res);
}



void handle_query_option(PGconn* conn, int option) {
    switch (option) {
    case 1:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Ten khach hang\", sophong AS \"Dat phong\", loaiphong AS \"Loai phong\" FROM khachhang JOIN datphong USING (makhachhang) JOIN phong USING (maphong) ORDER BY \"Ten khach hang\";");
        break;
    case 2:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", sophong AS \"Phong\", ngaynhanphong AS \"Ngay nhan phong\", ngaytraphong AS \"Ngay tra phong\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) ORDER BY \"Khach hang\";");
        break;
    case 3:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", ngaysinh AS \"Sinh nhat\", EXTRACT(year FROM age(ngaysinh)) AS \"So tuoi\" FROM khachhang WHERE makhachhang IN (SELECT makhachhang FROM datphong);");
        break;
    case 4:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", SUM(ngaytraphong - ngaynhanphong) AS \"So ngay o\" FROM khachhang JOIN datphong USING(makhachhang) GROUP BY \"Khach hang\" ORDER BY \"So ngay o\" DESC;");
        break;
    case 5:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", diachi AS \"Dia chi\" FROM khachhang WHERE diachi LIKE '%TP.HCM%';");
        break;
    case 6:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", gioitinh AS \"Gioi tinh\", sophong AS \"Dat phong\", loaiphong AS \"Loai phong\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) WHERE loaiphong = 'Suite' AND gioitinh = 'Male';");
        break;
    case 7:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", ngaynhanphong AS \"Ngay nhan phong\" FROM khachhang JOIN datphong USING(makhachhang) WHERE khachhang.ho = 'Nguyen' AND EXTRACT(month FROM ngaynhanphong) = 5 AND EXTRACT(year FROM ngaynhanphong) = 2024;");
        break;
    case 8:
        execute_query(conn, "SELECT loaiphong AS \"Loai phong\", COUNT(sophong) AS \"So phong\" FROM phong GROUP BY loaiphong;");
        break;
    case 9:
        execute_query(conn, "SELECT loaiphong AS \"Loai phong\", AVG(ngaytraphong - ngaynhanphong) AS \"TB Ngay o\" FROM phong JOIN datphong USING(maphong) GROUP BY loaiphong;");
        break;
    case 10:
        execute_query(conn, "SELECT sophong AS \"Phong\", loaiphong AS \"Loai phong\", ho || ' ' || ten AS \"Khach hang\", EXTRACT(year FROM age(ngaysinh)) AS \"So tuoi\" FROM datphong JOIN phong USING(maphong) JOIN khachhang USING(makhachhang) WHERE EXTRACT(year FROM age(ngaysinh)) BETWEEN 30 AND 35 AND loaiphong = 'Double';");
        break;
    case 11:
        execute_query(conn, "SELECT loaiphong AS \"Loai phong\", COUNT(sophong) AS \"So phong duoc dat\" FROM datphong JOIN phong USING(maphong) WHERE EXTRACT(month FROM ngaynhanphong) = 6 GROUP BY loaiphong;");
        break;
    case 12:
        execute_query(conn, "SELECT sophong AS \"So phong\", loaiphong AS \"Loai phong\", gia AS \"Gia phong\" FROM phong WHERE maphong NOT IN (SELECT maphong FROM datphong);");
        break;
    case 13:
        execute_query(conn, "SELECT sophong AS \"So phong\", ngaynhanphong AS \"Ngay nhan phong\" FROM phong JOIN datphong USING(maphong) WHERE EXTRACT(month FROM ngaynhanphong) = 7 AND EXTRACT(year FROM ngaynhanphong) = 2024;");
        break;
    case 14:
        execute_query(conn, "SELECT maphong, sophong, loaiphong, COUNT(datphong.madatphong) AS \"So lan duoc dat\" FROM phong LEFT JOIN datphong USING(maphong) GROUP BY maphong, sophong, loaiphong ORDER BY \"So lan duoc dat\" DESC;");
        break;
    case 15:
        execute_query(conn, "SELECT sophong AS \"So phong\", loaiphong AS \"Loai phong\", ngaynhanphong AS \"Ngay nhan phong\", ngaytraphong AS \"Ngay tra phong\", ho || ' ' || ten AS \"Khach hang dat phong\" FROM phong JOIN datphong USING(maphong) JOIN khachhang USING(makhachhang) WHERE ngaytraphong - ngaynhanphong < 10 AND loaiphong = 'Suite';");
        break;
    case 16:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", diachi AS \"Dia chi\", madatphong AS \"Ma dat phong\", sophong AS \"Dat phong\", ngaynhanphong AS \"Ngay nhan phong\", ngaytraphong AS \"Ngay tra phong\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) WHERE diachi LIKE '%Ha Noi%' OR diachi LIKE '%Thanh Hoa%';");
        break;
    case 17:
        execute_query(conn, "SELECT tendichvu AS \"Dich vu\", gia AS \"Gia\" FROM dichvu ORDER BY gia DESC LIMIT 3;");
        break;
    case 18:
        execute_query(conn, "SELECT tendichvu AS \"Dich vu\", gia AS \"Gia\" FROM dichvu WHERE gia BETWEEN 200000 AND 500000;");
        break;
    case 19:
        execute_query(conn, "SELECT sophong AS \"Phong\", tendichvu AS \"Dich vu da su dung\" FROM datphong JOIN sudungdichvu USING(madatphong) JOIN dichvu USING(madichvu) JOIN phong USING(maphong);");
        break;
    case 20:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", sophong AS \"Phong\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) LEFT JOIN sudungdichvu USING(madatphong) WHERE sudungdichvu.masudungdichvu IS NULL;");
        break;
    case 21:
        execute_query(conn, "SELECT tendichvu AS \"Dich vu\", COUNT(*) AS \"So lan su dung\" FROM sudungdichvu JOIN dichvu USING(madichvu) GROUP BY tendichvu ORDER BY \"So lan su dung\" DESC;");
        break;
    case 22:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", sophong AS \"Phong\", COUNT(sudungdichvu.madichvu) AS \"So dich vu su dung\" FROM khachhang JOIN datphong USING(makhachhang) JOIN sudungdichvu USING(madatphong) JOIN phong USING(maphong) GROUP BY \"Khach hang\", \"Phong\" ORDER BY \"So dich vu su dung\" DESC LIMIT 3;");
        break;
    case 23:
        execute_query(conn, "SELECT tendichvu, sudungdichvu.madichvu FROM dichvu LEFT JOIN sudungdichvu USING(madichvu) WHERE sudungdichvu.madichvu IS NULL;");
        break;
    case 24:
        execute_query(conn, "SELECT sophong AS \"Phong\", ho || ' ' || ten AS \"Khach hang\", tendichvu AS \"Dich vu\" FROM sudungdichvu JOIN datphong USING(madatphong) JOIN dichvu USING(madichvu) JOIN khachhang USING(makhachhang) JOIN phong USING(maphong) WHERE tendichvu = 'Breakfast' AND gioitinh = 'Female';");
        break;
    case 25:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", maphong AS \"Ma phong\", sophong AS \"Phong\", SUM(gia * (ngaytraphong - ngaynhanphong)) AS \"Tong tien phong\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) GROUP BY ho, ten, maphong, sophong ORDER BY \"Tong tien phong\" DESC;");
        break;
    case 26:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", maphong AS \"Ma phong\", sophong AS \"Phong\", SUM(dichvu.gia) AS \"Tong tien dich vu\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) LEFT JOIN sudungdichvu USING(madatphong) LEFT JOIN dichvu USING(madichvu) GROUP BY ho, ten, maphong, sophong ORDER BY \"Tong tien dich vu\" DESC;");
        break;
    case 27:
        execute_query(conn, "SELECT ho || ' ' || ten AS \"Khach hang\", sophong AS \"Phong\", loaiphong AS \"Loai phong\", ngaynhanphong AS \"Ngay nhan phong\", SUM(gia * (ngaytraphong - ngaynhanphong)) AS \"Tong tien phong\" FROM khachhang JOIN datphong USING(makhachhang) JOIN phong USING(maphong) WHERE EXTRACT(month FROM ngaynhanphong) = 6 AND EXTRACT(year FROM ngaynhanphong) = 2024 AND loaiphong = 'Double' GROUP BY ho, ten, loaiphong, sophong, ngaynhanphong ORDER BY \"Tong tien phong\" DESC;");
        break;
    case 28:
        execute_query(conn, "SELECT tendichvu AS \"Dich vu\", COUNT(madatphong) * dichvu.gia AS \"Doanh thu\" FROM sudungdichvu JOIN dichvu USING(madichvu) GROUP BY tendichvu, gia ORDER BY \"Doanh thu\" DESC LIMIT 5;");
        break;
    case 29:
        execute_query(conn, "SELECT sophong AS \"Phong\", loaiphong AS \"Loai phong\", phong.gia * (ngaytraphong - ngaynhanphong) AS \"Doanh thu\" FROM phong JOIN datphong USING(maphong) ORDER BY \"Doanh thu\" DESC LIMIT 5;");
        break;
    case 30:
        execute_query(conn, "SELECT loaiphong AS \"Loai phong\", SUM((ngaytraphong - ngaynhanphong) * phong.gia) AS \"Doanh thu\" FROM phong JOIN datphong USING(maphong) GROUP BY loaiphong;");
        break;
    default:
        printf("Invalid option!\n");
        break;
    }
}




void show_bill(PGconn* conn) {
    show_table(conn, "hoadon");
}

int main() {
    const char* conninfo = "dbname=project user=postgres password=123456 hostaddr=127.0.0.1 port=5432";
    PGconn* conn = PQconnectdb(conninfo);

    if (PQstatus(conn) == CONNECTION_BAD) {
        fprintf(stderr, "Connection to database failed: %s\n", PQerrorMessage(conn));
        do_exit(conn);
    }

    char choice[100];
    do {
        printf("\nMenu:\n");
        printf("- Xem khach hang \t \t");
        printf("- Xem phong \t \t \t");
        printf("- Xem dat phong\n");
        printf("- Xem dich vu \t \t \t");
        printf("- Xem su dung dich vu\n\n");
        printf("- Them khach Hang \t \t");
        printf("- Xoa khach hang \t \t");
        printf("- Them khach dat phong\n");
        printf("- Them khach su dung dich vu \t");
        printf("- Xem hoa don\n\n");
        printf("- 1-30: Chuc nang truy van\t");
        printf("- Exit\n\n");
        printf("Nhap lua chon: ");
        scanf_s("%[^\n]s", choice, (unsigned)_countof(choice)); getchar();

        if (strcmp(choice, "Xem khach hang") == 0) { show_table(conn, "khachhang"); }
        else if (strcmp(choice, "Xem phong") == 0) { show_table(conn, "phong"); }
        else if (strcmp(choice, "Xem dat phong") == 0) { show_table(conn, "datphong"); }
        else if (strcmp(choice, "Xem dich vu") == 0) { show_table(conn, "dichvu"); }
        else if (strcmp(choice, "Xem su dung dich vu") == 0) { show_table(conn, "sudungdichvu"); }
        else if (strcmp(choice, "Them khach hang") == 0) add_customer(conn);
        else if (strcmp(choice, "Xoa khach hang") == 0) delete_customer(conn);
        else if (strcmp(choice, "Them khach dat phong") == 0) add_booking(conn);
        else if (strcmp(choice, "Xem khach su dung dich vu") == 0) add_service_usage(conn);
        else if (strcmp(choice, "Xem hoa don") == 0) show_bill(conn);
        else if (atoi(choice) >= 1 && atoi(choice) <= 30) {
            int query_option = atoi(choice);
            handle_query_option(conn, query_option);
        }   
    } while (strcmp(choice, "Exit") != 0);

    PQfinish(conn);
    return 0;
}
