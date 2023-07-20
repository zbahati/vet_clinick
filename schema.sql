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
