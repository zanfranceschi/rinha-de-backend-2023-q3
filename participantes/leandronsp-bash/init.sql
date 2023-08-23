-- Create extensions
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Create table people
CREATE TABLE IF NOT EXISTS people (
    id VARCHAR(36),
    nickname VARCHAR(32) CONSTRAINT nickname_pk PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    stack VARCHAR(1024),
    search VARCHAR(1160) GENERATED ALWAYS AS (
        LOWER(name) || ' ' || LOWER(nickname) || ' ' || LOWER(stack)
    ) STORED
);

-- Create search index
CREATE INDEX CONCURRENTLY people_search_idx ON people USING GIST (search gist_trgm_ops);
