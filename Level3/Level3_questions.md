# SQL Advanced Query Marathon — Level 3

## Q1. Customer Spending Rank Within City

Calculate the total spending of each customer and rank customers within their own city from highest to lowest spending.

**Output:**
- customer_id
- customer_name
- city
- total_spent
- city_rank

---

## Q2. Product Sales Above Category Average

Find products whose total sales are greater than the average product sales within their category.

**Output:**
- product_id
- product_name
- category
- total_sales
- category_avg_sales

---

## Q3. Customer's Second-Largest Purchase

For each customer, find their second-highest-value purchase. Exclude customers with fewer than two purchases.

**Output:**
- customer_id
- customer_name
- sale_id
- product_name
- sale_value

---

## Q4. Running Customer Spending

For every sale, calculate the customer's running total spending in chronological order.

**Output:**
- customer_id
- customer_name
- sale_id
- sale_date
- sale_value
- running_total

---

## Q5. Customers Who Increased Their Spending

Find customers whose latest purchase value is greater than their immediately previous purchase value.

**Output:**
- customer_id
- customer_name
- latest_sale_id
- latest_sale_value
- previous_sale_value

---

## Level 3 Focus

- JOIN
- GROUP BY
- CTE
- Subquery
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- AVG() OVER()
- SUM() OVER()
- LAG()
- PARTITION BY
- ORDER BY
- Running Totals
- Top-N per Group
- Group-level Comparisons