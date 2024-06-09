
-- 1.	Countries where the services are provided.
select * from country;

-- 2.	Countries having the highest cities.
SELECT country.country_name, COUNT(city.country_id) AS no_of_cities
FROM country
INNER JOIN city ON country.country_id = city.country_id
GROUP BY country.country_name
ORDER BY no_of_cities DESC;


-- 3.	Countries with having the highest customers. 
SELECT country.country_name, COUNT(customer.customer_id) AS no_of_customers
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country.country_name
ORDER BY no_of_customers DESC; 

-- 4.	Cities having the highest number of customers.
SELECT city.city_name, COUNT(customer.customer_id) AS no_of_customers,
       SUM(COUNT(customer.customer_id)) OVER (ORDER BY COUNT(customer.customer_id) DESC, city.city_name) AS running_total
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
GROUP BY city.city_name
ORDER BY no_of_customers DESC;

 
-- 5.	Countries having the highest rental.
SELECT country.country_name, COUNT(rental.rental_id) AS number_of_rentals,
       SUM(COUNT(rental.rental_id)) OVER (ORDER BY COUNT(rental.rental_id) DESC, country.country_name) AS running_total
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY country.country_name
ORDER BY number_of_rentals DESC;


-- 6.	Countries receiving largest payment.
SELECT country.country_name, ROUND(SUM(payment.amount), 2) AS rcv_payments,
       SUM(ROUND(SUM(payment.amount), 2)) OVER (ORDER BY ROUND(SUM(payment.amount), 2) DESC, country.country_name) AS running_total
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY country.country_name
ORDER BY rcv_payments DESC;


-- 7.	Cities having the highest rental.
SELECT 
    city_name, 
    COUNT(rental_id) AS number_of_rentals, 
    SUM(COUNT(rental_id)) OVER (ORDER BY COUNT(rental_id) DESC, city_name) AS running_total
FROM 
    city 
JOIN 
    address ON address.city_id = city.city_id
JOIN 
    customer ON customer.address_id = address.address_id
JOIN 
    rental ON rental.customer_id = customer.customer_id
GROUP BY 
    city_name
ORDER BY 
    number_of_rentals DESC;

-- 8.	Cities having the highest revenue.
SELECT 
    city_name, 
    ROUND(SUM(amount), 2) AS rcv_payments, 
    SUM(ROUND(SUM(amount), 2)) OVER (ORDER BY ROUND(SUM(amount), 2) DESC, city_name) AS running_total
FROM 
    city 
JOIN 
    address ON address.city_id = city.city_id
JOIN 
    customer ON customer.address_id = address.address_id
JOIN 
    payment ON payment.customer_id = customer.customer_id
GROUP BY 
    city_name
ORDER BY 
    rcv_payments DESC;

 
-- 9.	Customers having the highest rental.
SELECT customer.first_name + ' ' + customer.last_name AS full_name, 
       COUNT(rental.rental_id) AS no_of_rentals
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY (customer.first_name  + ' ' + customer.last_name)
ORDER BY no_of_rentals DESC;

-- 10.	Customer who produced the highest revenue(entire with address).
SELECT customer.first_name + ' ' + customer.last_name AS full_name,
       ROUND(SUM(amount), 2) AS rcv_amount
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.first_name + ' ' + customer.last_name
ORDER BY rcv_amount DESC;


-- 11.	Store has the highest rental.

SELECT store.store_id, COUNT(rental.rental_id) AS no_of_rented_dvds
FROM store
INNER JOIN inventory ON store.store_id = inventory.store_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY store.store_id
ORDER BY COUNT(rental.rental_id) DESC;

-- 12.	Staff offering the highest rental.
select concat(staff.first_name, ' ' , staff.last_name) AS staff_name,
count(rental_id) as no_of_rented_dvds
from staff
inner join rental on staff.staff_id = rental.staff_id
group by concat(staff.first_name, ' ' , staff.last_name)
order by no_of_rented_dvds desc


-- 13.	Store collecting the highest revenue.

SELECT 
    store.store_id, 
    ROUND(SUM(payment.amount), 2) AS rcv_amount
FROM 
    store
INNER JOIN 
    inventory ON inventory.store_id = store.store_id
INNER JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN 
    payment ON payment.rental_id = rental.rental_id
GROUP BY 
    store.store_id
ORDER BY 
    rcv_amount DESC;

 
-- 14.	Staff collecting the highest payment.
SELECT 
    staff.first_name + ' ' + staff.last_name AS staff_name, 
    ROUND(SUM(payment.amount), 2)
FROM 
    staff
INNER JOIN 
    payment ON staff.staff_id = payment.staff_id
GROUP BY 
    staff.first_name + ' ' + staff.last_name
ORDER BY 
    2 DESC;

-- 15.	Actor with the highest number of movies.

SELECT 
    concat(actor.first_name, ' ', actor.last_name) as actor_name, 
    COUNT(film_actor.film_id) AS no_of_movies
FROM 
    actor
INNER JOIN 
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY 
    concat(actor.first_name, ' ', actor.last_name)
ORDER BY 
    no_of_movies DESC;


-- 16.	Movies with the highest rental.
SELECT 
    film.title, 
    COUNT(rental.rental_id) AS no_of_rentals
FROM 
    film
INNER JOIN 
    inventory ON film.film_id = inventory.film_id
INNER JOIN 
    rental ON rental.inventory_id = inventory.inventory_id
GROUP BY 
    film.title
ORDER BY 
    no_of_rentals DESC;



-- 17.	Movies with the highest payment

SELECT 
    film.title, 
    SUM(payment.amount) AS total_amount
