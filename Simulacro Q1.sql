SELECT a1.first_name, a1.last_name, a2.last_name, a2.title
FROM (
    SELECT actor.actor_id, actor.first_name, actor.last_name, fa.film_id, film.title
    FROM actor
    INNER JOIN film_actor fa ON actor.actor_id = fa.actor_id
    INNER JOIN film ON fa.film_id = film.film_id
    WHERE actor.first_name LIKE 'A%' 
        OR actor.first_name LIKE 'E%' 
        OR actor.first_name LIKE 'I%' 
        OR actor.first_name LIKE 'O%' 
        OR actor.first_name LIKE 'U%'
        OR actor.first_name LIKE 'a%' 
        OR actor.first_name LIKE 'e%' 
        OR actor.first_name LIKE 'i%' 
        OR actor.first_name LIKE 'o%' 
        OR actor.first_name LIKE 'u%'
) a1
INNER JOIN (
    SELECT actor.actor_id, actor.first_name, actor.last_name, fa.film_id, film.title
    FROM actor
    INNER JOIN film_actor fa ON actor.actor_id = fa.actor_id
    INNER JOIN film ON fa.film_id = film.film_id
    WHERE actor.first_name LIKE 'A%' 
        OR actor.first_name LIKE 'E%' 
        OR actor.first_name LIKE 'I%' 
        OR actor.first_name LIKE 'O%' 
        OR actor.first_name LIKE 'U%'
        OR actor.first_name LIKE 'a%' 
        OR actor.first_name LIKE 'e%' 
        OR actor.first_name LIKE 'i%' 
        OR actor.first_name LIKE 'o%' 
        OR actor.first_name LIKE 'u%'
) a2 ON a1.first_name = a2.first_name AND a1.last_name < a2.last_name
WHERE a1.film_id = a2.film_id
ORDER BY a1.first_name;

