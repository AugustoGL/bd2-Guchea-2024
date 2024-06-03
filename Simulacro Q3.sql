SELECT s.staff_id, s.store_id, COUNT(p.payment_id), SUM(p.amount), MAX(p.amount), MIN(p.amount),
(SELECT COUNT(*) FROM payment p2
    WHERE p2.staff_id = s.staff_id 
    AND p2.amount = MAX(p.amount)
    AND MONTH(p2.payment_date) = MONTH(CURDATE()))  AS Repeticiones_Venta_Maxima,
(SELECT COUNT(*) FROM payment p3 
    WHERE p3.staff_id = s.staff_id 
    AND p3.amount = MIN(p.amount)
    AND MONTH(p3.payment_date) = MONTH(CURDATE())) AS Repeticiones_Venta_Minima,
    GROUP_CONCAT(f.title, ' ', p.amount) AS 'Pelicula_Monto'
FROM staff s
INNER JOIN payment p ON s.staff_id = p.staff_id
WHERE MONTH(p.payment_date) = MONTH(CURDATE())
GROUP BY s.staff_id, s.store_id;
