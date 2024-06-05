\c words_db;

CREATE TABLE IF NOT EXISTS archived_words (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE PROCEDURE archive_old_words()
LANGUAGE plpgsql
AS $$ 
BEGIN
    INSERT INTO archived_words (name)
    SELECT name FROM words WHERE created_at < NOW() - INTERVAL '1 minute';
    DELETE FROM word_tags WHERE word_id IN (SELECT id FROM words WHERE created_at < NOW() - INTERVAL '1 minute');
    DELETE FROM words WHERE created_at < NOW() - INTERVAL '1 minute';
END; $$;

CALL archive_old_words();