\c words_db;
CREATE MATERIALIZED VIEW words_by_tag AS
SELECT 
    tags.name AS tag,
    count(*) AS word_count
FROM words
JOIN word_tags ON words.id = word_tags.word_id
JOIN tags ON word_tags.tag_id = tags.id
GROUP BY tags.name
WITH NO DATA;

CREATE FUNCTION refresh_words_by_tag_view()
RETURN VOID AS $$
BEGIN
    REFRESH MATERIALIZED VIEW words_by_tag;
END;
$$ LANGUAGE plpgsql;

SELECT refresh_words_by_tag_view();