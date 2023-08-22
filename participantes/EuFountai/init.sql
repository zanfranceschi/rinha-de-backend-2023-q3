CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE IF NOT EXISTS users (
          id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
          apelido VARCHAR(32) UNIQUE NOT NULL,
          nome VARCHAR(100) NOT NULL,
          nascimento VARCHAR(255) NOT NULL,
          stack VARCHAR(32)[]
        );