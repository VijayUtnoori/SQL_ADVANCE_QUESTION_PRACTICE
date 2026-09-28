SELECT * FROM customer
SELECT * FROM products
SELECT * FROM sale

  -- Q1 — Customer Spending Rank Within City

   --Approach:
   --1. Create reusable customer sales VIEW
   --2. Aggregate customer spending
   --3. Rank customers within each city

CREATE VIEW sales_information AS(
SELECT 
	C.customer_id,
	C.customer_name,
	C.city,
	S.sale_id,
	S.sale_date,
	P.product_name,
	P.category,
	S.quantity,
	P.unit_price,
	(S.quantity*P.unit_price)AS sale_value
FROM customer C
LEFT JOIN sale S
ON C.customer_id=S.customer_id
INNER JOIN products P
ON S.product_id=P.product_id
)

--Used CREATED VIEW
SELECT * FROM(
SELECT 
	customer_id,
	customer_name,
    city,
	SUM(sale_value) AS total_spent,
	ROW_NUMBER() OVER(PARTITION BY city ORDER BY SUM(sale_value) DESC) AS city_rank
FROM sales_information
GROUP BY customer_id,customer_name,city)t
WHERE city_rank<=2

--drop view
DROP VIEW sales_information


 --Q2 — Customers Above City Average

  -- Reuses:
  -- sales_information VIEW

   --Approach:
   --1. Calculate customer spending
   --2. Calculate city average
  -- 3. Filter customers above city average


SELECT * FROM(
SELECT 
	customer_id,
	customer_name,
	city,
	SUM(sale_value) AS total_spent,
	AVG(SUM(sale_value)) OVER(PARTITION BY city) AS city_average_spent
FROM sales_information
GROUP BY customer_id,customer_name,city)t
WHERE total_spent>city_average_spent;

--3) CTAS CREATION(analytical layer contains product/month/category information)
--3)best-selling product in each category for every month** based on total sales

--Approach:
  --1)Create reusable CTAS monthly sales snapshot
  --2)Calculate best selling product by apply DENSE_RANK
  --3)Apply filters to find best selling product

SELECT 
     DATEFROMPARTS(
        YEAR(S.sale_date),
        MONTH(S.sale_date),
        1
    )AS sale_month,
    P.product_id,
    P.product_name,
    P.category,
    SUM(S.quantity) AS total_quantity,
    SUM(P.unit_price * S.quantity) AS total_sales
INTO monthly_sales_snapshot --CTAS CREATION
FROM sale S
LEFT JOIN products P 
    ON S.product_id = P.product_id
GROUP BY 
     DATEFROMPARTS(
        YEAR(S.sale_date),
        MONTH(S.sale_date),
        1
    ),
    P.product_id,
    P.product_name,
    P.category;


SELECT * FROM(
SELECT 
	sale_month,
	category,
	product_id,
	product_name,
	total_sales,
	DENSE_RANK() OVER(PARTITION BY category,sale_month ORDER BY total_sales DESC) AS category_rank
FROM monthly_sales_snapshot)t
WHERE category_rank=1
ORDER BY sale_month asc --optinal

--DTOP CREATED CTAS
DROP TABLE monthly_sales_snapshot

--4)CTAS CREATION (customer + sale information)
--most recent purchase value is lower than their previous purchase value

--Approch
--1.Create reusable CTAS customer sales snapshot AND reused
--2.calculated previous sales value and rank in order to find the change_amount
--3)And apply where condition to filter the data

SELECT 
	C.customer_id,
	C.customer_name,
	S.sale_id,
	S.quantity,
	P.unit_price,
	S.sale_date,
	(quantity*unit_price) AS sale_amount
INTO customer_sales_snapshot
FROM customer C
LEFT JOIN sale S
ON C.customer_id=S.customer_id
INNER JOIN products P
ON S.product_id=P.product_id

	
WITH RankedSales AS (
    SELECT 
        customer_id,
        customer_name,
        sale_id AS latest_sale_id,
        sale_amount AS latest_sale_value,
        sale_date,
        LAG(sale_amount) OVER(
            PARTITION BY customer_id 
            ORDER BY sale_date ASC, sale_id ASC) AS previous_sale_value,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id 
            ORDER BY sale_date DESC, sale_id DESC) AS RN
    FROM customer_sales_snapshot)
SELECT 
    customer_id,
    customer_name,
    latest_sale_id,
    latest_sale_value,
    previous_sale_value,
    (latest_sale_value - previous_sale_value) AS change_amount
FROM RankedSales
WHERE RN = 1 
  AND previous_sale_value IS NOT NULL
  AND latest_sale_value < previous_sale_value;


  --drop CTAS
  DROP TABLE customer_sales_snapshot

--5) category-level performance view 
--Approch
--1).reused VIEW
--2)calculate the average_category_sales,average_sale_value AND rank of category_rank
--3)apply where filter to filter the data

CREATE VIEW category_level_performance_layer AS(
SELECT 
    P.category,
    SUM(P.unit_price*S.quantity) AS total_sales,
    SUM(S.quantity) AS total_quantity,
    AVG(P.unit_price*S.quantity) AS average_sale_value,
    COUNT(sale_id) AS number_of_sales
FROM products P
LEFT JOIN sale S
ON P.product_id=S.product_id
GROUP BY P.category
)

--USING VIEW
SELECT * FROM(
SELECT 
    category,
    total_sales,
    total_quantity,
    average_sale_value,
    ROW_NUMBER() OVER(ORDER BY total_sales DESC)category_rank,
    AVG(total_sales) OVER() AS average_category_sales
FROM category_level_performance_layer)t
WHERE total_sales > average_category_sales;

DROP VIEW category_level_performance_layer