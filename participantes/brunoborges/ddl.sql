SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER SCHEMA PUBLIC OWNER TO rinha;

SET default_tablespace = '';

SET default_table_access_method = heap;

DROP TABLE IF EXISTS PUBLIC."PESSOAS";

CREATE TABLE PUBLIC."PESSOAS" (
    "ID" uuid not null,
    "APELIDO" varchar(32) unique not null,
    "NASCIMENTO" varchar(12) not null,
    "NOME" varchar(100) not null,
    "STACK" varchar(255),
    primary key ("ID")
);

CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA pg_catalog; 

CREATE INDEX idx_pessoas_apelido_trgm ON PUBLIC."PESSOAS" USING gin("APELIDO" gin_trgm_ops);
CREATE INDEX idx_pessoas_nome_trgm ON PUBLIC."PESSOAS" USING gin("NOME" gin_trgm_ops);

ALTER TABLE PUBLIC."PESSOAS" OWNER TO rinha;
