--Listar todas las películas cuya duración no sea la máxima ni la mínima, y 
--además no deben tener a los actores cuyas id's son las siguientes(11,56,45,34,89) 
SELECT FID, fl.title FROM film_list fl
INNER JOIN film f ON f.film_id = fl.FID
INNER JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fl.`length` <> ANY(SELECT DISTINCT `length` FROM film_list
                            WHERE `length` = (SELECT MAX(`length`) 
                            FROM film_list)) 
AND fl.`length` <> ANY(SELECT DISTINCT `length` FROM film_list
                    WHERE `length` = (SELECT MIN(`length`)
                    FROM film_list))
AND fa.actor_id NOT IN (11,56,45,34,89);


WHERE fl.`length` <> ANY(SELECT DISTINCT `length` FROM film_list
                            WHERE `length` = (SELECT MAX(`length`) 
                            FROM film_list)) 
AND fl.`length` <> ANY(SELECT DISTINCT `length` FROM film_list
                    WHERE `length` = (SELECT MIN(`length`) 
                    FROM film_list)) 
AND fl.film_id NOT IN (11,56,45,34,89);
