SELECT
    c.country_id,
    c.country,
    COUNT(*) AS city_count
FROM
    country c
JOIN
    city ci ON c.country_id = ci.country_id
GROUP BY
    c.country_id,
    c.country
ORDER BY
    c.country,
    c.country_id;


SELECT
    c.country_id,
    c.country,
    COUNT(ci.city_id) AS city_count
FROM
    country c
JOIN
    city ci ON c.country_id = ci.country_id
GROUP BY
    c.country_id,
    c.country
HAVING
    COUNT(ci.city_id) > 10
ORDER BY
    city_count DESC;



SELECT
    c.name AS category,
    AVG(f.length) AS average_duration
FROM
    category c
JOIN
    film_category fc ON c.category_id = fc.category_id
JOIN
    film f ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    average_duration DESC;


SELECT
    f.rating,
    SUM(p.amount) AS total_sales
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY
    f.rating
ORDER BY
    total_sales DESC;
