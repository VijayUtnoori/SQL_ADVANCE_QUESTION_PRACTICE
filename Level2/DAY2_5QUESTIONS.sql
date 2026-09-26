USE sql_marathon_level1;

-- SQL ADVANCED QUERY MARATHON - LEVEL 2
-- Healthcare Appointment Dataset
-- SQL Server

-- 1. PATIENTS
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    city VARCHAR(50),
    age INT
);

INSERT INTO patients (patient_id, patient_name, city, age)
VALUES
(101, 'Rahul', 'Hyderabad', 28),
(102, 'Priya', 'Mumbai', 35),
(103, 'Arjun', 'Delhi', 42),
(104, 'Sneha', 'Hyderabad', 31),
(105, 'Karan', 'Pune', 50),
(106, 'Neha', 'Mumbai', 26),
(107, 'Amit', 'Delhi', 45),
(108, 'Riya', 'Pune', 38),
(109, 'Vikas', 'Hyderabad', 55),
(110, 'Anjali', 'Mumbai', 29);

-- 2. DOCTORS

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50)
);

INSERT INTO doctors (doctor_id, doctor_name, specialization)
VALUES
(201, 'Dr. Sharma', 'Cardiology'),
(202, 'Dr. Mehta', 'Neurology'),
(203, 'Dr. Rao', 'Orthopedics'),
(204, 'Dr. Khan', 'Dermatology'),
(205, 'Dr. Patel', 'General Medicine');

-- 3. APPOINTMENTS

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    billing_amount DECIMAL(10,2),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

INSERT INTO appointments
(appointment_id, patient_id, doctor_id, appointment_date, billing_amount)
VALUES
(1001, 101, 201, '2026-01-05', 2500),
(1002, 101, 202, '2026-02-10', 1800),
(1003, 102, 201, '2026-01-08', 3000),
(1004, 102, 201, '2026-03-12', 4500),
(1005, 103, 203, '2026-01-15', 2200),
(1006, 103, 203, '2026-02-20', 3500),
(1007, 104, 204, '2026-01-18', 1500),
(1008, 104, 204, '2026-03-05', 2800),
(1009, 105, 201, '2026-01-22', 5000),
(1010, 105, 203, '2026-02-25', 4000),
(1011, 105, 201, '2026-03-18', 6500),
(1012, 106, 205, '2026-01-25', 1200),
(1013, 106, 205, '2026-02-28', 1800),
(1014, 107, 202, '2026-01-30', 3200),
(1015, 107, 202, '2026-03-10', 2500),
(1016, 108, 204, '2026-02-02', 2000),
(1017, 108, 204, '2026-03-15', 3500),
(1018, 109, 203, '2026-02-05', 4200),
(1019, 109, 201, '2026-03-20', 5500),
(1020, 110, 205, '2026-02-08', 1600);

-- CHECK DATA

SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;