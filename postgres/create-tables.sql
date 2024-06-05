CREATE DATABASE words_db;
\c words_db;

CREATE TABLE IF NOT EXISTS words (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS word_tags (
    word_id INT REFERENCES words(id),
    tag_id INT REFERENCES tags(id),
    PRIMARY KEY (word_id, tag_id)
);