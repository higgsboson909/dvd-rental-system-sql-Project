create database project;
use project;

create table actor(			--select Distinct first_name from actor
	actor_id int ,
    first_name varchar(100),
    last_name varchar(100),
    primary key(actor_id)
);

create table category(			--data is inserted
	category_id int,
    name varchar(50),
    primary key(category_id)
);

create table language(			--select * from language
	language_id int,
    name varchar(50),
    primary key (language_id)
);

create table country(			-- created
	country_id int,
    country_name varchar(255),
    primary key (country_id)
);

create table city(				--SELECT * FROM city
	city_id int,
    city_name varchar(255),
    country_id int,
    primary key (city_id),
    foreign key(country_id) references country(country_id)
);


create table film(			--inserted data
	film_id int,
	title varchar(255),
	description text,
	release_year int,
	language_id int,
	rental_duration int,
	rental_rate float,
	replacement_cost float,
	rating varchar(50),
    primary key(film_id),
    foreign key(language_id) references language(language_id)
);

create table film_category(			--data inserted
	film_id int,
    category_id int,
    primary key (category_id, film_id),
    foreign key (category_id) references category(category_id),
    foreign key (film_id) references film(film_id)
);

create table address(				--data inserted
	address_id int,
    address text,
    city_id int,
    postal_code int,
    phone int,
    primary key (address_id),
    foreign key(city_id) references city(city_id)
);
drop table address

create table inventory (
	inventory_id int primary key,
    film_id int,
    store_id int
	foreign key(film_id) references film(film_id),
	foreign key (store_id) references store(store_id)
    
);
    

create table staff (
	staff_id int,
    first_name varchar(100),
    last_name varchar(100),
    address_id int,
    picture varchar(255),
    email varchar(100),
    store_id int,
    active int,
    username varchar(100),
    password varchar(100),
    primary key(staff_id),
    foreign key (address_id) references address(address_id)
);

create table store (
	store_id int,
    manager_staff_id int,
    address_id int,
    primary key(store_id),
    foreign key (address_id) references address(address_id),
    foreign key (manager_staff_id) references staff(staff_id)
);

alter table staff
	ADD foreign key (staff_id) references store(store_id);

create table customer(
	customer_id int,
    store_id int,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100),
    address_id int,
    active int,
    primary key (customer_id),
    foreign key (store_id) references store(store_id),
    foreign key (address_id) references address(address_id)
);

create table rental (
	rental_id int,
    inventory_id int,
    customer_id int,
    staff_id int,
    primary key (rental_id),
    foreign key (inventory_id) references inventory(inventory_id),
    foreign key (customer_id) references customer(customer_id),
    foreign key (staff_id) references staff(staff_id)
);

create table payment(
	payment_id int,
    customer_id int,
    staff_id int,
    rental_id int,
    amount float,
    primary key (payment_id),
    foreign key (customer_id) references customer(customer_id),
    foreign key (staff_id) references staff(staff_id),
    foreign key (rental_id) references rental(rental_id)
);

create table film_actor(
	actor_id int NOT NULL,
    film_id int NOT NULL,
    foreign key(film_id) references film(film_id),
    foreign key(actor_id) references actor(actor_id)
);

alter table film_actor 
add primary key (actor_id, film_id); 

drop database project1