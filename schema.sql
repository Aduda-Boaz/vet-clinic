/* Database schema to keep the structure of entire database. */

CREATE TABLE owners (
    id          INT GENERATED ALWAYS AS IDENTITY,
    full_name   VARCHAR(255) NOT NULL,
    age         INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id     INT GENERATED ALWAYS AS IDENTITY,
    name   VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(100) NOT NULL,
    date_of_birth   DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered        BOOLEAN NOT NULL,
    weight_kg       DECIMAL,
    species_id      INT NOT NULL,
    owners_id       INT NOT null,
    PRIMARY KEY (id)
    CONSTRAINT k_species
        FOREIGN KEY (species_id)
        REFERENCES species (id)
        ON DELETE CASCADE,
    CONSTRAINT k_owners
        FOREIGN KEY (owners_id)
        REFERENCES owners (id)
        ON DELETE CASCADE,
);

CREATE TABLE vets (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(100) NOT NULL,
    age                 INT NOT NULL,
    date_of_graduation  DATE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE spetializations (
    vet_id      INT NOT NULL,
    species_id   INT NOT NULL,
    CONSTRAINT k_vet
        FOREIGN KEY (vet_id)
        REFERENCES vets(id)
        ON DELETE RESTRICT,
    CONSTRAINT k_species
        FOREIGN KEY (species_id)
        REFERENCES species(id)
        ON DELETE RESTRICT
);

CREATE TABLE visits (
    animals_id       INT NOT NULL,
    vet_id          INT NOT NULL,
    date_of_visit   DATE NOT NULL,
    CONSTRAINT k_animals
        FOREIGN KEY (animals_id)
        REFERENCES animals(id)
        ON DELETE RESTRICT,
    CONSTRAINT k_vet
        FOREIGN KEY (vet_id)
        REFERENCES vets(id)
        ON DELETE RESTRICT
);
