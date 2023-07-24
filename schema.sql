/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50),
	date_of_birth DATE,
	ascape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL(10,2)
)

-- Add the "species" column to the "animals" table
ALTER TABLE animals
ADD COLUMN species VARCHAR(50);


-- QUERY MULTIPLE TABLES

-- Species table

CREATE TABLE species (
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50)
)

-- Owners table

CREATE TABLE owners(
	id SERIAL NOT NULL PRIMARY KEY,
	full_name varchar(50),
	age INT
);

-- DROP COLUMN

ALTER TABLE animals DROP COLUMN species
-- ADD COLUMN species_id integer
ALTER TABLE animals ADD COLUMN species_id INT
-- Make the species_id Foreign key with the constraint
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id)
-- Add COLUMN owner_id on animals
ALTER TABLE animals ADD COLUMN owner_id INT
-- Make the owner_id Foreign key from owner table
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id)
REFERENCES owners(id)



-- JOIN TABLE

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    date_of_graduation DATE
)

CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
)

CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    visit_date DATE,
);


-- Week 2 PAIR PROGRAMMING



-- Depending on your machine speed, it might be enough or not. Check that by running explain analyze SELECT COUNT(*) FROM visits where animal_id = 4: - If you get Execution time: X ms and X >= 1000: that should be enough, you can continue to the project requirements. - If you get Execution time: X ms and X < 1000: please go back to point 3. and repeat until you get a value bigger than 1000ms.
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- The following queries are taking too much time (1 sec = 1000ms can be considered as too much time for database query). Try them on your machine to confirm it:
-- 1. DESCREASING EXECUTION TIME
 EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZESELECT * FROM visits where vet_id = 2;
 EXPLAIN ANALYZESELECT * FROM owners where email = 'owner_18327@mail.com';

-- 1.Run the following query to add an extra column to the owners table
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
-- 2. INDEXING
CREATE INDEX visits_animal_id_asc ON visits(animal_id ASC);
CREATE INDEX visit_vet_id_asc ON visits(vet_id DESC);
CREATE INDEX owner_email_DESC ON owners(email DESC);
