CREATE TABLE IF NOT EXISTS people (
			id uuid NOT NULL,
			nickname varchar(32) PRIMARY KEY NOT NULL,
			"name" varchar(100) NOT NULL,
			birthday date NULL,
			stacks text NULL);


ALTER TABLE people ADD COLUMN tssearch tsvector GENERATED ALWAYS AS (pg_catalog.to_tsvector('english', name || ' ' || nickname || ' ' || stacks)) STORED;

CREATE TEXT SEARCH CONFIGURATION people_search(COPY=pg_catalog.english);

CREATE OR REPLACE FUNCTION people_search_tsquery(word text) RETURNS tsquery AS 
$$
BEGIN
  RETURN plainto_tsquery('public.people_search', trim(word));
END
$$ LANGUAGE plpgsql;