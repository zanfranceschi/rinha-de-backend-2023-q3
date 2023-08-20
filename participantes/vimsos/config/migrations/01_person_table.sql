CREATE EXTENSION pg_trgm;

CREATE UNLOGGED TABLE IF NOT EXISTS person (
    id uuid PRIMARY KEY,
    handle text UNIQUE NOT NULL,
    payload text NOT NULL,
    search text NOT NULL
);

CREATE INDEX ON person USING GIST (search gist_trgm_ops);
