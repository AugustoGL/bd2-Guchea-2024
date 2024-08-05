SELECT DISTINCT FID AS ID, fl.title AS TITULO
FROM film_list fl
INNER JOIN film f ON f.film_id = fl.FID
INNER JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fl.`length` <> ANY(
SELECT DISTINCT `length` FROM film_list
WHERE `length` = (SELECT MAX(`length`) 
FROM film_list)) 
AND fl.`length` <> ANY(
SELECT DISTINCT `length` FROM film_list
WHERE `length` = (SELECT MIN(`length`)
FROM film_list))
AND fa.actor_id NOT IN (11,56,45,34,89)
AND f.replacement_cost <> ANY(
SELECT DISTINCT replacement_cost FROM film 
WHERE replacement_cost = (SELECT MAX(replacement_cost)
FROM film))
ORDER BY FID;



SELECT ci.first_name AS CLIENTE, p1.amount AS Pago_1, p2.amount AS Pago_2
FROM payment p1
INNER JOIN (SELECT customer_id, first_name FROM customer c
            WHERE c.first_name NOT LIKE 'A%' 
            AND c.first_name NOT LIKE 'E%' 
            AND c.first_name NOT LIKE 'I%' 
            AND c.first_name NOT LIKE 'O%' 
            AND c.first_name NOT LIKE 'U%'
            AND c.first_name NOT LIKE 'a%' 
            AND c.first_name NOT LIKE 'e%' 
            AND c.first_name NOT LIKE 'i%' 
            AND c.first_name NOT LIKE 'o%' 
            AND c.first_name NOT LIKE 'u%') ci USING(customer_id)
INNER JOIN payment p2 ON p2.customer_id = p1.customer_id
WHERE p1.amount <> p2.amount AND p1.customer_id = 1
LIMIT 10;




SELECT title FROM film
WHERE `length` > ANY(
SELECT `length` FROM film f
INNER JOIN film_category fc USING(film_id)
INNER JOIN category ca ON ca.category_id = fc.category_id
WHERE ca.category_id =1);


SELECT f.title, COUNT(fa.actor_id) AS Cantidad_actores_en_pelicula,
GROUP_CONCAT(a.first_name) AS Lista_actores
FROM film_actor fa
INNER JOIN film f ON f.film_id = fa.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY fa.film_id
HAVING Cantidad_actores_en_pelicula < (
SELECT AVG(aux) FROM (SELECT COUNT(actor_id) AS aux FROM film_actor 
GROUP BY film_id) AS subquery)
ORDER BY fa.film_id;
