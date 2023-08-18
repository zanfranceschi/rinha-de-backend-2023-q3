CREATE TEXT SEARCH CONFIGURATION busca (COPY = portuguese);
ALTER TEXT SEARCH CONFIGURATION busca ALTER MAPPING FOR hword, hword_part, word WITH portuguese_stem;

CREATE TABLE IF NOT EXISTS Pessoas (
    id VARCHAR(36),
    apelido VARCHAR(32) CONSTRAINT ID_PK PRIMARY KEY,
    nome VARCHAR(100),
    nascimento CHAR(10),
    stack VARCHAR(1024),
    busca TSVECTOR GENERATED ALWAYS AS (
        TO_TSVECTOR('busca', nome || ' ' || apelido || ' ' || stack)
    ) STORED
);

CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_pessoas_id ON Pessoas USING HASH (id);
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_pessoas_busca ON Pessoas USING GIN (busca);