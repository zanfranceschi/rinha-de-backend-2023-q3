CREATE TABLE pessoas (
	id VARCHAR(40) PRIMARY KEY,
	apelido VARCHAR(32) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	nascimento DATE NOT NULL,
	stack TEXT NULL,
	text_searchable TEXT NULL,
	UNIQUE(apelido)
);
