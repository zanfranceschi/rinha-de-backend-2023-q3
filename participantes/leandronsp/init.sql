-- Create table people
CREATE TABLE IF NOT EXISTS people (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    nickname VARCHAR(32) UNIQUE NOT NULL,
    birth_date DATE NOT NULL,
    stack VARCHAR(32)[]
);

-- Create extensions
CREATE EXTENSION unaccent;

-- Create function array to string immutable
CREATE OR REPLACE FUNCTION array_ts(arr TEXT[])
RETURNS TEXT IMMUTABLE LANGUAGE SQL AS $$
SELECT array_to_string(arr, ' ') $$;

-- Configure text search
ALTER TEXT SEARCH DICTIONARY unaccent (RULES = 'unaccent');
CREATE TEXT SEARCH CONFIGURATION pt_en_unaccent (COPY = portuguese);

ALTER TEXT SEARCH CONFIGURATION pt_en_unaccent 
ALTER MAPPING FOR hword, hword_part, word 
WITH unaccent, portuguese_stem, english_stem;

CREATE INDEX people_search_idx 
ON people 
USING GIN 
(to_tsvector('pt_en_unaccent', array_ts(stack || ARRAY[name, nickname])));
