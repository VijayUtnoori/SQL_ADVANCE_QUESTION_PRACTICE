# SQL Advanced Query Marathon — Level 5

## Q1. Customer Monthly Spending Trend

The business team wants to identify customers whose spending increased compared with the previous month.

Calculate each customer's monthly spending and compare it with their immediately previous month.

Return only customers/months where spending increased.

**Output:**
- customer_id
- customer_name
- sale_month
- current_month_sales
- previous_month_sales
- increase_amount

---

## Q2. Category Performance vs Previous Month

Management wants to understand how each product category is performing month-over-month.

For every category and month, calculate:

- total sales
- previous month's category sales
- percentage change from the previous month

Return only categories where sales increased compared with the previous month.

**Output:**
- category
- sale_month
- current_month_sales
- previous_month_sales
- percentage_change

---

## Q3. Top Customer Within Each Category

The marketing team wants to identify the highest-spending customer for every product category.

First determine each customer's total spending within each category.

Then identify the top customer in each category.

If multiple customers have the same highest spending, return all of them.

**Output:**
- category
- customer_id
- customer_name
- total_spent
- category_rank

---

## Q4. Customer Purchase Consistency

The business wants to identify customers who made purchases in at least 3 different months.

For these customers, calculate:

- number of active months
- total sales
- average monthly sales
- highest monthly sales
- lowest monthly sales

Then identify customers whose highest monthly sales are greater than the overall average of all customers' highest monthly sales.

**Output:**
- customer_id
- customer_name
- active_months
- total_sales
- average_monthly_sales
- highest_monthly_sales
- lowest_monthly_sales

---

## Q5. Sales Performance Layer — Requirement Change

The reporting team now wants a reusable analytical layer at the **customer + category + month** level.

Create an appropriate reusable data layer containing:

- customer_id
- customer_name
- category
- sale_month
- total_quantity
- total_sales

Using this layer, identify customers who:

1. Purchased from at least 2 different categories.
2. Have total sales greater than the average customer sales within their city.
3. Have at least one category where their monthly sales exceeded 50,000.

**Output:**
- customer_id
- customer_name
- city
- total_sales
- category_count
- qualifying_months

---

# Level 5 Focus

- Multiple CTEs
- CTE + Window Functions
- CTE + JOIN
- Nested business logic
- LAG()
- SUM() OVER()
- AVG() OVER()
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- PARTITION BY
- Month-level analysis
- Month-over-month comparison
- Percentage change
- Multiple levels of aggregation
- Reusable analytical layers
- Choosing between direct query, CTE, VIEW and CTAS