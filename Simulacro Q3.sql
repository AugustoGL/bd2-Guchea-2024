SELECT s.staff_id, s.store_id, COUNT(p.payment_id), SUM(p.amount), MAX(p.amount), MIN(p.amount),
(SELECT COUNT(*) FROM payment p2
    WHERE p2.staff_id = s.staff_id AND p2.amount = MAX(p.amount)) AS Repeticiones_Venta_Maxima,
(SELECT COUNT(*) FROM payment p3 
    WHERE p3.staff_id = s.staff_id AND p3.amount = MIN(p.amount)) AS Repeticiones_Venta_Minima
FROM staff s
INNER JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.store_id;
