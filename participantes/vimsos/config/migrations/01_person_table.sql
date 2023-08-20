CREATE UNLOGGED TABLE IF NOT EXISTS person (
    id uuid PRIMARY KEY,
    handle text UNIQUE NOT NULL,
    payload text NOT NULL,
    search_vector tsvector
);