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
