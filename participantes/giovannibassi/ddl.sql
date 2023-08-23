CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "Pessoas" (
    "Id" uuid NOT NULL,
    "Apelido" character varying(32) NOT NULL,
    "Nome" character varying(100) NOT NULL,
    "Nascimento" date NOT NULL,
    "Stack" text[],
    CONSTRAINT "PK_Pessoas" PRIMARY KEY ("Id")
);

CREATE UNIQUE INDEX "IX_Pessoas_Apelido" ON "Pessoas" ("Apelido");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20230823002823_First', '8.0.0-preview.7.23375.4');

COMMIT;

