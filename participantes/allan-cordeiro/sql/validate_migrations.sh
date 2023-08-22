#!/bin/sh

# Aguarde até que o serviço de banco de dados esteja pronto
until pg_isready -h db -p 5432 -U rinha
do
  echo "Waiting for postgres at: $pg_uri"
  sleep 1;
done
PGPASSWORD=rinha123 psql -h db -d rinhadb -U rinha -f migrations/create_table.sql

echo "db migration completed"

