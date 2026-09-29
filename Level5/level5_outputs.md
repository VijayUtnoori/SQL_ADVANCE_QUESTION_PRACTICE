# SQL Advanced Query Marathon — Level 5
# Solution Outputs

---

## Q1 — Customer Monthly Spending Trend

| customer_id | customer_name | sale_month | current_month_sale | pre_month_sales | increase_amount |
|---:|---|---|---:|---:|---:|
| 101 | Rahul | 2026-04-01 | 55000.00 | 24000.00 | 31000.00 |
| 102 | Priya | 2026-02-01 | 9000.00 | 5000.00 | 4000.00 |
| 103 | Arjun | 2026-03-01 | 30000.00 | 9000.00 | 21000.00 |
| 103 | Arjun | 2026-04-01 | 36000.00 | 30000.00 | 6000.00 |
| 104 | Sneha | 2026-03-01 | 10000.00 | 9000.00 | 1000.00 |
| 105 | Karan | 2026-03-01 | 55000.00 | 36000.00 | 19000.00 |
| 105 | Karan | 2026-04-01 | 30000.00 | 15000.00 | 15000.00 |
| 107 | Amit | 2026-02-01 | 30000.00 | 10000.00 | 20000.00 |
| 107 | Amit | 2026-03-01 | 73000.00 | 30000.00 | 43000.00 |
| 108 | Riya | 2026-04-01 | 12000.00 | 5000.00 | 7000.00 |
| 109 | Vikas | 2026-02-01 | 18000.00 | 12000.00 | 6000.00 |
| 109 | Vikas | 2026-04-01 | 30000.00 | 15000.00 | 15000.00 |
| 110 | Anjali | 2026-03-01 | 12000.00 | 9000.00 | 3000.00 |
| 110 | Anjali | 2026-04-01 | 55000.00 | 12000.00 | 43000.00 |

---

## Q2 — Category Performance vs Previous Month

| category | sale_month | current_month_sales | previous_month_sales | percentage_change |
|---|---|---:|---:|---:|
| Accessories | 2026-02-01 | 19000.00 | 14500.00 | 31.034400 |
| Electronics | 2026-03-01 | 125000.00 | 115000.00 | 8.695600 |
| Electronics | 2026-04-01 | 225000.00 | 125000.00 | 80.000000 |
| Fashion | 2026-04-01 | 27000.00 | 9000.00 | 200.000000 |
| Furniture | 2026-03-01 | 54000.00 | 30000.00 | 80.000000 |

---

## Q3 — Top Customer Within Each Category

| category | customer_id | customer_name | total | category_rank |
|---|---:|---|---:|---:|
| Accessories | 104 | Sneha | 14500.00 | 1 |
| Electronics | 101 | Rahul | 150000.00 | 1 |
| Electronics | 107 | Amit | 150000.00 | 1 |
| Fashion | 104 | Sneha | 9000.00 | 1 |
| Fashion | 102 | Priya | 9000.00 | 1 |
| Fashion | 103 | Arjun | 9000.00 | 1 |
| Fashion | 110 | Anjali | 9000.00 | 1 |
| Fashion | 108 | Riya | 9000.00 | 1 |
| Furniture | 103 | Arjun | 72000.00 | 1 |

---

## Q4 — Customer Purchase Consistency

| customer_id | customer_name | active_months | total_sales | average_monthly_sales | highest_monthly_sales | lowest_monthly_sales |
|---:|---|---:|---:|---:|---:|---:|
| 107 | Amit | 4 | 168000.00 | 42000.000000 | 73000.00 | 10000.00 |
| 110 | Anjali | 4 | 106000.00 | 26500.000000 | 55000.00 | 9000.00 |
| 103 | Arjun | 4 | 166000.00 | 41500.000000 | 91000.00 | 9000.00 |
| 105 | Karan | 4 | 136000.00 | 34000.000000 | 55000.00 | 15000.00 |
| 101 | Rahul | 4 | 179000.00 | 44750.000000 | 65000.00 | 24000.00 |

---

## Q5 — Sales Performance Layer

| customer_id | customer_name | city | total_sales | category_count | qualifying_months |
|---:|---|---|---:|---:|---:|
| 105 | Karan | Delhi | 136000.00 | 2 | 1 |
| 101 | Rahul | Hyderabad | 179000.00 | 3 | 2 |
| 107 | Amit | Hyderabad | 168000.00 | 2 | 2 |
| 103 | Arjun | Mumbai | 166000.00 | 3 | 1 |
| 110 | Anjali | Mumbai | 106000.00 | 3 | 1 |