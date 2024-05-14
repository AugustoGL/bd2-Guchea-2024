SELECT title, rating, `length` FROM film WHERE length =  (SELECT min(`length`) FROM film);

SELECT f1.title, `length`
FROM film f1 
INNER JOIN (
    SELECT MIN(length) AS min_length 
    FROM film
) AS min_lengths 
WHERE f1.length < min_lengths.min_length;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.address,
    MIN(p.amount) AS lowest_payment
FROM
    customer c
JOIN
    address a ON c.address_id = a.address_id
JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    a.address;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.address,
    p.amount AS lowest_payment
FROM
    customer c
JOIN
    address a ON c.address_id = a.address_id
JOIN
    payment p ON c.customer_id = p.customer_id
WHERE
    p.amount <= ALL (
        SELECT
            p2.amount
        FROM
            payment p2
        WHERE
            p2.customer_id = c.customer_id
    );


SELECT
    c.last_name,
    a.address,
    max_payment.amount AS highest_payment,
    min_payment.amount AS lowest_payment
FROM
    customer c
JOIN
    address a ON c.address_id = a.address_id
JOIN
    (SELECT
        customer_id,
        MAX(amount) AS amount
    FROM
        payment
    GROUP BY
        customer_id) max_payment ON c.customer_id = max_payment.customer_id
JOIN
    (SELECT
        customer_id,
        MIN(amount) AS amount
    FROM
        payment
    GROUP BY
        customer_id) min_payment ON c.customer_id = min_payment.customer_id;


