
INSERT INTO customer (store_id, first_name, last_name, email, address_id, create_date)
VALUES (
    1,
    'Javier',
    'Lamberto',
    'javilam@gmail.com',
    (SELECT MAX(a.address_id)
        FROM address a
        INNER JOIN city ci ON a.city_id = ci.city_id
        INNER JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = 'United States'),
    NOW()
);

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (
    NOW(),
    (SELECT MAX(i.inventory_id)
        FROM inventory i
        INNER JOIN film f ON i.film_id = f.film_id
        WHERE f.title = 'MODEL FISH'),
    (SELECT customer_id
        FROM customer
        WHERE first_name = 'Javier' AND last_name = 'Lamberto' AND email = 'javilam@gmail.com'),
    DATE_ADD(NOW(), INTERVAL 1 MONTH),
    (SELECT s.staff_id
        FROM staff s
        WHERE s.store_id = 2
        ORDER BY RAND()
        LIMIT 1),
    NOW()
);

UPDATE film SET release_year = 2001 WHERE rating = 'G';
UPDATE film SET release_year = 2005 WHERE rating = 'PG';
UPDATE film SET release_year = 2012 WHERE rating = 'PG-13';
UPDATE film SET release_year = 2017 WHERE rating = 'R';
UPDATE film SET release_year = 2020 WHERE rating = 'NC-17';

UPDATE rental
SET return_date = NOW()
WHERE rental_id = (
    SELECT MAX(r.rental_id)
    FROM rental r
    WHERE r.return_date IS NULL
);

DELETE FROM film_actor WHERE film_id = 1000;
DELETE FROM film_category WHERE film_id = 1000;

DELETE FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1000);
DELETE FROM inventory WHERE film_id = 1000;

DELETE FROM film WHERE film_id = 1000;

SET @inventory_id = (SELECT i.inventory_id
                        FROM inventory i
                        LEFT JOIN rental r ON i.inventory_id = r.inventory_id
                        WHERE r.rental_id IS NULL
                        LIMIT 1);

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (
    NOW(),
    @inventory_id,
    (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1),
    DATE_ADD(NOW(), INTERVAL 1 MONTH),
    (SELECT s.staff_id
        FROM staff s
        WHERE s.store_id = (SELECT store_id FROM inventory WHERE inventory_id = @inventory_id)
        ORDER BY RAND()
        LIMIT 1),
    NOW()
);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date, last_update)
VALUES (
    (SELECT customer_id FROM rental WHERE inventory_id = @inventory_id),
    (SELECT staff_id FROM rental WHERE inventory_id = @inventory_id),
    (SELECT rental_id FROM rental WHERE inventory_id = @inventory_id),
    3.99,
    DATE_ADD(NOW(), INTERVAL 1 DAY),
    NOW()
);

SELECT * FROM rental WHERE inventory_id = @inventory_id;
SELECT * FROM payment WHERE rental_id = (SELECT rental_id FROM rental WHERE inventory_id = @inventory_id);
