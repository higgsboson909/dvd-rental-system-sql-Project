CREATE PROCEDURE sp_InsertCategory
    @name varchar(50)
AS
BEGIN
    DECLARE @category_id int;
    SET @category_id = (SELECT ISNULL(MAX(category_id), 0) + 1 FROM Category);
    INSERT INTO Category (category_id, name)
    VALUES (@category_id, @name);
END;
GO

CREATE PROCEDURE sp_UpdateCategory
    @category_id int,
    @name varchar(50)
AS
BEGIN
    UPDATE Category
    SET name = @name
    WHERE category_id = @category_id;
END;
GO

CREATE PROCEDURE sp_DeleteCategory
    @category_id int
AS
BEGIN
    DELETE FROM Category
    WHERE category_id = @category_id;
END;
GO


--for language table

-- Create procedure to insert a new language
CREATE PROCEDURE sp_InsertLanguage
    @name varchar(50)
AS
BEGIN
    DECLARE @language_id int;
    SET @language_id = (SELECT ISNULL(MAX(language_id), 0) + 1 FROM Language);
    INSERT INTO Language (language_id, name)
    VALUES (@language_id, @name);
END;
GO

-- Create procedure to update an existing language
CREATE PROCEDURE sp_UpdateLanguage
    @language_id int,
    @name varchar(50)
AS
BEGIN
    UPDATE Language
    SET name = @name
    WHERE language_id = @language_id;
END;
GO

-- Create procedure to delete a language
CREATE PROCEDURE sp_DeleteLanguage
    @language_id int
AS
BEGIN
    DELETE FROM Language
    WHERE language_id = @language_id;
END;
GO

-- for country table

-- Create procedure to insert a new country
CREATE PROCEDURE sp_InsertCountry
    @country_name varchar(255)
AS
BEGIN
    DECLARE @country_id int;
    SET @country_id = (SELECT ISNULL(MAX(country_id), 0) + 1 FROM Country);
    INSERT INTO Country (country_id, country_name)
    VALUES (@country_id, @country_name);
END;
GO

-- Create procedure to update an existing country
CREATE PROCEDURE sp_UpdateCountry
    @country_id int,
    @country_name varchar(255)
AS
BEGIN
    UPDATE Country
    SET country_name = @country_name
    WHERE country_id = @country_id;
END;
GO

-- Create procedure to delete a country
CREATE PROCEDURE sp_DeleteCountry
    @country_id int
AS
BEGIN
    DELETE FROM Country
    WHERE country_id = @country_id;
END;
GO

-- for city table

-- Create procedure to insert a new city
CREATE PROCEDURE sp_InsertCity
    @city_name varchar(255),
    @country_id int
AS
BEGIN
    DECLARE @city_id int;
    SET @city_id = (SELECT ISNULL(MAX(city_id), 0) + 1 FROM City);
    INSERT INTO City (city_id, city_name, country_id)
    VALUES (@city_id, @city_name, @country_id);
END;
GO

-- Create procedure to update an existing city
CREATE PROCEDURE sp_UpdateCity
    @city_id int,
    @city_name varchar(255),
    @country_id int
AS
BEGIN
    UPDATE City
    SET city_name = @city_name,
        country_id = @country_id
    WHERE city_id = @city_id;
END;
GO

-- Create procedure to delete a city
CREATE PROCEDURE sp_DeleteCity
    @city_id int
AS
BEGIN
    DELETE FROM City
    WHERE city_id = @city_id;
END;
GO


-- for film table

-- Create procedure to insert a new film
CREATE PROCEDURE sp_InsertFilm
    @title varchar(255),
    @description text,
    @release_year int,
    @language_id int,
    @rental_duration int,
    @rental_rate float,
    @replacement_cost float,
    @rating varchar(50)
