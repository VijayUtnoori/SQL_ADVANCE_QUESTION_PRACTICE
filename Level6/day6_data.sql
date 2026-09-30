create database SQL_Level6;
USE SQL_Level6;

-- SQL ADVANCED QUERY MARATHON - LEVEL 6
-- DOMAIN: TRANSPORTATION BOOKING ANALYTICS

-- 1. CUSTOMERS

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers
(customer_id, customer_name, city)
VALUES
(101, 'Rahul', 'Hyderabad'),
(102, 'Priya', 'Mumbai'),
(103, 'Arjun', 'Delhi'),
(104, 'Sneha', 'Pune'),
(105, 'Karan', 'Hyderabad'),
(106, 'Neha', 'Bangalore'),
(107, 'Amit', 'Mumbai'),
(108, 'Riya', 'Delhi'),
(109, 'Vikas', 'Pune'),
(110, 'Anjali', 'Hyderabad');


-- =========================================================
-- 2. ROUTES
-- =========================================================

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    route_name VARCHAR(100),
    transport_type VARCHAR(20),
    source_city VARCHAR(50),
    destination_city VARCHAR(50)
);

INSERT INTO routes
(route_id, route_name, transport_type, source_city, destination_city)
VALUES
(201, 'Hyderabad - Mumbai Express', 'Train', 'Hyderabad', 'Mumbai'),
(202, 'Mumbai - Delhi Superfast', 'Train', 'Mumbai', 'Delhi'),
(203, 'Delhi - Hyderabad Express', 'Train', 'Delhi', 'Hyderabad'),
(204, 'Pune - Mumbai Intercity', 'Train', 'Pune', 'Mumbai'),
(205, 'Hyderabad - Bangalore Express', 'Train', 'Hyderabad', 'Bangalore'),

(301, 'Hyderabad - Mumbai Volvo', 'Bus', 'Hyderabad', 'Mumbai'),
(302, 'Mumbai - Pune Sleeper', 'Bus', 'Mumbai', 'Pune'),
(303, 'Delhi - Jaipur AC', 'Bus', 'Delhi', 'Jaipur'),
(304, 'Bangalore - Hyderabad Volvo', 'Bus', 'Bangalore', 'Hyderabad'),
(305, 'Pune - Hyderabad Sleeper', 'Bus', 'Pune', 'Hyderabad');


-- =========================================================
-- 3. BOOKINGS
-- =========================================================

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    route_id INT,
    booking_date DATE,
    journey_date DATE,
    booking_status VARCHAR(20),
    passenger_count INT,
    booking_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (route_id)
        REFERENCES routes(route_id)
);


INSERT INTO bookings
(
    booking_id,
    customer_id,
    route_id,
    booking_date,
    journey_date,
    booking_status,
    passenger_count,
    booking_amount
)
VALUES

-- =========================================================
-- RAHUL - Customer 101
-- =========================================================

(1001, 101, 201, '2026-01-03', '2026-01-10', 'Completed', 1, 1800),
(1002, 101, 301, '2026-02-05', '2026-02-12', 'Completed', 2, 3600),
(1003, 101, 201, '2026-03-10', '2026-03-18', 'Cancelled', 1, 1800),
(1004, 101, 205, '2026-04-02', '2026-04-10', 'Completed', 2, 4200),


-- =========================================================
-- PRIYA - Customer 102
-- =========================================================

(1005, 102, 202, '2026-01-08', '2026-01-20', 'Completed', 1, 3200),
(1006, 102, 302, '2026-02-14', '2026-02-20', 'Cancelled', 1, 1400),
(1007, 102, 202, '2026-03-05', '2026-03-15', 'Completed', 2, 6400),
(1008, 102, 301, '2026-04-12', '2026-04-20', 'Completed', 1, 1900),


-- =========================================================
-- ARJUN - Customer 103
-- =========================================================

(1009, 103, 203, '2026-01-12', '2026-01-25', 'Completed', 1, 2800),
(1010, 103, 303, '2026-02-10', '2026-02-18', 'Completed', 2, 3000),
(1011, 103, 203, '2026-03-14', '2026-03-25', 'Completed', 1, 2800),
(1012, 103, 202, '2026-04-05', '2026-04-18', 'Cancelled', 1, 3200),


-- =========================================================
-- SNEHA - Customer 104
-- =========================================================

(1013, 104, 204, '2026-01-15', '2026-01-22', 'Completed', 2, 2200),
(1014, 104, 302, '2026-02-08', '2026-02-15', 'Completed', 1, 1400),
(1015, 104, 204, '2026-03-20', '2026-03-27', 'Cancelled', 1, 1100),
(1016, 104, 305, '2026-04-11', '2026-04-19', 'Completed', 2, 3600),


-- =========================================================
-- KARAN - Customer 105
-- =========================================================

(1017, 105, 201, '2026-01-18', '2026-01-28', 'Completed', 2, 3600),
(1018, 105, 205, '2026-02-20', '2026-03-01', 'Completed', 1, 2100),
(1019, 105, 201, '2026-03-22', '2026-04-02', 'Completed', 1, 1900),
(1020, 105, 301, '2026-04-15', '2026-04-25', 'Pending', 2, 3800),


-- =========================================================
-- NEHA - Customer 106
-- =========================================================

(1021, 106, 205, '2026-01-20', '2026-01-30', 'Completed', 1, 2100),
(1022, 106, 304, '2026-02-17', '2026-02-25', 'Cancelled', 1, 1700),
(1023, 106, 205, '2026-03-19', '2026-03-29', 'Completed', 2, 4200),
(1024, 106, 304, '2026-04-08', '2026-04-16', 'Completed', 1, 1800),


-- =========================================================
-- AMIT - Customer 107
-- =========================================================

(1025, 107, 301, '2026-01-22', '2026-01-30', 'Completed', 1, 1900),
(1026, 107, 302, '2026-02-18', '2026-02-26', 'Completed', 2, 2800),
(1027, 107, 301, '2026-03-16', '2026-03-25', 'Cancelled', 1, 1900),
(1028, 107, 304, '2026-04-10', '2026-04-18', 'Completed', 2, 3600),


-- =========================================================
-- RIYA - Customer 108
-- =========================================================

(1029, 108, 303, '2026-01-25', '2026-02-02', 'Completed', 1, 1500),
(1030, 108, 303, '2026-02-20', '2026-03-01', 'Cancelled', 2, 3000),
(1031, 108, 202, '2026-03-18', '2026-03-30', 'Completed', 1, 3200),
(1032, 108, 203, '2026-04-14', '2026-04-25', 'Completed', 2, 5600),


-- =========================================================
-- VIKAS - Customer 109
-- =========================================================

(1033, 109, 305, '2026-01-28', '2026-02-05', 'Completed', 1, 1800),
(1034, 109, 204, '2026-02-21', '2026-02-28', 'Completed', 2, 2200),
(1035, 109, 305, '2026-03-15', '2026-03-25', 'Cancelled', 1, 1800),
(1036, 109, 204, '2026-04-17', '2026-04-25', 'Completed', 1, 1200),


-- =========================================================
-- ANJALI - Customer 110
-- =========================================================

(1037, 110, 201, '2026-01-30', '2026-02-10', 'Completed', 1, 1800),
(1038, 110, 205, '2026-02-25', '2026-03-05', 'Completed', 2, 4200),
(1039, 110, 201, '2026-03-21', '2026-03-30', 'Completed', 1, 1900),
(1040, 110, 301, '2026-04-12', '2026-04-20', 'Cancelled', 1, 1900);


SELECT * FROM customers
SELECT * FROM routes
SELECT * FROM bookings