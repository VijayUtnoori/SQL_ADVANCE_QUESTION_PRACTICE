SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

--1)
SELECT 
	C.customer_id,
	C.customer_name,
    SUM(unit_price*quantity) AS total_spent,
	ROW_NUMBER() OVER(ORDER BY SUM(unit_price*quantity) DESC) AS customer_rank
FROM products P
INNER JOIN orders O
ON P.product_id=O.product_id
RIGHT JOIN customers C
ON O.customer_id=C.customer_id
GROUP BY C.customer_id,C.customer_name;


--2)
WITH CTE_NAME AS (
SELECT
	C.customer_id,
    C.customer_name,
	SUM((unit_price*quantity)) AS total_spend
FROM products P
INNER JOIN orders O
ON P.product_id=O.product_id
RIGHT JOIN customers C
ON O.customer_id=C.customer_id
GROUP BY C.customer_id,C.customer_name),
CTE_NAME2 AS
(SELECT 
	AVG(total_spend) AS avg_total
FROM CTE_NAME)
SELECT 
	C.customer_id,
    C.customer_name,
	c.total_spend
    FROM CTE_NAME C
	CROSS JOIN CTE_NAME2 A
WHERE C.total_spend>A.avg_total;


--3)
SELECT * FROM (
SELECT 
	C.customer_id,
	C.customer_name,
	O.order_id,
	P.product_name,
	SUM((O.quantity*P.unit_price)) AS order_value,
	ROW_NUMBER() OVER(PARTITION BY C.customer_id ORDER BY SUM((O.quantity*P.unit_price)) DESC) AS RN
FROM products P
INNER JOIN orders O
ON P.product_id=O.product_id
RIGHT JOIN customers C
ON O.customer_id=C.customer_id
GROUP BY C.customer_id,C.customer_name,O.order_id,P.product_name)t
WHERE RN=1;



--4)
SELECT * FROM(
SELECT
	C.customer_id,
    C.customer_name,
    O.order_id,
    (P.unit_price*O.quantity) AS order_value,
	AVG((P.unit_price*O.quantity)) OVER(PARTITION BY C.customer_id ORDER BY (P.unit_price*O.quantity)) AS customer_average_order_value
FROM products P
INNER JOIN orders O
ON P.product_id=O.product_id
INNER JOIN customers C
ON O.customer_id=C.customer_id)t
WHERE order_value>customer_average_order_value;



--5)
WITH CTE_NAME1 AS(
SELECT
	C.customer_id,
    C.customer_name,
	O.order_id,
	O.order_date,
	ROW_NUMBER() OVER(PARTITION BY C.customer_id ORDER BY order_date ASC) AS rn
FROM products P
INNER JOIN orders O
ON P.product_id=O.product_id
INNER JOIN customers C
ON O.customer_id=C.customer_id
)
SELECT 
	Customer_id,
	customer_name,
	MAX(CASE WHEN rn = 1 THEN order_date END) AS first_order_date,
    MAX(CASE WHEN rn = 2 THEN order_date END) AS second_order_date,
	DATEDIFF(
        day, 
        MAX(CASE WHEN rn = 1 THEN order_date END),MAX(CASE WHEN rn = 2 THEN order_date END)) AS days_diff 
FROM CTE_NAME1
GROUP BY Customer_id,customer_name;

WITH CTE_NAME AS (
SELECT 
	C.customer_id,
	C.customer_name,
	O.order_date,
	ROW_NUMBER() OVER(PARTITION BY C.customer_id ORDER BY O.order_date) AS RN
FROM products P
INNER JOIN orders O
ON P.product_id=O.product_id
INNER JOIN customers C
ON O.customer_id=C.customer_id
)
SELECT 
	customer_id,
	customer_name,
	MAX(CASE WHEN RN=2 THEN order_date END) second_order_date
FROM CTE_NAME
GROUP BY customer_id,customer_name;





  







	











