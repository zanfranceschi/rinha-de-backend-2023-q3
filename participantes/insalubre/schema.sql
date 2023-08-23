CREATE TABLE IF NOT EXISTS "People"
(
    id UUID PRIMARY KEY,
    nickname VARCHAR(32) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    birthdate DATE NOT NULL,
    stack TEXT NULL,
    search TEXT
);

CREATE INDEX people_id_index ON People (id);
CREATE INDEX people_nickname_index ON People (nickname);
