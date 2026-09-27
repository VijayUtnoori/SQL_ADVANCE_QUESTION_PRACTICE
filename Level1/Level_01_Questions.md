# SQL Advanced Query Marathon — Level 1

## Q1 — Customer Purchase Ranking

Calculate the **total spending of each customer** and rank customers from highest to lowest spending.

**Output:**  
`customer_id`, `customer_name`, `total_spent`, `customer_rank`

---

## Q2 — Above-Average Customers

Find customers whose **total spending is greater than the average spending of all customers**.

**Output:**  
`customer_id`, `customer_name`, `total_spent`

---

## Q3 — Customer's Best Order

Find the **highest-value order for each customer**.

> `order_value = quantity × unit_price`

**Output:**  
`customer_id`, `customer_name`, `order_id`, `product_name`, `order_value`

---

## Q4 — Orders Above Customer Average

Find orders whose **order value is greater than that customer's average order value**.

**Output:**  
`customer_id`, `customer_name`, `order_id`, `order_value`, `customer_average_order_value`

---

## Q5 — First & Second Order Analysis

For each customer, find their **first order date, second order date**, and the **number of days between them**.

Customers with only one order should still appear.

**Output:**  
`customer_id`, `customer_name`, `first_order_date`, `second_order_date`, `days_diff`

---

## Level 1 Focus

- JOIN
- GROUP BY
- CTE
- Subquery
- Window Functions
- ROW_NUMBER()
- PARTITION BY
- CASE