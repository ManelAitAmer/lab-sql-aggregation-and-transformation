USE sakila;
-- ===========================
-- Challenge 1 :

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT 
MAX(length) AS 'max_duration',
MIN(length) AS 'min_duration'
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT 
avg(length) AS 'minutes_duration',
FLOOR(AVG(length) / 60) AS hours,
MOD(FLOOR(AVG(length)), 60) AS minutes
FROM film;

-- ==========================================================================================================================================================================================

-- 2. You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT 
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    rental_id,
    DATE_FORMAT(rental_date, '%d-%m-%Y') AS rental_date,
    inventory_id,
    customer_id,
    DATE_FORMAT(return_date, '%d-%m-%Y') AS return_date,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.

SELECT title,

CASE 
    WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE CAST(rental_duration AS CHAR)
END AS rental_duration
FROM film
ORDER BY title ASC;

-- =========================================================================================================================================================================================================================================================================================================
-- Challenge 2:
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(*) AS total_films_released
FROM film;

-- 1.2 The number of films for each rating.

SELECT COUNT(*) AS films_per_rating
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film 

SELECT rating,
COUNT(*) AS films_per_rating
FROM film
GROUP BY rating
ORDER BY films_per_rating DESC;

-- ====================================================================================================================================================================================================================================================================================================================================================

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating,
ROUND(AVG(length),2) AS 'mean_film_duration' 
FROM film
GROUP BY rating
ORDER BY mean_film_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating,
ROUND(AVG(length),2) AS 'mean_film_duration' 
FROM film
GROUP BY rating
HAVING mean_film_duration > 120
ORDER BY mean_film_duration DESC;

-- Bonus: determine which last names are not repeated in the table actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)=1;
