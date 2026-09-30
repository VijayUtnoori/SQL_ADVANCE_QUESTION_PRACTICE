USE SQL_Level6

SELECT * FROM bookings
SELECT * FROM customers
SELECT * FROM routes

--Domain: Transportation Booking & Travel Analytics

--Q1. Route Revenue Ranking
--Approch:
--Calculated revenue for each route
--Rank route within each transportation type

SELECT 
	R.transport_type,
	R.route_id,
	R.route_name,
	COUNT(B.booking_id) AS total_bookings,
	COALESCE(SUM(booking_amount),0) AS total_revenue,
	DENSE_RANK() OVER(PARTITION BY R.transport_type ORDER BY COALESCE(SUM(booking_amount),0) DESC) AS revenue_rank
FROM routes R
LEFT JOIN bookings B
ON R.route_id=B.route_id
WHERE booking_status='Completed'
GROUP BY R.transport_type,R.route_id,R.route_name
ORDER BY R.transport_type,revenue_rank;


--Q2. Customer Cancellation Behaviour
--Approch:
--first calculate the individual cancellation 
--using window function calculate over all customer cancelletion 
--then compare 

WITH Customer_Cancellation AS (
SELECT 
     C.customer_id,
	 C.customer_name,
	 COUNT(booking_id) AS total_bookings,
	 COUNT(CASE WHEN booking_status='Cancelled' THEN booking_status END) AS Cancelled_Bookings,
	 ROUND(
            100.0 * COUNT(CASE WHEN B.booking_status = 'Cancelled' THEN 1 END) 
            / NULLIF(COUNT(B.booking_id), 0), 2) AS Cancellation_rate
FROM customers C
LEFT JOIN bookings B
ON C.customer_id=B.customer_id
GROUP BY C.customer_id,C.customer_name),
Customer_With_Average AS(
SELECT
	customer_id,
	customer_name,
	total_bookings,
	Cancelled_Bookings,
	Cancellation_rate,
	ROUND(AVG(Cancellation_rate) OVER() ,2) AS avg_cancellation_rate
FROM Customer_Cancellation
)

SELECT
	customer_id,
	customer_name,
	total_bookings,
	Cancelled_Bookings,
	Cancellation_rate,
	avg_cancellation_rate
FROM Customer_With_Average
WHERE Cancellation_rate>avg_cancellation_rate;


--Q3. Most Popular Route by Month
--Approch:

WITH popular_route AS (
SELECT
    DATEFROMPARTS(YEAR(booking_date),MONTH(booking_date),1) AS booking_month,
	COUNT(booking_id) AS completed_bookings,
	transport_type,
	R.route_id,
	R.route_name
FROM routes R
LEFT JOIN bookings B
ON R.route_id=B.route_id
WHERE booking_status='Completed'
GROUP BY transport_type,R.route_id,R.route_name,DATEFROMPARTS(YEAR(booking_date),MONTH(booking_date),1)
)
, Popular_route2 AS(
SELECT
	booking_month,
	completed_bookings,
	transport_type,
	route_id,
	route_name,
	DENSE_RANK() OVER(PARTITION BY booking_month,transport_type ORDER BY completed_bookings DESC) AS route_rank
FROM popular_route
)
SELECT 
	booking_month,
	completed_bookings,
	transport_type,
	route_rank,
	route_id,
	route_name
FROM Popular_route2
WHERE route_rank = 1;


--Q4. Customer Booking Sequenc
--Approch:
--apply window fuctions ROW_NUMBER() for ranking customers booking date
--LEG to find previuos dates
--thn subtract current_date - previous date using DATEDIFF FUNCTION

WITH customer_rank AS (
    SELECT 
        C.customer_id,
        C.customer_name,
        B.booking_id,
        B.booking_date,
        B.journey_date,
        ROW_NUMBER() OVER(
            PARTITION BY C.customer_id 
            ORDER BY B.booking_date ASC
        ) AS booking_sequence,
        LAG(B.booking_date) OVER(
            PARTITION BY C.customer_id 
            ORDER BY B.booking_date ASC
        ) AS previous_booking_date
    FROM customers C
    INNER JOIN bookings B 
        ON C.customer_id = B.customer_id
),
customer_rank1 AS (
    SELECT 
        customer_id,
        customer_name,
        booking_id,
        booking_date,
        journey_date,
        booking_sequence,
        previous_booking_date,
        DATEDIFF(DAY, previous_booking_date, booking_date) AS days_since_previous_booking
    FROM customer_rank
)
SELECT
    customer_id,
    customer_name,
    booking_id,
    booking_date,
    journey_date,
    booking_sequence,
    previous_booking_date,
    days_since_previous_booking
FROM customer_rank1
ORDER BY customer_id, booking_sequence;


--Q5. Revenue vs Route Average
--Approch
--apply aggeregation function to find avg booking amount by route

SELECT 
	booking_id,
	route_id,
	route_name,
	transport_type,
	customer_name,
    booking_amount,
	avg_booking_amount
FROM(
SELECT
	B.booking_id,
	R.route_id,
	route_name,
	transport_type,
	customer_name,
    booking_amount,
	ROUND(AVG(booking_amount) OVER(PARTITION BY R.route_id),2) AS avg_booking_amount
FROM customers C
INNER JOIN bookings B
ON C.customer_id=B.customer_id
INNER JOIN routes R
ON B.route_id=R.route_id
WHERE booking_status = 'Completed')T
WHERE booking_amount>avg_booking_amount


