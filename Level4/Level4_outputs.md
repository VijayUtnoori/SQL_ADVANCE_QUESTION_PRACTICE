# SQL Advanced Query Marathon — Level 4
# Solution Outputs

---

## Q1 — Top 2 Customers by City

| customer_id | customer_name | city | total_spent | city_rank |
|---:|---|---|---:|---:|
| 105 | Karan | Delhi | 93000.00 | 1 |
| 106 | Neha | Delhi | 37000.00 | 2 |
| 101 | Rahul | Hyderabad | 97500.00 | 1 |
| 107 | Amit | Hyderabad | 95000.00 | 2 |
| 103 | Arjun | Mumbai | 95500.00 | 1 |
| 110 | Anjali | Mumbai | 51000.00 | 2 |
| 109 | Vikas | Pune | 45000.00 | 1 |
| 108 | Riya | Pune | 21000.00 | 2 |

---

## Q2 — Customers Above City Average

| customer_id | customer_name | city | total_spent | city_average_spent |
|---:|---|---|---:|---:|
| 105 | Karan | Delhi | 83000.00 | 60000.000000 |
| 107 | Amit | Hyderabad | 95000.00 | 82833.333333 |
| 101 | Rahul | Hyderabad | 97500.00 | 82833.333333 |
| 103 | Arjun | Mumbai | 95500.00 | 58333.333333 |
| 109 | Vikas | Pune | 45000.00 | 33000.000000 |

---

## Q3 — Best-Selling Product by Category and Month

| sale_month | category | product_id | product_name | total_sales | category_rank |
|---|---|---:|---|---:|---:|
| 2026-01-01 | Electronics | 201 | Laptop | 110000.00 | 1 |
| 2026-01-01 | Fashion | 208 | Shoes | 9000.00 | 1 |
| 2026-01-01 | Furniture | 205 | Desk | 18000.00 | 1 |
| 2026-01-01 | Accessories | 207 | Watch | 14000.00 | 1 |
| 2026-02-01 | Electronics | 201 | Laptop | 55000.00 | 1 |
| 2026-02-01 | Fashion | 208 | Shoes | 9000.00 | 1 |
| 2026-02-01 | Furniture | 205 | Desk | 36000.00 | 1 |
| 2026-03-01 | Accessories | 207 | Watch | 14000.00 | 1 |
| 2026-03-01 | Electronics | 202 | Smartphone | 30000.00 | 1 |
| 2026-03-01 | Fashion | 208 | Shoes | 4500.00 | 1 |
| 2026-03-01 | Furniture | 205 | Desk | 18000.00 | 1 |
| 2026-03-01 | Accessories | 206 | Backpack | 5000.00 | 1 |
| 2026-04-01 | Electronics | 201 | Laptop | 55000.00 | 1 |
| 2026-04-01 | Fashion | 208 | Shoes | 9000.00 | 1 |
| 2026-04-01 | Furniture | 204 | Office Chair | 12000.00 | 1 |

---

## Q4 — Customers With Reduced Latest Purchase

| customer_id | customer_name | latest_sale_id | latest_sale_value | previous_sale_value | change_amount |
|---:|---|---:|---:|---:|---:|
| 102 | Priya | 1007 | 12000.00 | 14000.00 | -2000.00 |
| 103 | Arjun | 1010 | 4500.00 | 36000.00 | -31500.00 |
| 105 | Karan | 1016 | 10000.00 | 55000.00 | -45000.00 |
| 106 | Neha | 1018 | 7000.00 | 30000.00 | -23000.00 |
| 108 | Riya | 1024 | 5000.00 | 7000.00 | -2000.00 |
| 109 | Vikas | 1027 | 15000.00 | 18000.00 | -3000.00 |

---

## Q5 — Categories Above Average Category Sales

| category | total_sales | total_quantity | average_sale_value | category_rank | average_category_sales |
|---|---:|---:|---:|---:|---:|
| Electronics | 415000.00 | 18 | 31923.076923 | 1 | 152375.000000 |