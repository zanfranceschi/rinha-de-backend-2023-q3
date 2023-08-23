CREATE EXTENSION IF NOT EXISTS "pg_trgm";

CREATE TABLE IF NOT EXISTS public.pessoas (
    id uuid PRIMARY KEY NOT NULL,
    apelido varchar(32) UNIQUE NOT NULL,
    nome varchar(100) NOT NULL,
    nascimento text NOT NULL,
    stack text NULL,
    search text NOT NULL
);

CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_pessoas_trigram ON public.pessoas USING gist (
    search gist_trgm_ops(siglen = 64)
);