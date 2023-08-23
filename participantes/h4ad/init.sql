CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE pessoa (
	id uuid NOT NULL DEFAULT uuid_generate_v4(),
	nome varchar(100) NOT NULL,
	apelido varchar(32) NOT NULL,
	nascimento varchar(10) NOT NULL,
	stack _text NULL,
	CONSTRAINT pessoa_pkey PRIMARY KEY (id)
);

CREATE UNIQUE INDEX idx_pessoa_apelido ON public.pessoa USING btree (apelido);