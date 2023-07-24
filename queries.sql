/*Queries that provide answers to the questions from all projects.*/
-- 1. Find all animals whose name ends in "mon":
SELECT * FROM animals WHERE name LIKE '%mon'

-- 2. List the name of all animals born between 2016 and 2019:

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- 3. List the name of all animals that are neutered and have less than 3 escape attempts:
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- 4. List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- 5 List name and escape attempts of animals that weigh more than 10.5kg:
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- 6 Find all animals that are neutered:
SELECT * FROM animals WHERE neutered = true;

-- 7 Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';
-- 8 Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- QUERY AND UPDATE PROJECT

-- 1. Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
UPDATE animals SET species= 'Unspecified'
-- 2.Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species ='digimon' WHERE name LIKE '%mon'


-- 3.Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species ='pokemon' WHERE species = 'Unspecified';

-- 4.  delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- 5. Inside a transaction:
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

-- 6. How many animals are there?
SELECT COUNT(*) FROM animals

-- 7. How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0

-- 8 What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals

-- 9 Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered;

-- 10.What is the minimum and maximum weight of each type of animal?
SELECT species,
      MIN(weight_kg) AS min_weight,
      MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- 11. What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
      AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;



-- QUERIES AND MULTI TABLE

-- Write queries (using JOIN) to answer the following questions:
-- 1. What animals belong to Melody Pond?
SELECT name
  FROM animals
  JOIN owners
  ON animals.owner_id = owners.id
  WHERE owners.full_name ='Melody Pond'

  -- 2 List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
  FROM animals
  JOIN species
  ON animals.species_id = species.id
  WHERE species.name ='Pokemon'

-- 3 List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name AS owner_name, STRING_AGG(a.name, ', ') AS animal_names
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name;

-- 4 How many animals are there per species?
SELECT species.name, COUNT(*) AS animals_number
FROM species JOIN animals ON animals.species_id = species.id
GROUP BY species.name

-- 5 List all Digimon owned by Jennifer Orwell.
SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- 6 List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name AS animal_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.ascape_attempts = 0;

--7 Who owns the most animals?

SELECT o.full_name AS owner_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;



-- JOIN TABLE FOR THE VISIT
-- 1. Who was the last animal seen by William Tatcher?
SELECT a.name
  AS last_animal_seen_by_william_tatcher
  FROM animals a
  JOIN visits v
  ON a.id = v.animal_id
  JOIN vets vt
  ON v.vet_id = vt.id
  WHERE vt.name = 'William Tatcher'
  ORDER BY v.visit_date DESC
  LIMIT 1;

-- 2 How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT a.id)
AS num_different_animals_seen_by_stephanie_mendez
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

-- 3. List all vets and their specialties, including vets with no specialties.

SELECT vt.name AS vet_name, s.name AS specialty
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

-- 4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- 5. What animal has the most visits to vets?
SELECT a.name AS most_visited_animal, COUNT(v.vet_id) AS num_visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.id
ORDER BY COUNT(v.vet_id) DESC
LIMIT 1;

-- 6. Who was Maisy Smith's first visit?
SELECT a.name AS first_visit_animal, v.visit_date AS first_visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

-- 7 Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date AS recent_visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- 8 How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits_without_specialty
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

-- 9 What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT s.name AS recommended_specialty
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
JOIN species s ON a.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;
