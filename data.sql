/* Populate database with sample data. */
-- Insert the provided data into the animals table
INSERT INTO animals (name, date_of_birth, ascape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
    ('Charmander', '2020-02-08', 0, false, -11),
    ('Plantmon', '2021-11-15', 2, true, -5.7),
    ('Squirtle', '1993-04-02', 3, false, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45),
    ('Boarmon', '2005-06-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);


INSERT INTO species (name)
VALUES
    ('Pokemon'),
	('Digimon')

UPDATE animals SET species_id = CASE
WHEN name LIKE '%mon' THEN 2
ELSE 1
END;


UPDATE animals
SET owner_id = CASE
                WHEN name = 'Agumon' THEN 1
                WHEN name IN ('Gabumon', 'Pikachu') THEN 2
                WHEN name IN ('Devimon', 'Plantmon') THEN 3
                WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
                WHEN name IN ('Angemon', 'Boarmon') THEN 5
                ELSE NULL
              END;


INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES
    (1, 1),
    (3, 1),
    (3, 2),
    (4, 2);


INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
    (1, 1, '2020-05-24'), -- Agumon visited William Tatcher on May 24th, 2020
    (1, 3, '2020-07-22'), -- Agumon visited Stephanie Mendez on Jul 22th, 2020
    (2, 4, '2021-02-02'), -- Gabumon visited Jack Harkness on Feb 2nd, 2021
    (3, 2, '2020-01-05'), -- Pikachu visited Maisy Smith on Jan 5th, 2020
    (3, 2, '2020-03-08'), -- Pikachu visited Maisy Smith on Mar 8th, 2020
    (3, 2, '2020-05-14'), -- Pikachu visited Maisy Smith on May 14th, 2020
    (4, 3, '2021-05-04'), -- Devimon visited Stephanie Mendez on May 4th, 2021
    (5, 4, '2021-02-24'), -- Charmander visited Jack Harkness on Feb 24th, 2021
    (6, 2, '2019-12-21'), -- Plantmon visited Maisy Smith on Dec 21st, 2019
    (6, 1, '2020-08-10'), -- Plantmon visited William Tatcher on Aug 10th, 2020
    (6, 2, '2021-04-07'), -- Plantmon visited Maisy Smith on Apr 7th, 2021
    (7, 3, '2019-09-29'), -- Squirtle visited Stephanie Mendez on Sep 29th, 2019
    (8, 4, '2020-10-03'), -- Angemon visited Jack Harkness on Oct 3rd, 2020
    (8, 4, '2020-11-04'), -- Angemon visited Jack Harkness on Nov 4th, 2020
    (9, 2, '2019-01-24'), -- Boarmon visited Maisy Smith on Jan 24th, 2019
    (9, 2, '2019-05-15'), -- Boarmon visited Maisy Smith on May 15th, 2019
    (9, 2, '2020-02-27'), -- Boarmon visited Maisy Smith on Feb 27th, 2020
    (9, 2, '2020-08-03'), -- Boarmon visited Maisy Smith on Aug 3rd, 2020
    (10, 3, '2020-05-24'), -- Blossom visited Stephanie Mendez on May 24th, 2020
    (10, 1, '2021-01-11'); -- Blossom visited William Tatcher on Jan 11th, 2021


-- WEEK 2
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';