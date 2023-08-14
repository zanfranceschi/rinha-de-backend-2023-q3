CREATE EXTENSION IF NOT EXISTS "unaccent";

CREATE EXTENSION IF NOT EXISTS "pg_trgm";

DROP TEXT SEARCH CONFIGURATION IF EXISTS public.people_terms CASCADE;

CREATE TEXT SEARCH CONFIGURATION public.people_terms (COPY = pg_catalog.portuguese);

ALTER TEXT SEARCH CONFIGURATION public.people_terms ALTER MAPPING FOR asciiword,
asciihword,
hword_asciipart,
word,
hword,
hword_part
WITH
    unaccent,
    portuguese_stem;

CREATE TABLE
    IF NOT EXISTS public.people (
        id uuid PRIMARY KEY NOT NULL,
        nickname varchar(32) NOT NULL,
        "name" varchar(100) NOT NULL,
        birthdate date NULL,
        stack text NULL,
        CONSTRAINT people_nickname_key UNIQUE (nickname)
    );

ALTER TABLE public.people
ADD
    COLUMN fts_q tsvector GENERATED ALWAYS AS (
        to_tsvector(
            'people_terms',
            nickname || ' ' || "name" || ' ' || stack
        )
    ) STORED;

CREATE INDEX
    CONCURRENTLY people_fts_q_idx ON public.people USING gin (fts_q);

ALTER TABLE public.people
ADD
    COLUMN trgm_q text GENERATED ALWAYS AS (
        nickname || ' ' || "name" || ' ' || stack
    ) STORED;

CREATE INDEX
    CONCURRENTLY idx_people_trigram ON public.people USING gist (trgm_q gist_trgm_ops);