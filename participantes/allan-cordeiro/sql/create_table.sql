CREATE SCHEMA IF NOT EXISTS rinha;

CREATE TABLE IF NOT EXISTS rinha.person(
    id VARCHAR(36) NOT NULL,
    nickname VARCHAR(32) NOT NULL,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    stack JSONB,    
    full_search TEXT
);

CREATE EXTENSION pg_trgm;
CREATE INDEX CONCURRENTLY IF NOT EXISTS i_ilikeseach on rinha.person using gist(full_search GIST_TRGM_OPS);
