/*Queries that provide answers to the questions from all projects.*/

-- 1. Find all animals whose name ends in "mon":
SELECT * FROM animals WHERE name LIKE '%mon'

-- 2. List the name of all animals born between 2016 and 2019:

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- 3. List the name of all animals that are neutered and have less than 3 escape attempts:
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- 4. List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- 5 Find all animals that are neutered:
SELECT * FROM animals WHERE neutered = true;

-- 6 Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';
-- 7 Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
