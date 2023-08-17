CREATE TABLE "pessoas"(
    "id" varchar(36) NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    "apelido" varchar(32) NOT NULL,
    "nome" varchar(100) NOT NULL,
    "nascimento" date NOT NULL,
    "stack" text DEFAULT '[]'
);

INSERT INTO pessoas(apelido, nome, nascimento, stack)
    VALUES ('jose', 'Jose da Silva', '1990-01-01', '["java", "python"]');

