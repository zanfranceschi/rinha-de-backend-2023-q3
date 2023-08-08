CREATE TABLE public.pessoas (
	id UUID PRIMARY KEY,
	apelido VARCHAR(32) UNIQUE NOT NULL,
	nome VARCHAR(100) NOT NULL,
	nascimento DATE NOT NULL,
	stack JSONB NULL,
	busca VARCHAR NOT NULL
);

CREATE INDEX pessoas_busca_idx ON public.pessoas (busca);