AS
BEGIN
    DECLARE @film_id int;
    SET @film_id = (SELECT ISNULL(MAX(film_id), 0) + 1 FROM Film);
    INSERT INTO Film (film_id, title, description, release_year, language_id, rental_duration, rental_rate, replacement_cost, rating)
    VALUES (@film_id, @title, @description, @release_year, @language_id, @rental_duration, @rental_rate, @replacement_cost, @rating);
END;
GO

-- Create procedure to update an existing film
CREATE PROCEDURE sp_UpdateFilm
    @film_id int,
    @title varchar(255),
    @description text,
    @release_year int,
    @language_id int,
    @rental_duration int,
    @rental_rate float,
    @replacement_cost float,
    @rating varchar(50)
AS
BEGIN
    UPDATE Film
    SET title = @title,
        description = @description,
        release_year = @release_year,
        language_id = @language_id,
        rental_duration = @rental_duration,
        rental_rate = @rental_rate,
        replacement_cost = @replacement_cost,
        rating = @rating
    WHERE film_id = @film_id;
END;
GO

-- Create procedure to delete a film
CREATE PROCEDURE sp_DeleteFilm
    @film_id int
AS
BEGIN
    DELETE FROM Film
    WHERE film_id = @film_id;
END;
GO

--for film_category table

-- Create procedure to insert a new film category
CREATE PROCEDURE sp_InsertFilmCategory
    @film_id int,
    @category_id int
AS
BEGIN
    INSERT INTO Film_Category (film_id, category_id)
    VALUES (@film_id, @category_id);
END;
GO

-- Create procedure to update an existing film category
CREATE PROCEDURE sp_UpdateFilmCategory
    @film_id int,
    @category_id int,
    @new_film_id int,
    @new_category_id int
AS
BEGIN
    UPDATE Film_Category
    SET film_id = @new_film_id,
        category_id = @new_category_id
    WHERE film_id = @film_id AND category_id = @category_id;
END;
GO

-- Create procedure to delete a film category
CREATE PROCEDURE sp_DeleteFilmCategory
    @film_id int,
    @category_id int
AS
BEGIN
    DELETE FROM Film_Category
    WHERE film_id = @film_id AND category_id = @category_id;
END;
GO

-- for address table 
-- Create procedure to insert a new address
CREATE PROCEDURE sp_InsertAddress
    @address text,
    @city_id int,
    @postal_code int,
    @phone int
AS
BEGIN
    DECLARE @address_id int;
    SET @address_id = (SELECT ISNULL(MAX(address_id), 0) + 1 FROM Address);
    INSERT INTO Address (address_id, address, city_id, postal_code, phone)
    VALUES (@address_id, @address, @city_id, @postal_code, @phone);
END;
GO

-- Create procedure to update an existing address
CREATE PROCEDURE sp_UpdateAddress
    @address_id int,
    @address text,
    @city_id int,
    @postal_code int,
    @phone int
AS
BEGIN
    UPDATE Address
    SET address = @address,
        city_id = @city_id,
        postal_code = @postal_code,
        phone = @phone
    WHERE address_id = @address_id;
END;
GO

-- Create procedure to delete an address
CREATE PROCEDURE sp_DeleteAddress
    @address_id int
AS
BEGIN
    DELETE FROM Address
    WHERE address_id = @address_id;
END;
GO

-- for inventory table

-- Create procedure to insert a new inventory item
CREATE PROCEDURE sp_InsertInventory
    @film_id int,
    @store_id int
AS
BEGIN
    DECLARE @inventory_id int;
    SET @inventory_id = (SELECT ISNULL(MAX(inventory_id), 0) + 1 FROM Inventory);
    INSERT INTO Inventory (inventory_id, film_id, store_id)
    VALUES (@inventory_id, @film_id, @store_id);
END;
GO

-- Create procedure to update an existing inventory item
CREATE PROCEDURE sp_UpdateInventory
    @inventory_id int,
    @film_id int,
    @store_id int
AS
BEGIN
    UPDATE Inventory
    SET film_id = @film_id,
        store_id = @store_id
    WHERE inventory_id = @inventory_id;
