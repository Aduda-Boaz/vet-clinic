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

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT P1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT P1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;


SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* QUERY MULTIPLES */
SELECT full_name as OWNER, name as PET FROM owners INNER JOIN animals ON owners.id = animals.owners_id
WHERE owners.full_name = 'Melody Pond';

SELECT full_name as OWNER, name as PET FROM (SELECT * FROM owners WHERE full_name = 'Melody Pond')
OWN INNER JOIN animals ON OWN.id = animals.owners_id;

SELECT species.name as SPECIES, animals.name as PET FROM species INNER JOIN animals ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT SPECIE.name as SPECIES, animals.name as PET FROM (SELECT * FROM species WHERE name = 'Pokemon')
SPECIE INNER JOIN animals on SPECIE.id = animals.species_id;

SELECT owners.full_name as OWNER, animals.name as PET FROM owners LEFT JOIN animals 
ON owners.id = animals.owners_id ORDER BY owners.id;

SELECT species.name as SPECIE, COUNT(species.name) AS NUM FROM species INNER JOIN animals
ON species.id = animals.species_id GROUP BY species.name;

SELECT ANIMALOWNER.name as PET, species.name as SPECIES, ANIMALOWNER.full_name as OWNER
FROM species INNER JOIN (SELECT * FROM owners INNER JOIN animals ON
  owners.id = animals.owners_id WHERE owners.full_name = 'Jennifer Orwell')
  ANIMALOWNER ON species.id = ANIMALOWNER.species_id WHERE species.name = 'Digimon';

SELECT animals.name as PET, animals.escape_attempts as ESCAPE owners.full_name as OWNER
FROM owners INNER JOIN animals ON owners.id = animals.owners_id WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

SELECT owners.full_name AS OWNER, count(owners.full_name) as PET FROM
animals INNER JOIN owners ON animals.owners_id = owners.id GROUP BY owners.full_name
HAVING COUNT(owners.full_name) = (SELECT MAX(NUMPETS)
  FROM (SELECT COUNT(animals.owners_id) as NUMPETS
  FROM animals GROUP BY animals.owners_id) PETSOWNER
);

/* MANY-TO-MANY QUERY TABLE */

SELECT animals.name AS ANIMAL, visits.date_of_visit, vets.name AS VET FROM animals
INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher' 
  AND visits.date_of_visit = (SELECT MAX(visits.date_of_visit) FROM vets INNER JOIN
  visits ON vets.id = WHERE vets.name = 'William Tatcher'
);

SELECT vets AS VET, COUNT(DISTINCT visits.animals_id) AS NUMANIMALS FROM visits
INNER JOIN vets ON visits.vets_id = vets.id GROUP BY (vets.name) HAVING vets.name = 'Stephenie Mendez';

SELECT vets.name as VET, species.name AS spetializations FROM vets LEFT JOIN specializations ON
vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name AS ANIMAL, COUNT(animals.name) AS VISITS FROM animals INNER JOIN visits 
  ON animals.id = visits.animals_id GROUP BY animals.name HAVING COUNT(animals.name) = (SELECT MAX(NUMVISITS) 
  FROM (SELECT COUNT(visits.animals_id) AS NUMVISITS, visits.animals_id
  FROM visits GROUP BY visits.animal_id) VISITBYANIMALS
);

SELECT animals.name AS ANIMAL, visits.date_of_visit, vets.name AS VET FROM animals INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Maisy Smith' AND visits.date_of_visit = (SELECT MIN(visits.date_of_visit)
FROM vets INNER JOIN visits ON vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith'
);

SELECT animals.name AS ANIMAL, vets.name AS VET, visits.date_of_visit FROM animals INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON visits.vets_id = vets.id WHERE visits.date_of_visit = (SELECT MAX(visits.date_of_visit) FROM visits);

SELECT COUNT(*) FROM (SELECT animals.name, animals.specie_id, visits.vets_id FROM visits INNER JOIN animals ON visits.animals_id = animals.id) A
LEFT JOIN (SELECT vets.name, spetializations.vets_id, spetializations.species_id FROM vets INNER JOIN spetializations ON vets.id = spetializations.vets_id) B
ON A.vets_id = B.vets_id AND A.species_id = B.species_id WHERE B.species_id IS NULL;

SELECT species.name AS ALIKELYSPECIALIZATION FROM (SELECT animals.species_id
FROM(((SELECT * FROM vets WHERE vets.name = 'Maisy Smith') VET INNER JOIN visits ON VET.id = visits.vets_id)
INNER JOIN animals ON visits.animals_id = animals.id) GROUP BY animals.species_id
HAVING COUNT(animals.species_id) = (SELECT MAX(PERSPECIEVISIT) FROM (((SELECT * FROM vets WHERE vets.name = 'Maisy Smith') VET INNER JOIN visits
ON VET.id = visits.vets_id) INNER JOIN animals ON visits.animals_id = animals.id) GROUP BY animals.species_id) VETVISITS)
MOSTSPECIES INNER JOIN species ON MOSTSPECIES.species_id = species.id;
