ALTER SYSTEM SET max_connections = '512';
ALTER SYSTEM SET shared_buffers = '314MB';
ALTER SYSTEM SET effective_cache_size = '942MB';
ALTER SYSTEM SET maintenance_work_mem = '80384kB';
ALTER SYSTEM SET checkpoint_completion_target = '0.9';
ALTER SYSTEM SET wal_buffers = '9646kB';
ALTER SYSTEM SET default_statistics_target = '100';
ALTER SYSTEM SET random_page_cost = '1.1';
ALTER SYSTEM SET effective_io_concurrency = '200';
ALTER SYSTEM SET work_mem = '314kB';
ALTER SYSTEM SET huge_pages = 'off';
ALTER SYSTEM SET min_wal_size = '1GB';
ALTER SYSTEM SET max_wal_size = '4GB';

CREATE EXTENSION pg_trgm;

CREATE OR REPLACE FUNCTION ARR_TO_STRING (
  arr TEXT[],
  sep TEXT
) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
SELECT ARRAY_TO_STRING(arr, sep) $$;

CREATE TABLE IF NOT EXISTS persons (
    id UUID PRIMARY KEY UNIQUE,
    nickname VARCHAR(32) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    birthdate CHAR(10) NOT NULL,
    stack TEXT[],
    search TEXT GENERATED ALWAYS AS (
        nickname || ' ' || name || ' ' || COALESCE(ARR_TO_STRING(stack, ' '), '')
    ) STORED
);

CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_persons_nickname ON persons USING GIN(nickname gin_trgm_ops);
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_persons_search ON persons USING GIN(search gin_trgm_ops);
