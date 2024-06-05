\c words_db;

CREATE OR REPLACE FUNCTION refresh_words_by_tag_view()
RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW words_by_tag;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

SELECT refresh_words_by_tag_view();

CREATE TRIGGER words_trigger
AFTER INSERT OR DELETE ON words
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_words_by_tag_view();

CREATE TRIGGER tags_trigger
AFTER INSERT OR DELETE OR UPDATE ON tags
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_words_by_tag_view();

CREATE TRIGGER word_tags_trigger
AFTER INSERT OR DELETE ON word_tags
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_words_by_tag_view();