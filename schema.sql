/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50),
	date_of_birth DATE,
	ascape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL(10,2)
)