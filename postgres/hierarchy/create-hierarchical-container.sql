\c containers_db;

INSERT INTO
    container (id, name, parent_id)
Values
    (1, 'root', NULL),
    (2, 'second', 1),
    (3, 'third', 2);