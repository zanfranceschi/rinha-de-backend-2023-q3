CREATE EXTENSION pg_trgm;

CREATE OR REPLACE FUNCTION ARRAY_TO_STRING_IMMUTABLE (
  arr TEXT[],
  sep TEXT
) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
SELECT ARRAY_TO_STRING(arr, sep) $$;

CREATE TABLE people (
  id UUID PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  nick VARCHAR(32) NOT NULL,
  birth_date DATE NOT NULL,
  stack VARCHAR(32)[],
  search TEXT GENERATED ALWAYS AS (
    name || ' ' || nick || ' ' || COALESCE(ARRAY_TO_STRING_IMMUTABLE(stack, ' '), '')
  ) STORED,
  CONSTRAINT unique_nick UNIQUE (nick)
);

CREATE INDEX people_search_index ON people USING GIST (search gist_trgm_ops);

CREATE OR REPLACE FUNCTION notify_person_created() RETURNS TRIGGER as $notify_person_created$
BEGIN
  IF (TG_OP = 'INSERT') THEN
    PERFORM PG_NOTIFY(
      'person_created',
      JSON_BUILD_OBJECT(
        'id', NEW.id,
        'nome', NEW.name,
        'apelido', NEW.nick,
        'nascimento', NEW.birth_date,
        'stack', ARRAY_TO_JSON(NEW.stack::VARCHAR(32)[])
      )::TEXT
    );
  END IF;
  RETURN NEW;
END;
$notify_person_created$ LANGUAGE plpgsql;

CREATE TRIGGER notify_person_created AFTER INSERT ON people FOR EACH ROW EXECUTE PROCEDURE notify_person_created();
