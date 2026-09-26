SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;

--1)

SELECT 
	D.doctor_id,
	D.doctor_name,
	COUNT(A.appointment_id) AS total_appointments,
	DENSE_RANK() OVER(ORDER BY COUNT(A.appointment_id) DESC) AS doctor_rank
FROM doctors D
LEFT JOIN appointments A
ON D.doctor_id=A.doctor_id
GROUP BY D.doctor_id,D.doctor_name;


--2)

WITH CTE_NAME1 AS
(
SELECT 
	P.patient_id,
	P.patient_name,
	COUNT(appointment_id) AS Appointment_count
FROM patients P
LEFT JOIN appointments A
ON P.patient_id=A.patient_id
GROUP BY P.patient_id,P.patient_name
),
CTE_NAME2 AS (
SELECT 
	AVG(Appointment_count) AS avg_count
	FROM CTE_NAME1
)
SELECT 
	patient_id,
	patient_name,
	Appointment_count,
	avg_count
	FROM CTE_NAME1 N
	CROSS JOIN CTE_NAME2 E
WHERE N.Appointment_count>E.avg_count;

--3)
SELECT * FROM(
SELECT 
	D.doctor_id,
	D.doctor_name,
	A.appointment_id,
	P.patient_name,
	billing_amount,
	RANK() OVER(PARTITION BY D.doctor_id ORDER BY billing_amount DESC) AS H_billing_amount
FROM doctors D
LEFT JOIN appointments A
ON D.doctor_id=A.doctor_id
INNER JOIN patients P
ON P.patient_id=A.patient_id)t
WHERE H_billing_amount=1;


--4)
SELECT * FROM(
SELECT 
	A.appointment_id,
	D.doctor_id,
	D.doctor_name,
	P.patient_name,
	A.billing_amount,
	AVG(billing_amount) OVER(PARTITION BY D.doctor_id) AS doctor_avg_billing
FROM appointments A 
LEFT JOIN doctors D 
ON D.doctor_id=A.doctor_id
INNER JOIN patients P
ON P.patient_id=A.patient_id)t
WHERE billing_amount>doctor_avg_billing;

--5)
SELECT 
	P.patient_id,
	P.patient_name,
	A.appointment_id,
	A.appointment_date,
	LAG(A.appointment_date) OVER(PARTITION BY P.patient_id ORDER BY A.appointment_date)AS previous_appointment_date
FROM appointments A 
INNER JOIN patients P
ON P.patient_id=A.patient_id;








