CREATE EXTENSION pg_trgm;

create table pessoas (
    apelido varchar(32) primary key not null,
    uid uuid not null,
    nome  varchar(100) not null,
    nascimento date not null,
    stack varchar(32)[] null
);

CREATE index ix_uid on pessoas (uid);

create table pessoas_read (
  apelido varchar(32),
  uid uuid,
  nome  varchar(100),
  nascimento date,
  stack varchar(32)[],
  search_terms text
);


CREATE INDEX ix_search_terms ON pessoas_read USING gist (search_terms gist_trgm_ops);

