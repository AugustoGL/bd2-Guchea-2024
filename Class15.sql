CREATE VIEW list_of_customers AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_full_name,
    a.address,
    a.phone,
    ci.city,
    co.country,
    CASE 
        WHEN c.active = 1 THEN 'active'
        ELSE 'inactive'
    END AS status,
    c.store_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


CREATE VIEW film_details AS
SELECT 
    f.film_id,
    f.title,
    f.description,
    c.name AS category,
    p.amount AS price,
    f.length,
    f.rating,
    GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) ORDER BY a.first_name SEPARATOR ', ') AS actors
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id;



CREATE VIEW sales_by_film_category AS
SELECT 
    c.name AS category,
    SUM(p.amount) AS total_rental
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name;



CREATE VIEW actor_information AS
SELECT
    a.actor_id as id,
    a.first_name as first_name,
    a.last_name as last_name,
    COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

CREATE VIEW actor_info AS
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    (SELECT COUNT(fa.film_id) 
    FROM film_actor fa 
    WHERE fa.actor_id = a.actor_id) AS film_count
FROM actor a;

---Las Materialized Views son un tipo de objeto en bases de datos que almacena físicamente el resultado de una 
---consulta en el disco. A diferencia de las vistas estándar, que son tablas virtuales que obtienen datos 
---dinámicamente de las tablas subyacentes cada vez que se acceden, las vistas materializadas se calculan y 
---almacenan previamente para un acceso más rápido.
