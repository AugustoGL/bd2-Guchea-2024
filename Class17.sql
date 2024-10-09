--- actividad 1

SELECT address_id, address, postal_code 
FROM address 
WHERE postal_code IN ('12345', '67890');

SELECT a.address_id, a.address, a.postal_code, c.city, ctr.country 
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country ctr ON c.country_id = ctr.country_id
WHERE a.postal_code = '12345';

SET profiling = 1;
SELECT a.address_id, a.address, a.postal_code, c.city, ctr.country 
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country ctr ON c.country_id = ctr.country_id
WHERE a.postal_code = '12345';

CREATE INDEX idx_postal_code ON address (postal_code);

SELECT postal_code FROM address WHERE postal_code IN (SELECT postal_code FROM address WHERE address_id > 500);
SHOW PROFILES;



--- actividad 2

/*
Las diferencias entre las consultas que buscan first_name y last_name en la tabla de actores se basan en la cardinalidad de los datos, la efectividad de los índices y el comportamiento esperado de las consultas. Los duplicados en los nombres pueden afectar la eficiencia de la búsqueda, y la estructura de los índices en las columnas influye en el rendimiento de las consultas. Esto es esencial al diseñar bases de datos y al optimizar consultas para obtener un rendimiento eficiente.
*/



SELECT * FROM film WHERE description LIKE '%keyword%';

/*
- Al utilizar LIKE, puedes obtener más resultados (incluyendo falsos positivos) ya que busca cualquier aparición de la palabra. Por ejemplo, si "keyword" aparece en un contexto menos relevante, aún será parte de los resultados.
- Con MATCH ... AGAINST, los resultados son más específicos y pueden estar mejor clasificados. Esto significa que puedes obtener resultados más útiles y relevantes para tu búsqueda, además de obtener un rendimiento superior en tablas grandes.
*/
