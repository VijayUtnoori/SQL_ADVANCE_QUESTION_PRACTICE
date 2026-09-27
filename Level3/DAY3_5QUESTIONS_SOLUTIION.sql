SELECT * FROM customer;
SELECT * FROM products;
SELECT * FROM sales;

--1)

SELECT
	C.customer_id,
	C.customer_name, 
	C.city,
	SUM(P.unit_price*S.quantity) AS total_spent,
	DENSE_RANK() OVER(PARTITION BY city ORDER BY SUM(P.unit_price*S.quantity) DESC)AS city_rank
FROM customer C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
LEFT JOIN products P
ON P.product_id=S.product_id
GROUP BY C.customer_id,C.customer_name,C.city

--2)
SELECT * FROM (
SELECT 
	P.product_id, 
	P.product_name,
	P.category,
	SUM(P.unit_price*S.quantity) AS total_sales,
	AVG(SUM(P.unit_price*S.quantity)) OVER(PARTITION BY P.category) AS category_avg_sales
FROM products P
LEFT JOIN sales S
ON P.product_id=S.product_id
GROUP BY P.product_id, P.product_name,P.category)t
WHERE total_sales>category_avg_sales;


--3)
SELECT * FROM (
SELECT	
	C.customer_id,
	C.customer_name,
	S.sale_id,
	P.product_name,
	(P.unit_price*S.quantity) AS sale_value,
	DENSE_RANK() OVER(PARTITION BY C.customer_id ORDER BY (P.unit_price*S.quantity) DESC) AS Customer_rank
FROM customer C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
LEFT JOIN products P
ON P.product_id=S.product_id)t
WHERE Customer_rank=2

--4)
SELECT
	C.customer_id,
	C.customer_name,
	S.sale_id,
	S.sale_date,
	(P.unit_price*S.quantity) AS sale_value,
	SUM(P.unit_price*S.quantity) OVER(PARTITION BY C.customer_id ORDER BY S.sale_date)AS running_total
FROM customer C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
LEFT JOIN products P
ON P.product_id=S.product_id


--5)
SELECT * FROM (
SELECT
	C.customer_id,
	C.customer_name,
	S.sale_date,
	(unit_price*quantity) AS sale_value,
	LAG(unit_price*quantity) OVER(PARTITION BY C.customer_id ORDER BY S.sale_date) AS previous_sale_value,
	ROW_NUMBER() OVER(PARTITION BY C.customer_id ORDER BY S.sale_date DESC) AS rn
FROM customer C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
LEFT JOIN products P
ON P.product_id=S.product_id
)t
WHERE rn=1 AND sale_value>previous_sale_value
