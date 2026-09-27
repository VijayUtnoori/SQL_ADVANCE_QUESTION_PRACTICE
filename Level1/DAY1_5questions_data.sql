
-- SQL ADVANCED QUERY MARATHON - LEVEL 1
-- E-Commerce Sales Dataset
CREATE DATABASE sql_marathon_level1;
USE sql_marathon_level1;

-- 1. CUSTOMERS

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name, city)
VALUES
(101, 'Rahul', 'Hyderabad'),
(102, 'Priya', 'Mumbai'),
(103, 'Arjun', 'Delhi'),
(104, 'Sneha', 'Hyderabad'),
(105, 'Karan', 'Pune'),
(106, 'Neha', 'Mumbai'),
(107, 'Amit', 'Delhi'),
(108, 'Riya', 'Pune');

-- 2. PRODUCTS

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

INSERT INTO products (product_id, product_name, category, unit_price)
VALUES
(201, 'Laptop', 'Electronics', 60000),
(202, 'Mouse', 'Electronics', 1200),
(203, 'Keyboard', 'Electronics', 2500),
(204, 'Chair', 'Furniture', 7000),
(205, 'Desk', 'Furniture', 12000),
(206, 'Headphones', 'Electronics', 3500),
(207, 'Monitor', 'Electronics', 18000),
(208, 'Backpack', 'Accessories', 2500);

-- 3. ORDERS
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO orders
(order_id, customer_id, product_id, order_date, quantity)
VALUES
(1001, 101, 201, '2026-01-05', 1),
(1002, 101, 202, '2026-01-08', 2),
(1003, 102, 204, '2026-01-10', 1),
(1004, 102, 205, '2026-01-15', 1),
(1005, 103, 206, '2026-01-18', 2),
(1006, 103, 207, '2026-01-20', 1),
(1007, 104, 202, '2026-02-02', 3),
(1008, 104, 208, '2026-02-05', 2),
(1009, 105, 201, '2026-02-10', 1),
(1010, 105, 206, '2026-02-12', 1),
(1011, 106, 203, '2026-02-15', 2),
(1012, 106, 207, '2026-02-18', 1),
(1013, 107, 204, '2026-02-20', 2),
(1014, 107, 202, '2026-02-22', 1),
(1015, 108, 205, '2026-02-25', 1),
(1016, 108, 208, '2026-02-28', 3);

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;