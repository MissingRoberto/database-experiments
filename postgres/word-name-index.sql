\c words_db;

-- insert 1000 words with random names
INSERT INTO words (name) Values
    (SELECT md5(random()::text) FROM generate_series(1, 1000));


-- select * from words where name like 'a%';