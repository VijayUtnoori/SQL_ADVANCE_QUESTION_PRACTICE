USE SQL_Level5;

SELECT * FROM customers
SELECT * FROM products
SELECT * FROM sales

--1)Customer Monthly Spending Trend
--Approch
--Comparision current sales with previuos sales(increment amount)
--

WITH CTE_NAME1 AS (
SELECT 
	C.customer_id,
	C.customer_name,
	DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1) AS sale_month,
	SUM(unit_price*quantity) AS current_month_sale,
	LAG(SUM(unit_price*quantity)) OVER(PARTITION BY C.customer_id ORDER BY DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1)) AS pre_month_sales
FROM customers C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
INNER JOIN products P
ON S.product_id=P.product_id
GROUP BY C.customer_id,C.customer_name,DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1))

SELECT 
	customer_id,
	customer_name,
	sale_month,
	current_month_sale,
	pre_month_sales,
	current_month_sale-pre_month_sales AS increase_amount
FROM CTE_NAME1
WHERE pre_month_sales IS NOT NULL
AND current_month_sale>pre_month_sales;

--2)Category Performance vs Previous Month
--approch
--analysis product category performance month-over-month

WITH CategoryPerformance AS (
SELECT 
	category,
	DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1) AS sale_month,
	SUM(quantity*unit_price) AS current_month_sales,
	LAG(SUM(quantity*unit_price)) OVER(PARTITION BY category ORDER BY DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1)) AS previous_month_sales
FROM products P
LEFT JOIN sales S
ON P.product_id=S.product_id
GROUP BY category,DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1)
)
SELECT
	category,
	sale_month,
	current_month_sales,
	previous_month_sales,
	(current_month_sales-previous_month_sales)/previous_month_sales*100 AS percentage_change
FROM CategoryPerformance
WHERE previous_month_sales IS NOT NULL
AND current_month_sales>previous_month_sales;

--3) Top Customer Within Each Category

--Approch
--highest-spending customer for every product category
--using simple aggereation and window fuction(dence_rank)
SELECT * FROM (
SELECT
	P.category,
	C.customer_id,
	C.customer_name,
	SUM(quantity*unit_price) AS total,
	DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(quantity*unit_price) DESC) AS category_rank
FROM customers C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
INNER JOIN products P
ON S.product_id=P.product_id
GROUP BY P.category,C.customer_id,C.customer_name)t
WHERE category_rank=1

--4)Customer Purchase Consistency

--CTE1 (to calculate exact mantly_sales)
WITH Customer_Purchase_Consistency AS(
SELECT
	C.customer_id,
	C.customer_name,
	DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1) AS sale_months,
	SUM(quantity*unit_price) AS total_sales
FROM customers C
LEFT JOIN sales S
ON C.customer_id=S.customer_id
INNER JOIN products P
ON S.product_id=P.product_id
GROUP BY C.customer_id,C.customer_name,DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1)
)
--CTE2 use that montly _total to calculate the active_months,average_monthly_sales.. ect 
,Customer_Purchase_Consistency1 AS (
SELECT
	customer_id,
	customer_name,
	COUNT(sale_months) AS active_months,
	SUM(total_sales) AS total_sales,
	AVG(total_sales) AS average_monthly_sales,
	MAX(total_sales) AS highest_monthly_sales,
	MIN(total_sales) AS lowest_monthly_sales
FROM Customer_Purchase_Consistency
GROUP BY customer_id,customer_name
HAVING COUNT(sale_months)>=3
)
--CTE3 Takes the average of highest_monthly_sales across all qualifying customers.
,Customer_Purchase_Consistency2 AS 
(
SELECT 
        AVG(highest_monthly_sales) AS overall_avg_highest_sales
  FROM Customer_Purchase_Consistency1
)
	SELECT 
    CPC.customer_id,
    CPC.customer_name,
    CPC.active_months,
    CPC.total_sales,
    CPC.average_monthly_sales,
    CPC.highest_monthly_sales,
    CPC.lowest_monthly_sales
FROM Customer_Purchase_Consistency1 CPC
CROSS JOIN Customer_Purchase_Consistency2 CPC2
WHERE CPC.highest_monthly_sales > CPC2.overall_avg_highest_sales;


--5)Sales Performance Layer — Requirement Change
--creation of view and reuse it 

-- Step 1: Create the reusable analytical view at Customer + Category + Month level
CREATE VIEW Sales_Performance AS 
SELECT 
    C.customer_id,
    C.customer_name,
    C.city,
    P.category,
    DATEFROMPARTS(YEAR(S.sale_date), MONTH(S.sale_date), 1) AS sale_month,
    SUM(S.quantity) AS total_quantity,
    SUM(S.quantity * P.unit_price) AS total_sales
FROM customers C
INNER JOIN sales S ON C.customer_id = S.customer_id
INNER JOIN products P ON S.product_id = P.product_id
GROUP BY 
    C.customer_id,C.customer_name,C.city,P.category,
    DATEFROMPARTS(YEAR(S.sale_date), MONTH(S.sale_date), 1);

-- Step 2: Customer Aggregation CTE
WITH Customer_Summary AS (
    SELECT 
        customer_id,
        customer_name,
        city,
        SUM(total_sales) AS total_sales,
        COUNT(DISTINCT category) AS category_count,
        -- Count distinct months where ANY category sales for that customer exceeded 50,000
        COUNT(DISTINCT CASE WHEN total_sales > 50000 THEN sale_month END) AS qualifying_months
    FROM Sales_Performance
    GROUP BY customer_id,customer_name,city
),

-- Step 3: Compute City Average
Customer_City_avg AS (
    SELECT 
        customer_id,
        customer_name,
        city,
        total_sales,
        category_count,
        qualifying_months,
        AVG(total_sales) OVER(PARTITION BY city) AS city_avg_customer_sales
    FROM Customer_Summary
)
-- Step 4: Apply the 3 Business Conditions
SELECT 
    customer_id,
    customer_name,
    city,
    total_sales,
    category_count,
    qualifying_months
FROM Customer_City_avg
WHERE category_count >= 2                              
  AND total_sales > city_avg_customer_sales            
  AND qualifying_months >= 1;           
