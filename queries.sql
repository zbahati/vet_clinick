/*Queries that provide answers to the questions from all projects.*/

-- 1. Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species ='digimon' WHERE name LIKE '%mon'

-- 2. Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals SET species ='pokemon' WHERE species = 'Unspecified';

-- 3. Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT weight_update_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT weight_update_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- 4. How many animals are there?
SELECT COUNT(*) FROM animals

-- 5. How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0

-- 6 What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals

-- 7 Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered;

-- 8.What is the minimum and maximum weight of each type of animal?
SELECT species,
       MIN(weight_kg) AS min_weight,
       MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- 9. What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
       AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;