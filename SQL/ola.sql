USE olacabs;

# Ride Volume Over Time - Daily Ride Volume
SELECT
    DATE(`Date`) AS ride_date,
    COUNT(*) AS total_rides
FROM olacabs_bookings
GROUP BY DATE(`Date`)
ORDER BY ride_date;

# Booking Status Breakdown
SELECT
    Booking_Status,
    COUNT(*) AS total_bookings
FROM olacabs_bookings
GROUP BY Booking_Status
ORDER BY total_bookings DESC;

# Top 5 Vehicle Types by Ride Distance
SELECT
    Vehicle_Type,
    SUM(Ride_Distance) AS total_distance
FROM olacabs_bookings
GROUP BY Vehicle_Type
ORDER BY total_distance DESC
LIMIT 5;

# Average Customer Ratings by Vehicle Type
SELECT
    Vehicle_Type,
    ROUND(AVG(Driver_Rating), 2) AS avg_driver_rating,
    ROUND(AVG(Customer_Rating), 2) AS avg_customer_rating
FROM olacabs_bookings
WHERE Customer_Rating IS NOT NULL
GROUP BY Vehicle_Type
ORDER BY avg_customer_rating DESC;

# Cancelled Ride Reasons - Customer and Driver
SELECT
    Cancelled_Rides_by_Customer AS reason,
    COUNT(*) AS total
FROM olacabs_bookings
WHERE Cancelled_Rides_by_Customer IS NOT NULL
      AND Cancelled_Rides_by_Customer <> ''
GROUP BY Cancelled_Rides_by_Customer
ORDER BY total DESC;

SELECT
    Cancelled_Rides_by_Driver AS reason,
    COUNT(*) AS total
FROM olacabs_bookings
WHERE Cancelled_Rides_by_Driver IS NOT NULL
      AND Cancelled_Rides_by_Driver <> ''
GROUP BY Cancelled_Rides_by_Driver
ORDER BY total DESC;

# Revenue by Payment Method
SELECT
    Payment_Method,
    ROUND(SUM(Booking_Value), 2) AS revenue
FROM olacabs_bookings
GROUP BY Payment_Method
ORDER BY revenue DESC;

# Top 5 Customers by Total Booking Value
SELECT
    Customer_ID,
    ROUND(SUM(Booking_Value), 2) AS total_booking_value
FROM olacabs_bookings
GROUP BY Customer_ID
ORDER BY total_booking_value DESC
LIMIT 5;

# Average Ride Distance Distribution Per Day
SELECT
    DATE(`Date`) AS ride_date,
    ROUND(AVG(Ride_Distance), 2) AS avg_distance,
    MIN(Ride_Distance) AS min_distance,
    MAX(Ride_Distance) AS max_distance
FROM olacabs_bookings
GROUP BY DATE(`Date`)
ORDER BY ride_date;

# Total Ride Distance Distribution Per Day
SELECT
    DATE(`Date`) AS ride_date,
    SUM(Ride_Distance) AS total_distance
FROM olacabs_bookings
GROUP BY DATE(`Date`)
ORDER BY ride_date;

# Driver Ratings Distribution
SELECT
    ROUND(Driver_Rating, 1) AS rating,
    COUNT(*) AS frequency
FROM olacabs_bookings
WHERE Driver_Rating IS NOT NULL
GROUP BY ROUND(Driver_Rating, 1)
ORDER BY rating;

# Customer vs Driver Ratings - Average and Rating Relationship
SELECT
    ROUND(AVG(Customer_Rating), 2) AS avg_customer_rating,
    ROUND(AVG(Driver_Rating), 2) AS avg_driver_rating
FROM olacabs_bookings;

SELECT
    Customer_Rating,
    Driver_Rating
FROM olacabs_bookings
WHERE Customer_Rating IS NOT NULL
      AND Driver_Rating IS NOT NULL;

# All successful bookings
SELECT * FROM olacabs_bookings 
WHERE Booking_Status = 'Success';

# Average ride distance for each vehicle type
SELECT Vehicle_Type, AVG(Ride_Distance) AS avg_ride_distance
FROM olacabs_bookings
GROUP BY Vehicle_Type;

# Total number of cancelled rides by customers
SELECT COUNT(*)
FROM olacabs_bookings
WHERE Booking_Status = 'Cancelled by Customer';	

# Top 5 customers who booked the highest number of rides
SELECT Customer_ID, COUNT(Booking_ID) AS total_rides
FROM olacabs_bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC
LIMIT 5;

# Number of rides cancelled by drivers due to personal and car-related issues
SELECT COUNT(*)
FROM olacabs_bookings
WHERE Cancelled_Rides_by_Driver = 'Personal & Car related issue';

# Maximum and Minimum driver ratings for Prime Sedan bookings
SELECT MAX(Driver_Rating) AS max_rating, MIN(Driver_Rating) AS min_rating
FROM olacabs_bookings
WHERE Vehicle_Type = 'Prime Sedan';

# Rides where payment was made using UPI
SELECT * FROM olacabs_bookings
WHERE Payment_Method = 'UPI';

# Average customer rating per vehicle type
SELECT Vehicle_Type, AVG(Customer_Rating) AS avg_customer_rating
FROM olacabs_bookings
GROUP BY Vehicle_Type;

# Total booking value of rides completed successfully
SELECT SUM(Booking_Value) AS total_booking_value
FROM olacabs_bookings
WHERE Booking_Status = 'Success';

# Incomplete rides along with the reason
SELECT Booking_ID, Incomplete_Rides_Reason
FROM olacabs_bookings
WHERE Incomplete_Rides = 'Yes';