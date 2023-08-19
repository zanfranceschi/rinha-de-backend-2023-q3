CREATE EXTENSION pg_trgm;
       
CREATE TEXT SEARCH CONFIGURATION BUSCA (COPY = portuguese);
ALTER TEXT SEARCH CONFIGURATION BUSCA ALTER MAPPING FOR hword, hword_part, word WITH portuguese_stem;

CREATE OR REPLACE FUNCTION ARRAY_TO_STRING_IMMUTABLE (
  arr TEXT[],
  sep TEXT
) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
SELECT ARRAY_TO_STRING(arr, sep) $$;
                                            
CREATE TABLE people
(
    id        UUID PRIMARY KEY,
    nickname  VARCHAR(32) UNIQUE NOT NULL,
    name      VARCHAR(100)       NOT NULL,
    birthdate DATE               NOT NULL,
    stack     VARCHAR(32)[] NULL,
    search TEXT GENERATED ALWAYS AS (
        name || ' ' || nickname || ' ' || COALESCE(ARRAY_TO_STRING_IMMUTABLE(stack, ' '), '')
    ) STORED,
    CONSTRAINT people_unique_nickname UNIQUE (nickname)
);

CREATE INDEX people_id_index ON people (id);
CREATE INDEX people_search_index ON people USING GIST (search gist_trgm_ops);