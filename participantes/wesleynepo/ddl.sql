CREATE TABLE IF NOT EXISTS pessoas (
    id UUID PRIMARY KEY,
    apelido varchar(32) UNIQUE NOT NULL,
    nome varchar(100) NOT NULL,
    nascimento DATE NOT NULL,
    stack text[] NULL
);

CREATE INDEX IF NOT EXISTS pessoas_nome_idx ON pessoas USING GIN (to_tsvector('simple', nome));
CREATE INDEX IF NOT EXISTS pessoas_apelido_idx ON pessoas USING GIN (to_tsvector('simple', apelido));
CREATE INDEX IF NOT EXISTS pessoas_stack_idx ON pessoas USING GIN (stack);
