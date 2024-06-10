
--no of actors
select count(distinct(actor_id)) as number_of_actors from actor;

-- display actor full_name by concatenating
select left(first_name, 1) + lower(substring(first_name, 2, len(first_name))) +
' ' + left(last_name, 1) + lower(substring(last_name, 2, len(last_name)))
from actor

-- find the number of actors whose last_name is same
select last_name, count(last_name)
from actor
group by last_name

-- There exists 7 duplicate record by the last_name of Ahmed
select concat(first_name, ' ', last_name) as full_name
from actor
where last_name like '%Ahmed%';

-- Category Table 
select * from category;

select count(distinct(name)) as no_of_category from category;



-- 1.	Countries where the services are provided.
select * from country;

-- 2.	Countries having the highest cities.
select country.country_name, COUNT(city.country_id) as no_of_cities
from country
inner join city on country.country_id = city.country_id
group by country.country_name
order by no_of_cities desc;


-- 3.	Countries with having the highest customers. 
select country.country_name, COUNT(customer.customer_id) as no_of_customers
from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
group by country.country_name
order by no_of_customers desc; 

-- 4.	Cities having the highest number of customers.
select city.city_name, COUNT(customer.customer_id) as no_of_customers,
       SUM(COUNT(customer.customer_id)) over (order by COUNT(customer.customer_id) desc, city.city_name) as running_total
from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
group by city.city_name
order by no_of_customers desc;

 
-- 5.	Countries having the highest rental.
select country.country_name, COUNT(rental.rental_id) as number_of_rentals,
       SUM(COUNT(rental.rental_id)) over (order by COUNT(rental.rental_id) desc, country.country_name) as running_total
from country
inner join city on country.country_id = city.country_id
inner join address on city.city_id = address.city_id
inner join customer on address.address_id = customer.address_id
inner join rental on customer.customer_id = rental.customer_id
group by country.country_name
order by number_of_rentals desc;


-- 6.	Countries receiving largest payment.
select country.country_name, ROUND(SUM(payment.amount), 2) as rcv_payments,
       SUM(ROUND(SUM(payment.amount), 2)) over (order by ROUND(SUM(payment.amount), 2) desc, country.country_name) as running_total
from country
inner join city on country.country_id = city.country_id
inner join address on city.city_id = address.city_id
inner join customer on address.address_id = customer.address_id
inner join payment on customer.customer_id = payment.customer_id
group by country.country_name
order by rcv_payments desc;


-- 7.	Cities having the highest rental.
select 
    city_name, 
    COUNT(rental_id) as number_of_rentals, 
    SUM(COUNT(rental_id)) over (order by COUNT(rental_id) desc, city_name) as running_total
from 
    city 
join 
    address on address.city_id = city.city_id
join 
    customer on customer.address_id = address.address_id
join 
    rental on rental.customer_id = customer.customer_id
group by 
    city_name
order by 
    number_of_rentals desc;

-- 8.	Cities having the highest revenue.
select 
    city_name, 
    ROUND(SUM(amount), 2) as rcv_payments, 
    SUM(ROUND(SUM(amount), 2)) over (order by ROUND(SUM(amount), 2) desc, city_name) as running_total
from 
    city 
join 
    address on address.city_id = city.city_id
join 
    customer on customer.address_id = address.address_id
join 
    payment on payment.customer_id = customer.customer_id
group by 
    city_name
order by 
    rcv_payments desc;

 
-- 9.	Customers having the highest rental.
select customer.first_name + ' ' + customer.last_name as full_name, 
       COUNT(rental.rental_id) as no_of_rentals
from rental
inner join customer on rental.customer_id = customer.customer_id
group by (customer.first_name  + ' ' + customer.last_name)
order by no_of_rentals desc;

-- 10.	Customer who produced the highest revenue
select top 15 customer.first_name + ' ' + customer.last_name as full_name,
       ROUND(SUM(amount), 2) as rcv_amount
from customer
inner join rental on customer.customer_id = rental.customer_id
inner join payment on rental.rental_id = payment.rental_id
group by customer.first_name + ' ' + customer.last_name
order by rcv_amount desc;


-- 11.	Store has the highest rental.

