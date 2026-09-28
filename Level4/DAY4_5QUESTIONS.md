# SQL Advanced Query Marathon — Level 4

## Q1. Build a Customer Sales Analysis Layer

The analytics team repeatedly needs customer-level sales information.

Create a reusable analytical layer containing:

- customer_id
- customer_name
- city
- sale_id
- sale_date
- product_name
- category
- quantity
- unit_price
- sale_value

After creating the layer, identify the **top 2 customers by total spending within each city**.

**Output:**
- customer_id
- customer_name
- city
- total_spent
- city_rank

---

## Q2. Reuse the Analytical Layer

Using the customer sales analysis layer created in Q1, find customers whose **total spending is greater than the average customer spending of their city**.

Do not rebuild the original customer-product-sales join.

**Output:**
- customer_id
- customer_name
- city
- total_spent
- city_average_spent

---

## Q3. Business Requirement Changed

The business team now wants a **monthly sales snapshot** for reporting.

Create a physical analytical table containing:

- sale_month
- product_id
- product_name
- category
- total_quantity
- total_sales

Then identify the **best-selling product in each category for every month** based on total sales.

**Output:**
- sale_month
- category
- product_id
- product_name
- total_sales
- category_rank

---

## Q4. No Analytical Layer Needed

Management wants to identify customers whose **most recent purchase value is lower than their previous purchase value**.

Return only customers where this decline occurred.

**Output:**
- customer_id
- customer_name
- latest_sale_id
- latest_sale_value
- previous_sale_value
- change_amount

---

## Q5. New Business Requirement — Build a New Layer

The marketing team no longer wants customer-level analysis.

They now want a **category-level performance layer** containing:

- category
- total_sales
- total_quantity
- average_sale_value
- number_of_sales

Create the appropriate reusable analytical layer.

Using it, identify categories where:

**total_sales > average category sales**

Also rank all categories from highest to lowest total sales.

**Output:**
- category
- total_sales
- total_quantity
- average_sale_value
- category_rank

---

# Level 4 Focus

- VIEW
- CTAS
- Reusable analytical layers
- Data marts
- Aggregation
- JOIN
- GROUP BY
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- Window functions
- Subqueries
- CTEs
- Business-level comparisons
- Choosing between reusable layer vs direct query