USE Practice7;
-- SQL ADVANCED QUERY MARATHON - LEVEL 4
-- Retail Sales Dataset

-- 1. CUSTOMERS
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customer (customer_id, customer_name, city)
VALUES
(101, 'Rahul', 'Hyderabad'),
(102, 'Priya', 'Hyderabad'),
(103, 'Arjun', 'Mumbai'),
(104, 'Sneha', 'Mumbai'),
(105, 'Karan', 'Delhi'),
(106, 'Neha', 'Delhi'),
(107, 'Amit', 'Hyderabad'),
(108, 'Riya', 'Pune'),
(109, 'Vikas', 'Pune'),
(110, 'Anjali', 'Mumbai');

-- 2. PRODUCTS
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

INSERT INTO products
(product_id, product_name, category, unit_price)
VALUES
(201, 'Laptop', 'Electronics', 55000),
(202, 'Smartphone', 'Electronics', 30000),
(203, 'Headphones', 'Electronics', 5000),
(204, 'Office Chair', 'Furniture', 12000),
(205, 'Desk', 'Furniture', 18000),
(206, 'Backpack', 'Accessories', 2500),
(207, 'Watch', 'Accessories', 7000),
(208, 'Shoes', 'Fashion', 4500);

-- 3. SALES

CREATE TABLE sale (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO sale
(sale_id, customer_id, product_id, sale_date, quantity)
VALUES

-- Rahul
(1001, 101, 201, '2026-01-05', 1),
(1002, 101, 203, '2026-02-10', 2),
(1003, 101, 206, '2026-03-15', 1),
(1004, 101, 202, '2026-04-20', 1),

-- Priya
(1005, 102, 202, '2026-01-08', 1),
(1006, 102, 207, '2026-02-18', 2),
(1007, 102, 204, '2026-03-25', 1),

-- Arjun
(1008, 103, 201, '2026-01-12', 1),
(1009, 103, 205, '2026-02-20', 2),
(1010, 103, 208, '2026-03-30', 1),

-- Sneha
(1011, 104, 204, '2026-01-15', 1),
(1012, 104, 206, '2026-02-22', 3),
(1013, 104, 208, '2026-04-05', 2),

-- Karan
(1014, 105, 205, '2026-01-20', 1),
(1015, 105, 201, '2026-02-25', 1),
(1016, 105, 203, '2026-03-28', 2),

-- Neha
(1017, 106, 202, '2026-01-25', 1),
(1018, 106, 207, '2026-03-01', 1),

-- Amit
(1019, 107, 203, '2026-02-01', 2),
(1020, 107, 202, '2026-03-10', 1),
(1021, 107, 201, '2026-04-15', 1),

-- Riya
(1022, 108, 208, '2026-01-30', 2),
(1023, 108, 207, '2026-03-05', 1),
(1024, 108, 206, '2026-04-10', 2),

-- Vikas
(1025, 109, 204, '2026-02-05', 1),
(1026, 109, 205, '2026-03-12', 1),
(1027, 109, 203, '2026-04-18', 3),

-- Anjali
(1028, 110, 202, '2026-01-10', 1),
(1029, 110, 208, '2026-02-15', 2),
(1030, 110, 204, '2026-04-01', 1);

SELECT * FROM customer;
SELECT * FROM products;
SELECT * FROM sale;