END;
GO

-- Create procedure to delete an inventory item
CREATE PROCEDURE sp_DeleteInventory
    @inventory_id int
AS
BEGIN
    DELETE FROM Inventory
    WHERE inventory_id = @inventory_id;
END;
GO

--for staff table

-- Create procedure to insert a new staff member
CREATE PROCEDURE sp_InsertStaff
    @first_name varchar(100),
    @last_name varchar(100),
    @address_id int,
    @picture varchar(255),
    @email varchar(100),
    @store_id int,
    @active int,
    @username varchar(100),
    @password varchar(100)
AS
BEGIN
    DECLARE @staff_id int;
    SET @staff_id = (SELECT ISNULL(MAX(staff_id), 0) + 1 FROM Staff);
    INSERT INTO Staff (staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, password)
    VALUES (@staff_id, @first_name, @last_name, @address_id, @picture, @email, @store_id, @active, @username, @password);
END;
GO

-- Create procedure to update an existing staff member
CREATE PROCEDURE sp_UpdateStaff
    @staff_id int,
    @first_name varchar(100),
    @last_name varchar(100),
    @address_id int,
    @picture varchar(255),
    @email varchar(100),
    @store_id int,
    @active int,
    @username varchar(100),
    @password varchar(100)
AS
BEGIN
    UPDATE Staff
    SET first_name = @first_name,
        last_name = @last_name,
        address_id = @address_id,
        picture = @picture,
        email = @email,
        store_id = @store_id,
        active = @active,
        username = @username,
        password = @password
    WHERE staff_id = @staff_id;
END;
GO

-- Create procedure to delete a staff member
CREATE PROCEDURE sp_DeleteStaff
    @staff_id int
AS
BEGIN
    DELETE FROM Staff
    WHERE staff_id = @staff_id;
END;
GO


-- for store table
-- Create procedure to insert a new store
CREATE PROCEDURE sp_InsertStore
    @manager_staff_id int,
    @address_id int
AS
BEGIN
    DECLARE @store_id int;
    SET @store_id = (SELECT ISNULL(MAX(store_id), 0) + 1 FROM Store);
    INSERT INTO Store (store_id, manager_staff_id, address_id)
    VALUES (@store_id, @manager_staff_id, @address_id);
END;
GO

-- Create procedure to update an existing store
CREATE PROCEDURE sp_UpdateStore
    @store_id int,
    @manager_staff_id int,
    @address_id int
AS
BEGIN
    UPDATE Store
    SET manager_staff_id = @manager_staff_id,
        address_id = @address_id
    WHERE store_id = @store_id;
END;
GO

-- Create procedure to delete a store
CREATE PROCEDURE sp_DeleteStore
    @store_id int
AS
BEGIN
    DELETE FROM Store
    WHERE store_id = @store_id;
END;
GO

--for customer table

-- Create procedure to insert a new customer
CREATE PROCEDURE sp_InsertCustomer
    @store_id int,
    @first_name varchar(100),
    @last_name varchar(100),
    @email varchar(100),
    @address_id int,
    @active int
AS
BEGIN
    DECLARE @customer_id int;
    SET @customer_id = (SELECT ISNULL(MAX(customer_id), 0) + 1 FROM Customer);
    INSERT INTO Customer (customer_id, store_id, first_name, last_name, email, address_id, active)
    VALUES (@customer_id, @store_id, @first_name, @last_name, @email, @address_id, @active);
END;
GO

-- Create procedure to update an existing customer
CREATE PROCEDURE sp_UpdateCustomer
    @customer_id int,
    @store_id int,
    @first_name varchar(100),
    @last_name varchar(100),
    @email varchar(100),
    @address_id int,
    @active int
AS
BEGIN
    UPDATE Customer
    SET store_id = @store_id,
        first_name = @first_name,
        last_name = @last_name,
        email = @email,
        address_id = @address_id,
        active = @active
    WHERE customer_id = @customer_id;