select store.store_id, COUNT(rental.rental_id) as no_of_rented_dvds
from store
inner join inventory on store.store_id = inventory.store_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by store.store_id
order by COUNT(rental.rental_id) desc;

-- 12.	Staff offering the highest rental.
select concat(staff.first_name, ' ' , staff.last_name) as staff_name,
count(rental_id) as no_of_rented_dvds
from staff
inner join rental on staff.staff_id = rental.staff_id
group by concat(staff.first_name, ' ' , staff.last_name)
order by no_of_rented_dvds desc


-- 13.	Store collecting the highest revenue.

select 
    store.store_id, 
    ROUND(SUM(payment.amount), 2) as rcv_amount
from 
    store
inner join 
    inventory on inventory.store_id = store.store_id
inner join 
    rental on inventory.inventory_id = rental.inventory_id
inner join 
    payment on payment.rental_id = rental.rental_id
group by 
    store.store_id
order by 
    rcv_amount desc;

 
-- 14.	Staff collecting the highest payment.
select 
    staff.first_name + ' ' + staff.last_name as staff_name, 
    ROUND(SUM(payment.amount), 2) as amount_by_staff
from 
    staff
inner join 
    payment on staff.staff_id = payment.staff_id
group by 
    staff.first_name + ' ' + staff.last_name
order by 
    2 desc;

-- 15.	Actor with the highest number of movies.

select 
    concat(actor.first_name, ' ', actor.last_name) as actor_name, 
    COUNT(film_actor.film_id) as no_of_movies
from 
    actor
inner join 
    film_actor on actor.actor_id = film_actor.actor_id
group by 
    concat(actor.first_name, ' ', actor.last_name)
order by 
    no_of_movies desc;


-- 16.	Movies with the highest rental.
select 
    film.title, 
    COUNT(rental.rental_id) as no_of_rentals
from 
    film
inner join 
    inventory on film.film_id = inventory.film_id
inner join 
    rental on rental.inventory_id = inventory.inventory_id
group by 
    film.title
order by 
    no_of_rentals desc;



-- 17.	Movies with the highest payment

select 
    film.title, 
    SUM(payment.amount) as total_amount
from 
    film
inner join 
    inventory on film.film_id = inventory.film_id
inner join 
    rental on rental.inventory_id = inventory.inventory_id
inner join
	payment on payment.rental_id = rental.rental_id
group by 
    film.title
order by 
    2 desc;


-- 18.	Which actors movie is the highest grossing.

select 
    ConCAT(actor.first_name, ' ', actor.last_name) as actor_name, 
    ROUND(SUM(payment.amount), 2) as total_amt
from 
    actor
inner join 
    film_actor on actor.actor_id = film_actor.actor_id
inner join 
    film on film_actor.film_id = film.film_id
inner join 
    inventory on film.film_id = inventory.film_id
inner join 
    rental on inventory.inventory_id = rental.inventory_id
inner join 
    payment on rental.rental_id = payment.rental_id
group by 
    ConCAT(actor.first_name, ' ', actor.last_name)
order by 
    total_amt desc;


-- 19. Write a query to find the full names of customers who have rented science fiction, comedy, action and drama movies highest times.

select 
    concat(customer.first_name, ' ', customer.last_name) as customer_name,
    count(category.category_id) as no_of_times_rented
from 
    customer
inner join 
    rental on customer.customer_id = rental.customer_id
inner join 
    inventory on inventory.inventory_id = rental.inventory_id
inner join 
    film on film.film_id = inventory.film_id
inner join 
    film_category on film_category.film_id = film.film_id
inner join 
    category on category.category_id = film_category.category_id
WHERE 
    category.name IN ('Sci-Fi', 'Comedy', 'Action', 'Drama')
group by 
    ConCAT(customer.first_name, ' ', customer.last_name)
order by 
    no_of_times_rented desc;

-- 20. Film title with Language
select DISTINCT 
    film.title,
    language.name
from 
    film
inner join 
    language on language.language_id = film.language_id;

-- 21.language category and name
select DISTINCT 
    film.title,
    category.name,
    language.name as laguage
from 
    category
inner join 
    film_category on category.category_id = film_category.category_id
inner join 
    film on film_category.film_id = film.film_id
inner join 
    language on film.language_id = language.language_id;

