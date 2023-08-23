CREATE EXTENSION pg_trgm;
       
CREATE TEXT SEARCH CONFIGURATION BUSCA (COPY = portuguese);
ALTER TEXT SEARCH CONFIGURATION BUSCA ALTER MAPPING FOR hword, hword_part, word WITH portuguese_stem;

CREATE OR REPLACE FUNCTION ARRAY_PARA_STRING (
  arr TEXT[],
  sep TEXT
) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
SELECT ARRAY_TO_STRING(arr, sep) $$;
    
CREATE TABLE "Pessoas" (
    "Id" uuid NOT NULL PRIMARY KEY,
    "Apelido" text NULL,
    "Nome" text NULL,
    "Nascimento" date NOT NULL,
    "Stack" text NULL,
    "Busca" text GENERATED ALWAYS AS ( "Nome" || ' ' || "Apelido" || ' ' || "Stack" ) STORED 
);

CREATE INDEX PESSOAS_APELIDO_INDEX ON "Pessoas" ("Apelido");
CREATE INDEX PESSOAS_SEARCH_INDEX ON "Pessoas" USING GIST ("Busca" gist_trgm_ops);