FROM 
    film
INNER JOIN 
    inventory ON film.film_id = inventory.film_id
INNER JOIN 
    rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN
	payment ON payment.rental_id = rental.rental_id
GROUP BY 
    film.title
ORDER BY 
    2 DESC;


-- 18.	Which actors movie is the highest grossing.

SELECT 
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name, 
    ROUND(SUM(payment.amount), 2) AS total_amt
FROM 
    actor
INNER JOIN 
    film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN 
    film ON film_actor.film_id = film.film_id
INNER JOIN 
    inventory ON film.film_id = inventory.film_id
INNER JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN 
    payment ON rental.rental_id = payment.rental_id
GROUP BY 
    CONCAT(actor.first_name, ' ', actor.last_name)
ORDER BY 
    total_amt DESC;


-- 19. Write a query to find the full names of customers who have rented science fiction, comedy, action and drama movies highest times.

SELECT 
    CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    COUNT(category.category_id) AS no_of_times_rented
FROM 
    customer
INNER JOIN 
    rental ON customer.customer_id = rental.customer_id
INNER JOIN 
    inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN 
    film ON film.film_id = inventory.film_id
INNER JOIN 
    film_category ON film_category.film_id = film.film_id
INNER JOIN 
    category ON category.category_id = film_category.category_id
WHERE 
    category.name IN ('Sci-Fi', 'Comedy', 'Action', 'Drama')
GROUP BY 
    CONCAT(customer.first_name, ' ', customer.last_name)
ORDER BY 
    no_of_times_rented DESC;

-- 20. Film title with Language
SELECT DISTINCT 
    film.title,
    language.name
FROM 
    film
INNER JOIN 
    language ON language.language_id = film.language_id;

-- 21.language category and name
SELECT DISTINCT 
    film.title,
    category.name,
    language.name AS laguage
FROM 
    category
INNER JOIN 
    film_category ON category.category_id = film_category.category_id
INNER JOIN 
    film ON film_category.film_id = film.film_id
INNER JOIN 
    language ON film.language_id = language.language_id;

-- 21. Rentals each month
SELECT 
    DATENAME(MONTH, rental_date) AS month_no, 
    COUNT(rental_id) AS no_of_rentals
FROM 
    rental
GROUP BY 
    DATENAME(MONTH, rental_date)
ORDER BY 
    no_of_rentals DESC;

-- 22. Revenue per month
SELECT 
    DATENAME(MONTH, payment_date) AS month_no, 
    ROUND(SUM(amount), 2) AS total_amount
FROM 
    payment
GROUP BY 
    DATENAME(MONTH, payment_date)
ORDER BY 
    total_amount DESC;

-- 23. Highest grossing year
SELECT 
    YEAR(payment_date) AS year, 
    ROUND(SUM(amount), 2) AS revenue
FROM 
    payment
GROUP BY 
    YEAR(payment_date)
ORDER BY 
    revenue DESC;

-- 24. Revenue between dates.
SELECT 
    ROUND(SUM(amount), 2) AS revenue_amt
FROM 
    payment
WHERE 
    payment_date >= DATE AND payment_date <= DATE;

-- 25. Distinct renters per month.
SELECT 
    DATENAME(MONTH, rental_date) AS month_no, 
    COUNT(DISTINCT rental.customer_id) AS no_of_rentals
FROM 
    rental
INNER JOIN 
    customer 
ON 
    rental.customer_id = customer.customer_id
GROUP BY 
    DATENAME(MONTH, rental_date)
ORDER BY 
    no_of_rentals DESC;


-- 26. Which is the most popular genres.
SELECT 
    category.name, 
    COUNT(rental.rental_id) AS no_of_rentals
FROM 
    category
INNER JOIN 
    film_category ON category.category_id = film_category.category_id
INNER JOIN 
    film ON film.film_id = film_category.film_id
INNER JOIN 
    inventory ON film.film_id = inventory.film_id
INNER JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    category.name
ORDER BY 
    no_of_rentals DESC;

-- 26. Which is the highest grossing genre.
SELECT 
    category.name, 
    COUNT(rental.rental_id) AS no_of_rentals, 
    ROUND(SUM(payment.amount), 2) AS revenue
FROM 
    category
INNER JOIN 
    film_category ON category.category_id = film_category.category_id
INNER JOIN 
    film ON film.film_id = film_category.film_id
INNER JOIN 
    inventory ON film.film_id = inventory.film_id
INNER JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN 
    payment ON rental.rental_id = payment.rental_id
GROUP BY 
    category.name
ORDER BY 
    no_of_rentals DESC;

-- top 10 customers by rental frequency
SELECT customer.customer_id, COUNT(rental.rental_id) AS rental_frequency
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

-- no_of_categories for a specific film
select film.title, count(film_category.category_id) as no_of_categories
from film
inner join film_category on film.film_id = film_category.film_id
group by film.title

-- no_of_films for a specific category
select category.name, count(film_category.category_id) as no_of_films
from category
inner join film_category on category.category_id = film_category.category_id
group by category.name
order by count(film_category.category_id) DESC

-- average rate of movies under a certain category
select category.name, round(avg(film.rental_rate), 2) as avg_rental_rate
from category
inner join 
	film_category on category.category_id = film_category.category_id
inner join 
	film on film_category.film_id = film.film_id
group by category.name
order by 2 DESC

-- sum of rental_rate for certain category
select category.name, round(sum(film.rental_rate), 2) as rental_rate_sum
from category
inner join
	film_category on category.category_id = film_category.category_id
inner join
	film on film_category.film_id = film.film_id
group by category.name
order by 2 desc


