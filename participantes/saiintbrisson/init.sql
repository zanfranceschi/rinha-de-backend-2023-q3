CREATE EXTENSION pg_trgm;
CREATE EXTENSION citext;

CREATE FUNCTION concat_stack(TEXT[]) 
  RETURNS TEXT LANGUAGE sql IMMUTABLE AS $$
    SELECT lower(array_to_string(COALESCE($1, '{}'::VARCHAR(32)[]), ''))
$$;

CREATE TABLE people (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nickname CITEXT UNIQUE NOT NULL,
    birthday DATE NOT NULL,
    stack VARCHAR(32)[],
    search_term TEXT GENERATED ALWAYS AS (lower(name) || lower(nickname) || concat_stack(stack)) STORED
);

CREATE INDEX people_search_term_trigram_index ON people
  USING gin (search_term gin_trgm_ops);
