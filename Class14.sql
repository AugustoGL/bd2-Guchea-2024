USE sakila;

SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Customer',
        CONCAT(a.address, ', ', a.district) AS 'Address',
        CONCAT(ci.city, ', ', co.country) AS 'City'
FROM customer c
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country co USING (country_id)
WHERE co.country = 'Argentina';




SELECT f.title AS 'Title',
        l.name AS 'Language',
        CASE f.rating
            WHEN 'G' THEN 'G (General Audiences) – All ages admitted.'
            WHEN 'PG' THEN 'PG (Parental Guidance Suggested) – Some material may not be suitable for children.'
            WHEN 'PG-13' THEN 'PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13.'
            WHEN 'R' THEN 'R (Restricted) – Under 17 requires accompanying parent or adult guardian.'
            WHEN 'NC-17' THEN 'NC-17 (Adults Only) – No one 17 and under admitted.'
        END AS 'Rating'
FROM film f
JOIN language l USING (language_id);




SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Actor',
        GROUP_CONCAT(' ', f.title, ' ', f.release_year) AS 'Movies'
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film f USING (film_id)
WHERE CONCAT(a.first_name, ' ', a.last_name) LIKE '%%'
GROUP BY a.actor_id;




SELECT f.title AS 'Title',
        CONCAT(c.first_name, ' ', c.last_name) AS 'Customer',
        IF(r.return_date IS NOT NULL, 'Yes', 'No') AS 'Returned'
FROM rental r
JOIN inventory i USING (inventory_id)
JOIN customer c USING (customer_id)
JOIN film f USING (film_id)
WHERE MONTH(r.rental_date) IN (5, 6);




SELECT CAST(rental_date AS DATE) AS 'Date from CAST' FROM rental;
SELECT CONVERT(rental_date, DATE) AS 'Date from CONVERT' FROM rental;




SELECT address AS 'Address', 
        IFNULL(address2, 'No secondary address') 
FROM address;

SELECT address AS 'Address', 
        ISNULL(address2) AS 'Is Address2 NULL?' 
FROM address;

SELECT COALESCE(address2, address) AS 'Effective Address' 
FROM address;

SELECT NULLIF(c.first_name, s.first_name) AS 'Customer Name'
FROM rental r
JOIN customer c USING (customer_id)
JOIN staff s USING (staff_id);