-- 22. Rentals each month
select 
    DATENAME(MonTH, rental_date) as month_no, 
    COUNT(rental_id) as no_of_rentals
from 
    rental
group by 
    DATENAME(MonTH, rental_date)
order by 
    no_of_rentals desc;

-- 23. Revenue per month
select 
    DATENAME(MonTH, payment_date) as month, 
    ROUND(SUM(amount), 2) as total_amount
from 
    payment
group by 
    DATENAME(MonTH, payment_date)
order by 
    total_amount desc;

-- 24. Highest grossing year
select 
    YEAR(payment_date) as year, 
    ROUND(SUM(amount), 2) as revenue
from 
    payment
group by 
    YEAR(payment_date)
order by 
    revenue desc;

-- 24. Revenue between dates.
select 
    ROUND(SUM(amount), 2) as revenue_amt
from 
    payment
WHERE 
    payment_date >= DATE AND payment_date <= DATE;

-- 25. Distinct renters per month.
select 
    DATENAME(MonTH, rental_date) as month_no, 
    COUNT(DISTINCT rental.customer_id) as no_of_rentals
from 
    rental
inner join 
    customer 
on 
    rental.customer_id = customer.customer_id
group by 
    DATENAME(MonTH, rental_date)
order by 
    no_of_rentals desc;


-- 26. Which is the most popular genres.
select 
    category.name, 
    COUNT(rental.rental_id) as no_of_rentals
from 
    category
inner join 
    film_category on category.category_id = film_category.category_id
inner join 
    film on film.film_id = film_category.film_id
inner join 
    inventory on film.film_id = inventory.film_id
inner join 
    rental on inventory.inventory_id = rental.inventory_id
group by 
    category.name
order by 
    no_of_rentals desc;

-- 26-a. Which is the highest grossing genre.
select 
    category.name, 
    COUNT(rental.rental_id) as no_of_rentals, 
    ROUND(SUM(payment.amount), 2) as revenue
from 
    category
inner join 
    film_category on category.category_id = film_category.category_id
inner join 
    film on film.film_id = film_category.film_id
inner join 
    inventory on film.film_id = inventory.film_id
inner join 
    rental on inventory.inventory_id = rental.inventory_id
inner join 
    payment on rental.rental_id = payment.rental_id
group by 
    category.name
order by 
    no_of_rentals desc;

--27 top 10 customers by rental frequency
select customer.customer_id, COUNT(rental.rental_id) as rental_frequency
from customer
inner join rental on customer.customer_id = rental.customer_id
group by customer.customer_id;

--28 no_of_categories for a specific film
select film.title, count(film_category.category_id) as no_of_categories
from film
inner join film_category on film.film_id = film_category.film_id
group by film.title

--29 no_of_films for a specific category
select category.name, count(film_category.category_id) as no_of_films
from category
inner join film_category on category.category_id = film_category.category_id
group by category.name
order by count(film_category.category_id) desc

--30 average rate of movies under a certain category
select category.name, round(avg(film.rental_rate), 2) as avg_rental_rate
from category
left join 
	film_category on category.category_id = film_category.category_id
left join 
	film on film_category.film_id = film.film_id
group by category.name
order by 2 desc

--31 total of rental_rate for certain category
select category.name, round(sum(film.rental_rate), 2) as total_rental_rate
from category
left join
	film_category on category.category_id = film_category.category_id
left join
	film on film_category.film_id = film.film_id
group by category.name
order by 2 desc

--32  find all customers who have rented a film in a specific category
select customer.customer_id, concat(customer.first_name, ' ', customer.last_name) as full_name,
customer.email, customer.address_id, category.category_id, category.name
from customer
inner join rental on customer.customer_id = rental.customer_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film_category on inventory.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where category.category_id = 1 -- replace with any category_id

--33 find customers who live in specific city
select city.city_name, * 
from customer
inner join address on customer.address_id = address.address_id
inner join city on city.city_id = address.city_id
where city.city_id = 3

--34 get all films by actor_id
select concat(actor.first_name, ' ', actor.last_name) as full_name, film.title from film
inner join film_actor on film.film_id = film_actor.film_id
inner join actor on film_actor.actor_id = actor.actor_id
WHERE film_actor.actor_id = 32;  -- Replace with desired actor ID
