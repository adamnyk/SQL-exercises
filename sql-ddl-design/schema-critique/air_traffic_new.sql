-- May also want to store: 
  -- a table with a map of seats to reuse if they are the same on every flight
  -- types of planes and related seating maps
  -- ticket confirmation code


-- Potential challenges with model / information:
    -- accessing ticket information is longer with subqueries (eg. arrival country)

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE countries
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE cities 
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country_id INTEGER REFERENCES countries ON DELETE CASCADE
);

CREATE TABLE passengers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  address TEXT,
  phone_number TEXT,
  email TEXT

);

CREATE TABLE airlines
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE tickets
(
    id SERIAL PRIMARY KEY,
    passenger_id INTEGER REFERENCES passengers ON DELETE CASCADE,
    seat TEXT NOT NULL,
    departure TIMESTAMP NOT NULL CHECK (departure < arrival),
    arrival TIMESTAMP NOT NULL CHECK (departure < arrival),
    airline_id INTEGER REFERENCES airlines ON DELETE CASCADE,
    from_city_id INTEGER REFERENCES cities ON DELETE CASCADE,
    to_city_id INTEGER REFERENCES cities ON DELETE CASCADE
);

INSERT INTO countries
	(name)
VALUES
 ('United States'),
 ('Japan'),
 ('Greece'),
 ('Chile');

INSERT INTO cities
	(name, country_id)
VALUES
	('Denver', 1),
	('Tokyo', 2),
	('Athens', 3),
	('Santiagao', 4);

INSERT INTO passengers
	(first_name, last_name)
VALUES
	('Adam','P'),
	('Jeff','P'),
	('Caro','C'),
	('Jake','G');

INSERT INTO airlines
	(name)
VALUES
	('Delta'),
	('Japan Airlines'),
	('American Airlines');

INSERT INTO tickets
	(passenger_id, seat, departure, arrival, airline_id, from_city_id, to_city_id)
VALUES
	(1,'12A', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 3),
	(3, '12B', '2018-04-08 12:00:00', '2018-04-08 09:00:00', 1, 1, 3), -- should fail check constraint
	(4, '33B', '2018-04-15 16:50:00',  '2018-04-15 21:00:00', 2, 1, 4);