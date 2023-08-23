CREATE EXTENSION btree_gin;
create table pessoa
(
    id         uuid primary key,
    apelido    varchar(32) unique not null,
    nascimento varchar(10) not null,
    nome       varchar(100)       not null,
    stack      text              null
);
CREATE INDEX index_termo ON pessoa USING gin(apelido, nome, stack);