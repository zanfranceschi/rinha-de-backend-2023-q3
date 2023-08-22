CREATE extension pg_trgm;

CREATE TEXT SEARCH CONFIGURATION BUSCA (COPY = portuguese);
ALTER TEXT SEARCH CONFIGURATION BUSCA ALTER MAPPING FOR hword, hword_part, word WITH portuguese_stem;

create table Pessoa (
    apelido varchar(32) not null ,
    nascimento date not null,
    nome varchar(100) not null,
    publicID uuid not null,
    stack VARCHAR(800),
    primary key (publicID),
    BUSCA_TRGM TEXT GENERATED ALWAYS AS (
        NOME || APELIDO || STACK
    ) STORED not null
);

CREATE INDEX CONCURRENTLY IF NOT EXISTS IDX_PESSOAS_BUSCA_TGRM ON PESSOA USING GIST (BUSCA_TRGM GIST_TRGM_OPS) 
INCLUDE(apelido, nascimento, nome, publicID, stack);
