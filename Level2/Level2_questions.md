# SQL Advanced Query Marathon — Level 2

## Q1 — Doctor Appointment Ranking

Calculate the **total number of appointments for each doctor** and rank doctors from highest to lowest based on appointment count.

**Output:**  
`doctor_id`, `doctor_name`, `total_appointments`, `doctor_rank`

---

## Q2 — Patients Above Average Visits

Find patients whose **total number of appointments is greater than the average number of appointments per patient**.

**Output:**  
`patient_id`, `patient_name`, `total_visits`

---

## Q3 — Doctor's Highest-Billing Appointment

For each doctor, find the appointment with the **highest billing amount**.

If multiple appointments have the same highest billing amount, return all of them.

**Output:**  
`doctor_id`, `doctor_name`, `appointment_id`, `patient_name`, `billing_amount`

---

## Q4 — Appointment vs Doctor Average

Find appointments where the **billing amount is greater than that doctor's average billing amount**.

**Output:**  
`appointment_id`, `doctor_id`, `doctor_name`, `patient_name`, `billing_amount`, `doctor_avg_billing`

---

## Q5 — Patient Visit Sequence

For each patient, display their appointments in chronological order and show the **previous appointment date**.

For the patient's first appointment, `previous_appointment_date` should be `NULL`.

**Output:**  
`patient_id`, `patient_name`, `appointment_id`, `appointment_date`, `previous_appointment_date`

---

## Level 2 Focus

- JOIN
- GROUP BY
- CTE
- Subquery
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- AVG() OVER()
- LAG()
- PARTITION BY
- ORDER BY