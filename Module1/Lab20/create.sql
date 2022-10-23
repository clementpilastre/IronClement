create database if not exists lab_mysql;
use lab_mysql;

drop table cars;

CREATE TABLE cars
(
    VIN VARCHAR(255) PRIMARY KEY NOT NULL,
    manufacturer VARCHAR(255),
    model VARCHAR(255),
    year date,
    color VARCHAR(255)
);
CREATE TABLE customers
(
    customer_id int PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    adress VARCHAR(255),
    city VARCHAR(255),
    state_province VARCHAR(255),
    country VARCHAR(255),
    postal VARCHAR(255)
);
CREATE TABLE salespersons
(
    staff_id VARCHAR(255) PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    store VARCHAR(255)
);

CREATE TABLE invoices
(
    invoice_ID VARCHAR(255) PRIMARY KEY NOT NULL,
    date VARCHAR(255),
    staff_id VARCHAR(255), 
    foreign key(staff_id) references salespersons(staff_id),
    customer_id int, 
    foreign key (customer_id) references customers(customer_id),
    VIN VARCHAR(255), 
    foreign key(VIN) references cars(VIN)
);