###1
CREATE USER data_analyst@localhost IDENTIFIED BY 'pepe1234';

###2
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

###3
sudo mysql -u data_analyst -ppepe1234

mysql> create table pruebas;
ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'pruebas'


###4

UPDATE film
SET title = 'titulo_clase_19'
WHERE film_id = 1;

Query OK, 1 row affected (0,02 sec)
Rows matched: 1  Changed: 1  Warnings: 0


###5

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';



###6

ERROR 1046 (3D000): No database selected

