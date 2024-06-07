CREATE DATABASE containers_db;

CREATE TABLE IF NOT EXISTS container (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES container(id)
);


CREATE TYPE attribute_kind AS ENUM ('string', 'boolean');

CREATE TABLE IF NOT EXISTS attribute (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    kind attribute_kind NOT NULL
);

CREATE TABLE IF NOT EXISTS container_attribute (
    container_id INT REFERENCES container(id),
    attribute_id INT REFERENCES attribute(id),
    value VARCHAR(255),
    PRIMARY KEY (container_id, attribute_id)
);