/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(100) NOT NULL,
    date_of_birth   DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered        BOOLEAN NOT NULL,
    weight_kg       DECIMAL,
    PRIMARY KEY (id)
);

/* ADD species COLUMN of a string */
ALTER TABLE animals ADD COLUMN species VARCHAR(100);
