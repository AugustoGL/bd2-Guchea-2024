# 1. Insertar un nuevo empleado con un email nulo
# Esto provocará un error porque la columna `email` tiene la restricción NOT NULL, lo que significa que no puede aceptar valores nulos.

INSERT INTO employees (employeeNumber, lastName, firstName, extension, officeCode, reportsTo, jobTitle, email)
VALUES (1010, 'Gonzalez', 'Maria', 'x4321', 3, 1003, 'HR Manager', NULL);
# Error: Column 'email' cannot be null.

# 2. Actualizar el número de empleado restando 20 a todos los valores
# Este comando resta 20 al número de empleado para todas las filas. Sin embargo, puede causar conflictos si el resultado crea duplicados en la clave primaria.
UPDATE employees SET employeeNumber = employeeNumber - 20;

# 3. Añadir una columna `age` a la tabla `employees` con valores entre 16 y 70 años
# Si ya existen filas que no cumplen con esta restricción, se generará un error.
ALTER TABLE employees 
ADD COLUMN age INT DEFAULT 16, 
ADD CONSTRAINT check_age CHECK (age BETWEEN 16 AND 70);

# 4. Describir la integridad referencial entre las tablas `film`, `actor` y `film_actor` en la base de datos `sakila`
# La integridad referencial se asegura mediante claves foráneas en `film_actor`, que enlazan `film` y `actor`. No se puede eliminar una película o actor sin eliminar primero las entradas correspondientes en `film_actor`.

# 5. Crear una columna `lastUpdate` en la tabla `employees` y usar triggers para mantener la fecha y hora actualizadas
ALTER TABLE employees 
ADD COLUMN lastUpdate DATETIME DEFAULT NOW(),
ADD COLUMN lastUpdateUser VARCHAR(255) DEFAULT CURRENT_USER();

# Crear trigger para actualizar `lastUpdate` y `lastUpdateUser` en operaciones de UPDATE
DELIMITER $$
CREATE TRIGGER before_update_employees
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = CURRENT_USER();
END$$
DELIMITER ;

# Crear trigger para actualizar `lastUpdate` y `lastUpdateUser` en operaciones de INSERT
DELIMITER $$
CREATE TRIGGER before_insert_employees
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = CURRENT_USER();
END$$
DELIMITER ;

# 6. Encontrar y explicar los triggers relacionados con la tabla `film_text` en la base de datos `sakila`

# Trigger para insertar datos en `film_text` cuando se añade una nueva película
DELIMITER $$
CREATE TRIGGER ins_film
AFTER INSERT ON film
FOR EACH ROW
BEGIN
    INSERT INTO film_text (film_id, title, description)
    VALUES (NEW.film_id, NEW.title, NEW.description);
END$$
DELIMITER ;

# Trigger para actualizar `film_text` cuando se actualiza una película
DELIMITER $$
CREATE TRIGGER upd_film
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
    IF (OLD.title != NEW.title) OR (OLD.description != NEW.description)
    THEN
        UPDATE film_text
        SET title = NEW.title,
            description = NEW.description
        WHERE film_id = OLD.film_id;
    END IF;
END$$
DELIMITER ;

# Trigger para eliminar datos de `film_text` cuando se borra una película
DELIMITER $$
CREATE TRIGGER del_film
AFTER DELETE ON film
FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = OLD.film_id;
END$$
DELIMITER ;
