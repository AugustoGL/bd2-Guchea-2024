SELECT 
    fa.film_id, 
    f.title,
    COUNT(fa.actor_id) AS Actores_en_pelicula
FROM 
    film_actor fa
INNER JOIN 
    film f ON f.film_id = fa.film_id
INNER JOIN
    actor a ON a.actor_id = fa.actor_id
GROUP BY 
    fa.film_id
HAVING 
    Actores_en_pelicula > (SELECT AVG(aux) 
                        FROM (SELECT COUNT(actor_id) AS aux 
                                FROM film_actor 
                                GROUP BY film_id) AS subquery)
ORDER BY fa.film_id;
