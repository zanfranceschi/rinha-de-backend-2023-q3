CREATE TABLE IF NOT EXISTS person (
  id uuid NOT NULL PRIMARY KEY,
  apelido VARCHAR (32) NOT NULL UNIQUE,
  nome VARCHAR (100) NOT NULL,
  nascimento DATE NOT NULL,
  stack JSONB,
  searchable VARCHAR
);

CREATE EXTENSION pg_trgm;
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_searchable ON person USING GIN (searchable gin_trgm_ops);