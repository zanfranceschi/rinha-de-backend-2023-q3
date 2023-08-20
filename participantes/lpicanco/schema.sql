\c dogfight

CREATE TABLE pessoas
(
    id         uuid PRIMARY KEY,
    apelido    VARCHAR(32)  NOT NULL,
    nome       VARCHAR(100) NOT NULL,
    nascimento DATE  NOT NULL,
    stack      VARCHAR(32)[],
    search_vector text
);

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_search_vector_pessoas ON pessoas USING gin (search_vector gin_trgm_ops);

