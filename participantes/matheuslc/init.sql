CREATE TABLE IF NOT EXISTS person(
    uuid UUID PRIMARY KEY,
    name TEXT NOT NULL,
    nickname TEXT NOT NULL,
    birthday TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    stack TEXT,
    
    search TEXT GENERATED ALWAYS AS (
        LOWER(name || nickname || stack)
    ) STORED
);

CREATE EXTENSION pg_trgm;
CREATE INDEX CONCURRENTLY IF NOT EXISTS search_trigam_idx ON person USING GIN (search gin_trgm_ops);

