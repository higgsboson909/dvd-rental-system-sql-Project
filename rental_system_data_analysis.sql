
-- 1.	Countries where the services are provided.
select * from country;
-- The DVD rental service is provided in  countries

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
select city_name, count(rental_id) as number_of_rentals, 
sum(count(rental_id)) over (order by count(rental_id) desc, city_name ) as running_total
from city b 
join address c on c.city_id = b.city_id
join customer d on d.address_id = c.address_id
join rental e on d.customer_id = e.customer_id
group by 1
order  by 2 desc;
-- Aurora city in the USA has the highest amount of rentals, 50.

-- 8.	Cities having the highest revenue.
select city_name, round(sum(amount), 2) as rcv_payments, 
sum(round(sum(amount), 2)) over (order by round(sum(amount), 2) desc, city_name ) as running_total
from city b 
join address c on c.city_id = b.city_id
join customer d on d.address_id = c.address_id
join payment e on d.customer_id = e.customer_id
group by 1
order  by 2 desc;
-- Highest amount of payment has been received from Cape Coral, 221.55
 
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
select monthname(rental_date) as month_no, count(rental_id) no_of_rentals 
from rental
group by 1
order by 2 desc;
-- July has the highest rental 6709

-- 22. Revenue per month
select monthname(payment_date) as month_no, round(sum(amount), 2) no_of_rentals
from payment
group by 1
order by 2 desc;
-- July had the highest revenue 28373.89

-- 23. Highest grossing year
select year(payment_date) year, round(sum(amount), 2) revenue
from payment
group by 1
order by 2 desc;
-- 2005 produced the highest revenue

-- 24. Revenue between July, 2005 and January, 2006.
select round(sum(amount), 2) revenue_amt
from payment
where payment_date>= '2005-07-01'and payment_date <= '2006-01-31';

-- 25. Distinct renters per month.
select monthname(rental_date) as month_no, count(distinct(customer_id)) no_of_rentals 
from rental a 
join customer b using(customer_id)
group by 1 
order by 2 desc;
-- August and July has the highest distinct renters 

-- 26. Rentals which encountered no gain.
select a.rental_id, b.amount from rental a left join payment b using(rental_id) where b.amount = 0;

-- 27. Active and Inactive Customers.
select active, count(active) from customer group by active;

-- 28. Customers who bought DVDs instead of renting.
select * from payment where rental_id is null;

-- 29. In which quater was the highest revenue reported.
select 
	case 
		when (date(payment_date) between '2005-01-01' and '2005-03-31') or (date(payment_date) between '2006-01-01' and '2006-03-31') then 'Quarter 1'
        when (date(payment_date) between '2005-04-01' and '2005-06-30') or (date(payment_date) between '2006-04-01' and '2006-06-30') then 'Quarter 2'
        when (date(payment_date) between '2005-07-01' and '2005-09-30') or (date(payment_date) between '2006-07-01' and '2006-09-30') then 'Quater 3'
        when (date(payment_date) between '2005-10-01' and '2005-12-31') or (date(payment_date) between '2006-10-01' and '2006-12-31') then 'Quarter 4'
	end year_quater,
    round(sum(amount), 2) as revenue
 from payment 
 group by 1
 order by 2 desc;
 -- 3rd Quarter reported the maximum revenue of 52446.02
 
 -- 30. In which quater was the highest revenue reported.
 select quarter(rental_date) quarters, count(rental_id) as no_of_rental
 from rental
 group by 1
 order by 2 desc;
 -- 3rd quarter has been reported to have highest rentals with 12395 count
 
 -- 31. Which movie was rented more than 9 days.
 select title, datediff(return_date, rental_date) as rented_days
 from rental 
 join inventory using(inventory_id) 
 join film using(film_id) 
 where datediff(return_date, rental_date)>=10
 group by 1
 order by 2 desc;
 
-- 32. Which customer rented more than 9 days.
select full_name, datediff(return_date, rental_date) as rental_days
from rental 
join customer using(customer_id)
where datediff(return_date, rental_date)>=10
group by 1
order by 2 desc; 

-- 33. Which is the most popular genres.
select a.name , count(e.rental_id) as no_of_rentals
from category a
join film_category b on a.category_id = b.category_id
join film c on c.film_id = b.film_id
join inventory d on c.film_id = d.film_id
join rental e on d.inventory_id = e.inventory_id
group by 1
order by 2 desc;
-- Sports genre has the highest number of rentals.

-- 34. Which is the highest grossing genre.
select a.name , count(e.rental_id) as no_of_rentals, round(sum(f.amount), 2) as revenue
from category a
join film_category b on a.category_id = b.category_id
join film c on c.film_id = b.film_id
join inventory d on c.film_id = d.film_id
join rental e on d.inventory_id = e.inventory_id
join payment f on e.rental_id = f.rental_id
group by 1
order by 2 desc;
-- Sports is the highest grossing genre