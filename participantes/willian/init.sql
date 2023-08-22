CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE IF NOT EXISTS pessoa (
		id uuid PRIMARY KEY,
		apelido varchar(32) UNIQUE NOT NULL,
		nome varchar(100) NOT NULL,
		nascimento date NOT NULL,
		stack text,
		search_p text NOT NULL
	);

CREATE INDEX IF NOT EXISTS index_pessoa_search ON pessoa USING gin (search_p gin_trgm_ops);
