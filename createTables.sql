create database sakila;
use sakila;

create table actor (
	actor_id int ,
    first_name varchar(100),
    last_name varchar(100),
    primary key(actor_id)
);

create table category (
	category_id int,
    name varchar(50),
    primary key(category_id)
);

create table language (
	language_id int,
    name varchar(50),
    primary key (language_id)
);

create table country(
	country_id int,
    country_name varchar(255),
    primary key (country_id)
);

create table city (
	city_id int,
    city_name varchar(255),
    country_id int,
    primary key (city_id),
    foreign key(country_id) references country(country_id)
);

create table film (
	film_id int,
	title varchar(255),
	description text,
	release_year year,
	language_id int,
	original_language_id int,
	rental_duration int,
	rental_rate float,
	length int,
	replacement_cost float,
	rating varchar(50),
	special_features text,
    primary key(film_id),
    foreign key(language_id) references language(language_id)
);

create table film_category(
	film_id int,
    category_id int,
    primary key (category_id, film_id),
    foreign key (category_id) references category(category_id),
    foreign key (film_id) references film(film_id)
);

create table address(
	address_id int,
    address text,
    address2 text,
    district varchar(255),
    city_id int,
    postal_code int,
    phone int,
    primary key (address_id),
    foreign key(city_id) references city(city_id)
);

create table inventory (
	inventory_id int,
    film_id int,
    store_id int
);
    
alter table inventory 
	add constraint primary key(inventory_id), 
	add constraint foreign key(film_id) references film(film_id),
	add constraint foreign key (store_id) references store(store_id);
    

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
	add constraint foreign key (staff_id) references store(store_id);

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
	actor_id int,
    film_id int,
    foreign key(film_id) references film(film_id),
    foreign key(actor_id) references actor(actor_id)
);

alter table film_actor 
add constraint primary key (actor_id, film_id); 

show tables;