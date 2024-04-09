SELECT title, special_features FROM film WHERE rating = 'PG-13';

SELECT title, length  FROM film;

SELECT title, rental_rate, replacement_cost FROM film
WHERE replacement_cost BETWEEN 20.00 AND 24.00;

SELECT film.title, category.name AS nombre_categoria, film.rating FROM film 
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE special_features LIKE '%Behind the Scenes%';

SELECT a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'ZOOLANDER FICTION';

SELECT address, city, country
FROM store
WHERE store_id = 1;

SELECT f1.title, f2.title, f1.rating
FROM film f1, film f2
WHERE f1.rating = f2.rating AND f1.film_id <> f2.film_id;

SELECT f2.title, f1.title, f1.rating
FROM film f1
INNER JOIN film f2 ON f1.rating = f2.rating AND f1.film_id <> f2.film_id;

SELECT f.title, st.first_name, st.last_name FROM store s
INNER JOIN inventory i ON s.store_id = i.store_id 
INNER JOIN staff st ON st.staff_id = s.manager_staff_id 
INNER JOIN film f ON f.film_id = i.film_id 
WHERE s.store_id = 2
GROUP BY f.title;






