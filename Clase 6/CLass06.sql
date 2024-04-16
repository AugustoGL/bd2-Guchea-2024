SELECT a.first_name, a.actor_id , b.first_name, b.actor_id, a.last_name
FROM actor a, actor b
WHERE EXISTS(
SELECT * FROM actor b
WHERE a.last_name = b.last_name AND a.actor_id <> b.actor_id
)
ORDER BY last_name, a.first_name, b.first_name;

SELECT * FROM actor
WHERE actor_id NOT IN( SELECT actor_id FROM film_actor );

SELECT c.first_name, c.last_name, count(r.customer_id) as cantidad FROM rental r
INNER JOIN customer c ON c.customer_id=r.customer_id
GROUP BY r.customer_id HAVING 1=count(r.customer_id);

SELECT c.first_name, c.last_name, COUNT(rental_id) AS num_rentals
FROM rental r
INNER JOIN customer c ON r.customer_id = c.customer_id
GROUP BY r.customer_id
HAVING num_rentals > 1;

SELECT a.first_name, a.last_name, f.title FROM film_actor fa
INNER JOIN actor a ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id=fa.film_id
WHERE f.title IN ( "BETRAYED REAR", "CATCH AMISTAD" );

SELECT a.first_name, a.last_name FROM film_actor fa
INNER JOIN actor a ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id=fa.film_id
WHERE f.title LIKE 'BETRAYED REAR'
AND a.actor_id NOT IN ( 
SELECT actor_id FROM film_actor
INNER JOIN film ON film.film_id = film_actor.film_id
WHERE film.title LIKE 'CATCH AMISTAD'
);

SELECT a.first_name, a.last_name FROM film_actor fa
INNER JOIN actor a ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id=fa.film_id
WHERE f.title LIKE 'BETRAYED REAR'
AND a.actor_id IN ( 
SELECT actor_id FROM film_actor
INNER JOIN film ON film.film_id = film_actor.film_id
WHERE film.title LIKE 'CATCH AMISTAD'
);

SELECT a.first_name, a.last_name, f.title FROM film_actor fa
INNER JOIN actor a ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id=fa.film_id
WHERE f.title NOT IN ( "BETRAYED REAR", "CATCH AMISTAD" );


