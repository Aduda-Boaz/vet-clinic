/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* UPDATE AND QUERY ANIMALS TABLE */

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokkemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
 count
-------
    10
(1 row)

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
 count
-------
     2
(1 row)

SELECT AVG(weight_kg) AS average FROM animals;
       average
---------------------
 15.5500000000000000
(1 row)

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
 neutered | sum
----------+-----
 f        |   4
 t        |  20
(2 rows)

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
 species | min | max
---------+-----+-----
 pokemon |  11 |  17
 digimon | 5.7 |  45
(2 rows)

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
 species |        avg
---------+--------------------
 pokemon | 3.0000000000000000
(1 row)

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
 species |        avg
---------+--------------------
 pokemon | 3.0000000000000000
(1 row)
