CREATE TABLE IF NOT EXISTS pessoas (
    id uuid PRIMARY KEY,
    apelido varchar(32) NOT NULL UNIQUE,
    nome varchar(100) NOT NULL,
    nascimento date,
    stacks text,
    search text GENERATED ALWAYS AS (LOWER(nome) || LOWER(apelido) || LOWER(stacks)) STORED
);

CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA pg_catalog;

CREATE INDEX idx_pessoas_apelido_trg ON "pessoas" USING gin("search" gin_trgm_ops);