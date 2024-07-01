#define _CRT_SECURE_NO_WARNINGS // Để sử dụng scanf_s trên một số môi trường POSIX

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libpq-fe.h>

void do_exit(PGconn* conn) {
    PQfinish(conn);
    exit(1);
}

void add_customer(PGconn* conn) {
    int makh;
    char ho[11], ten[11], gioitinh[9], ngaysinh[11], diachi[201], phone[11];

    printf("Enter Ma Khach hang: "); scanf_s("%d", &makh);
    printf("Enter Ho: ");
    scanf_s("%10s", ho, sizeof(ho)); getchar();
    printf("Enter Ten: ");
    scanf_s("%10s", ten, sizeof(ten)); getchar();
    printf("Enter GioiTinh: ");
    scanf_s("%8s", gioitinh, sizeof(gioitinh)); getchar();
    printf("Enter NgaySinh (YYYY-MM-DD): ");
    scanf_s("%10s", ngaysinh, sizeof(ngaysinh)); getchar();
    printf("Enter DiaChi: ");
    scanf_s("%200[^\n]s", diachi, sizeof(diachi)); getchar();
    printf("Enter Phone: ");
    scanf_s("%10s", phone, sizeof(phone)); getchar();

    char query[512];
    snprintf(query, sizeof(query),
        "INSERT INTO khachhang (makh, ho, ten, gioitinh, ngaysinh, diachi, phone) VALUES (%d, '%s', '%s', '%s', '%s', '%s', '%s')",
        makh, ho, ten, gioitinh, ngaysinh, diachi, phone);

    PGresult* res = PQexec(conn, query);

    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        fprintf(stderr, "INSERT failed: %s\n", PQerrorMessage(conn));
    }

    PQclear(res);
}

void delete_customer(PGconn* conn) {
    int makh;

    printf("Enter MaKhachHang to delete: ");
    scanf_s("%d", &makh); getchar();

    char query[256];
    snprintf(query, sizeof(query), "DELETE FROM khachhang WHERE makh = %d", makh);

    PGresult* res = PQexec(conn, query);

    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        fprintf(stderr, "DELETE failed: %s\n", PQerrorMessage(conn));
    }

    PQclear(res);
}

void add_booking(PGconn* conn) {
    int madatphong, makh, maphong;
    char ngaynhanphong[11], ngaytraphong[11];

    printf("Enter MaDatPhong: ");
    scanf_s("%d", &madatphong);
    printf("Enter MaKhachHang: ");
    scanf_s("%d", &makh);
    printf("Enter MaPhong: ");
    scanf_s("%d", &maphong);
    printf("Enter NgayNhanPhong (YYYY-MM-DD): ");
    scanf_s("%10s", ngaynhanphong, sizeof(ngaynhanphong)); getchar();
    printf("Enter NgayTraPhong (YYYY-MM-DD): ");
    scanf_s("%10s", ngaytraphong, sizeof(ngaytraphong)); getchar();

    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO datphong (madatphong, makh, maphong, ngaynhanphong, ngaytraphong) VALUES (%d, %d, %d, '%s', '%s')",
        madatphong, makh, maphong, ngaynhanphong, ngaytraphong);

    PGresult* res = PQexec(conn, query);

    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        fprintf(stderr, "INSERT failed: %s\n", PQerrorMessage(conn));
    }

    PQclear(res);
}

void add_service_usage(PGconn* conn) {
    int masddv, makh, madv;
    char ngaysddv[11];

    printf("Enter MaSuDungDichVu: ");
    scanf_s("%d", &masddv);
    printf("Enter MaKhachHang: ");
    scanf_s("%d", &makh);
    printf("Enter MaDichVu: ");
    scanf_s("%d", &madv);
    printf("Enter NgaySuDungDichVu (YYYY-MM-DD): ");
    scanf_s("%10s", ngaysddv, sizeof(ngaysddv)); getchar();

    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO sudungdv (masddv, makh, madv, ngaysddv) VALUES (%d, %d, %d, '%s')",
        masddv, makh, madv, ngaysddv);

    PGresult* res = PQexec(conn, query);

    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        fprintf(stderr, "INSERT failed: %s\n", PQerrorMessage(conn));
    }

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
        if (strcmp(PQfname(res, i), "diachi") == 0) {
            printf("%-35s", PQfname(res, i));
            continue;
        }
        printf("%-15s", PQfname(res, i));
    }
    printf("\n");

    int ntuples = PQntuples(res);
    for (int i = 0; i < ntuples; i++) {
        for (int j = 0; j < nfields; j++) {
            if (strcmp(PQfname(res, j), "diachi") == 0) {
                printf("%-35s", PQgetvalue(res, i, j));
                continue;
            }
            printf("%-15s", PQgetvalue(res, i, j));
        }
        printf("\n");
    }

    PQclear(res);
}

int main() {
    const char* conninfo = "dbname=project3 user=postgres password=123456 hostaddr=127.0.0.1 port=5432";
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
        printf("- Them khach su dung dich vu\n\n");
        printf("- Exit\n\n");
        printf("Nhap lua chon: ");
        scanf_s("%99[^\n]s", choice, sizeof(choice)); getchar();

        if (strcmp(choice, "Xem khach hang") == 0) { show_table(conn, "khachhang"); }
        else if (strcmp(choice, "Xem phong") == 0) { show_table(conn, "phongnghi"); }
        else if (strcmp(choice, "Xem dat phong") == 0) { show_table(conn, "datphong"); }
        else if (strcmp(choice, "Xem dich vu") == 0) { show_table(conn, "dichvu"); }
        else if (strcmp(choice, "Xem su dung dich vu") == 0) { show_table(conn, "sudungdv"); }
        else if (strcmp(choice, "Them khach hang") == 0) add_customer(conn);
        else if (strcmp(choice, "Xoa khach hang") == 0) delete_customer(conn);
        else if (strcmp(choice, "Them khach dat phong") == 0) add_booking(conn);
        else if (strcmp(choice, "Them khach su dung dich vu") == 0) add_service_usage(conn);
    } while (strcmp(choice, "Exit") != 0);

    PQfinish(conn);
    return 0;
}
