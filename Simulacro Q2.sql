SELECT film_id,
    COUNT(actor_id) AS Actores_en_pelicula, 
    (SELECT AVG(aux) FROM (SELECT COUNT(actor_id) AS aux FROM film_actor GROUP BY film_id) as nadie_lee_esto) AS Promedio_general
FROM film_actor
GROUP BY film_id
HAVING Actores_en_pelicula > Promedio_general;
