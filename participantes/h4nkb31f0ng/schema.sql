CREATE TABLE
    IF NOT EXISTS public.people (
        id uuid NOT NULL,
        nickname varchar(32) PRIMARY KEY NOT NULL,
        "name" varchar(100) NOT NULL,
        birthdate date NULL,
        stack text NULL
    );