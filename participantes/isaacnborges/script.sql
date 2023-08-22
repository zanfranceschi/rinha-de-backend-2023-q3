CREATE EXTENSION pg_trgm;

CREATE TEXT SEARCH CONFIGURATION BUSCA (COPY = portuguese);
ALTER TEXT SEARCH CONFIGURATION BUSCA ALTER MAPPING FOR hword, hword_part, word WITH portuguese_stem;

CREATE OR REPLACE FUNCTION ARRAY_TO_STRING_IMMUTABLE (
  arr TEXT[],
  sep TEXT
) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
SELECT ARRAY_TO_STRING(arr, sep) $$;

CREATE TABLE IF NOT EXISTS Pessoas
(
    id UUID PRIMARY KEY,
    apelido VARCHAR(32) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    nascimento DATE NOT NULL,
    stack VARCHAR(32)[] NULL,
    search TEXT GENERATED ALWAYS AS (
        nome || ' ' || apelido || ' ' || COALESCE(ARRAY_TO_STRING_IMMUTABLE(stack, ' '), '')
    ) STORED
);

CREATE INDEX pessoas_id_index ON pessoas (id);
CREATE INDEX pessoas_apelido_index ON PESSOAS (apelido);
CREATE INDEX pessoas_search_index ON pessoas USING GIST (search gist_trgm_ops);