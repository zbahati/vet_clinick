/* Populate database with sample data. */
-- Insert the provided data into the animals table
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
    ('Charmander', '2020-02-08', 0, false, -11, 'Unspecified'),
    ('Plantmon', '2021-11-15', 2, true, -5.7, 'Unspecified'),
    ('Squirtle', '1993-04-02', 3, false, -12.13, 'Unspecified'),
    ('Angemon', '2005-06-12', 1, true, -45, 'Unspecified'),
    ('Boarmon', '2005-06-07', 7, true, 20.4, 'Unspecified'),
    ('Blossom', '1998-10-13', 3, true, 17, 'Unspecified'),
    ('Ditto', '2022-05-14', 4, true, 22, 'Unspecified');
