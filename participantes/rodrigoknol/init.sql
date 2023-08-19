CREATE TABLE IF NOT EXISTS people (
  id uuid NOT NULL UNIQUE,
  apelido VARCHAR (32) NOT NULL UNIQUE,
  nome VARCHAR (100) NOT NULL,
  nascimento DATE NOT NULL,
  stack VARCHAR [],
  CONSTRAINT person_pk PRIMARY KEY(apelido, id)
);