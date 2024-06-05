\c words_db;
INSERT INTO
    words (name)
Values
    ('apple'),
    ('banana'),
    ('cherry'),
    ('date'),
    ('elderberry'),
    ('fig'),
    ('grape'),
    ('honeydew'),
    ('kiwi'),
    ('lemon'),
    ('mango'),
    ('nectarine'),
    ('orange'),
    ('pear'),
    ('quince'),
    ('raspberry'),
    ('strawberry'),
    ('tangerine'),
    ('ugli'),
    ('vanilla'),
    ('watermelon'),
    ('ximenia'),
    ('yuzu'),
    ('zucchini');

INSERT INTO tags (name, description) Values
    ('Fruit', 'A category of sweet or sour edible products, usually consumed raw or in desserts'),
    ('Vegetable', 'A category of edible plants or parts of plants, usually consumed cooked or raw in savory dishes');

INSERT INTO word_tags (word_id, tag_id) Values
    (1, 3),
    (2, 4);