END;
GO

-- Create procedure to delete a customer
CREATE PROCEDURE sp_DeleteCustomer
    @customer_id int
AS
BEGIN
    DELETE FROM Customer
    WHERE customer_id = @customer_id;
END;
GO

--for rental table
-- Create procedure to insert a new rental
CREATE PROCEDURE sp_InsertRental
    @rental_date date,
    @inventory_id int,
    @customer_id int,
    @return_date date,
    @staff_id int
AS
BEGIN
    DECLARE @rental_id int;
    SET @rental_id = (SELECT ISNULL(MAX(rental_id), 0) + 1 FROM Rental);
    INSERT INTO Rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id)
    VALUES (@rental_id, @rental_date, @inventory_id, @customer_id, @return_date, @staff_id);
END;
GO

-- Create procedure to update an existing rental
CREATE PROCEDURE sp_UpdateRental
    @rental_id int,
    @rental_date date,
    @inventory_id int,
    @customer_id int,
    @return_date date,
    @staff_id int
AS
BEGIN
    UPDATE Rental
    SET rental_date = @rental_date,
        inventory_id = @inventory_id,
        customer_id = @customer_id,
        return_date = @return_date,
        staff_id = @staff_id
    WHERE rental_id = @rental_id;
END;
GO

-- Create procedure to delete a rental
CREATE PROCEDURE sp_DeleteRental
    @rental_id int
AS
BEGIN
    DELETE FROM Rental
    WHERE rental_id = @rental_id;
END;
GO

--for payment table
-- Create procedure to insert a new payment
CREATE PROCEDURE sp_InsertPayment
    @customer_id int,
    @staff_id int,
    @rental_id int,
    @amount float,
    @payment_date date
AS
BEGIN
    DECLARE @payment_id int;
    SET @payment_id = (SELECT ISNULL(MAX(payment_id), 0) + 1 FROM Payment);
    INSERT INTO Payment (payment_id, customer_id, staff_id, rental_id, amount, payment_date)
    VALUES (@payment_id, @customer_id, @staff_id, @rental_id, @amount, @payment_date);
END;
GO

-- Create procedure to update an existing payment
CREATE PROCEDURE sp_UpdatePayment
    @payment_id int,
    @customer_id int,
    @staff_id int,
    @rental_id int,
    @amount float,
    @payment_date date
AS
BEGIN
    UPDATE Payment
    SET customer_id = @customer_id,
        staff_id = @staff_id,
        rental_id = @rental_id,
        amount = @amount,
        payment_date = @payment_date
    WHERE payment_id = @payment_id;
END;
GO

-- Create procedure to delete a payment
CREATE PROCEDURE sp_DeletePayment
    @payment_id int
AS
BEGIN
    DELETE FROM Payment
    WHERE payment_id = @payment_id;
END;
GO

--for film_actor tabl
-- Create procedure to insert a new film-actor relationship
CREATE PROCEDURE sp_InsertFilmActor
    @actor_id int,
    @film_id int
AS
BEGIN
    INSERT INTO Film_Actor (actor_id, film_id)
    VALUES (@actor_id, @film_id);
END;
GO

-- Create procedure to update an existing film-actor relationship
CREATE PROCEDURE sp_UpdateFilmActor
    @actor_id int,
    @film_id int,
    @new_actor_id int,
    @new_film_id int
AS
BEGIN
    UPDATE Film_Actor
    SET actor_id = @new_actor_id,
        film_id = @new_film_id
    WHERE actor_id = @actor_id AND film_id = @film_id;
END;
GO

-- Create procedure to delete a film-actor relationship
CREATE PROCEDURE sp_DeleteFilmActor
    @actor_id int,
    @film_id int
AS
BEGIN
    DELETE FROM Film_Actor
    WHERE actor_id = @actor_id AND film_id = @film_id;
END;
GO







