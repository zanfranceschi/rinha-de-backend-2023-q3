CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS users (
 id UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
 username   VARCHAR(32) UNIQUE NOT NULL,
 name       VARCHAR(100) NOT NULL,
 birth_date VARCHAR(255) NOT NULL,
 stack      VARCHAR(255),
 search     VARCHAR(400)
);
