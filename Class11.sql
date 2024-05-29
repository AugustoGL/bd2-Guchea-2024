SELECT f.title AS 'Título', i.inventory_id AS 'Inventario' 
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;




SELECT f.title AS 'Título', i.inventory_id AS 'Inventario', r.rental_id AS 'Renta'
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;



SELECT c.first_name AS 'Nombre Cliente', c.last_name AS 'Apellido Cliente', s.store_id AS 'ID Tienda', r.rental_date AS 'Fecha Renta', r.return_date AS 'Fecha Devolución', f.title AS 'Título de Película' 
FROM rental r
INNER JOIN customer c ON r.customer_id = c.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN store s ON c.store_id = s.store_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
ORDER BY s.store_id, c.last_name;



SELECT s.store_id AS 'Tienda', CONCAT(co.country, ', ', ci.city) AS 'Location', CONCAT(stf.first_name, ' ', stf.last_name) AS 'Manager', SUM(p.amount) AS 'Ventas Totales' 
FROM store s
INNER JOIN staff stf ON s.manager_staff_id = stf.staff_id
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
INNER JOIN inventory i ON s.store_id = i.store_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;



SELECT a.actor_id AS 'ID Actor', CONCAT(a.first_name, ' ', a.last_name) AS 'Actor', COUNT(fa.film_id) AS 'Películas Actuadas' 
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) = (SELECT MAX(peliculas_count)
                            FROM (SELECT COUNT(fa2.film_id) AS peliculas_count
                                FROM actor a2
                                INNER JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
                                GROUP BY a2.actor_id) subquery);



