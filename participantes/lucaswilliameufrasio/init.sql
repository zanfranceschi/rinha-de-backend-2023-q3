CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE IF NOT EXISTS people (
        id uuid PRIMARY KEY NOT NULL,
        nickname VARCHAR(32) UNIQUE NOT NULL,
        "name" VARCHAR(100) NOT NULL,
        birth_date DATE NOT NULL,
        stack TEXT NULL
    );

CREATE INDEX CONCURRENTLY IF NOT EXISTS people_search_idx ON people USING GIST(LOWER(name || ' ' || nickname || ' ' || stack) gist_trgm_ops(siglen=128));
