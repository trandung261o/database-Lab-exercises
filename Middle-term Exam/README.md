Tạo CSDL  "dellstore" và import CSDL từ file sql được cung cấp (dellstore2-normal-1.0.sql) 

Mở CMD:
- psql –h localhost postgres postgres
  
  o create database dellstore;
  
  o \q 
- psql -d dellstore -U postgres -f [path/]dellstore2-normal-1.0.sql 
