DROP DATABASE IF EXISTS imdb;
CREATE DATABASE IF NOT EXISTS imdb;

USE imdb;

CREATE TABLE IF NOT EXISTS film (
  film_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  release_year INT NOT NULL,
  PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS actor (
  actor_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS film_actor (
  actor_id INT NOT NULL,
  film_id INT NOT NULL,
  PRIMARY KEY (actor_id, film_id)
);

ALTER TABLE film ADD COLUMN IF NOT EXISTS last_update DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE actor ADD COLUMN IF NOT EXISTS last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE IF EXISTS film_actor
  ADD FOREIGN KEY IF NOT EXISTS (actor_id) REFERENCES actor(actor_id),
  ADD FOREIGN KEY IF NOT EXISTS (film_id) REFERENCES film(film_id);

INSERT INTO actor (first_name, last_name) VALUES ('Juan', 'Perez'), ('Pedro', 'Juarez'), ('Bob', 'MCarnee');

INSERT INTO film (title, description, release_year) VALUES 
  ('Pelicula 1', 'AAAAAAAAAAAAAAA', 1994),
  ('Pelicula 2 la secuela', 'BBBBBBBB', 2002),
  ('Pelicula 3 final', 'ccccc', 2010);

INSERT INTO film_actor (actor_id, film_id) VALUES 
  (1, 1),
  (2, 2),
  (3, 3);

