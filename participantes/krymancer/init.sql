ALTER SYSTEM SET max_connections = 4096;
CREATE EXTENSION pg_trgm;

CREATE OR REPLACE FUNCTION ARRAY_TO_STRING_IMMUTABLE (
    arr TEXT[],
    sep TEXT
) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
SELECT ARRAY_TO_STRING(arr, sep) $$;

CREATE TABLE IF NOT EXISTS pessoa (
    id UUID PRIMARY KEY,
    apelido VARCHAR(32) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    nascimento CHAR(10) NOT NULL,
    stack VARCHAR(32)[],
    search TEXT GENERATED ALWAYS AS (
        nome || ' ' || apelido || ' ' || COALESCE(ARRAY_TO_STRING_IMMUTABLE(stack, ' '), '')
    ) STORED,
    CONSTRAINT unique_apelido UNIQUE (apelido)
);

CREATE INDEX pessoa_search_index ON pessoa USING GIST (search gist_trgm_ops);
