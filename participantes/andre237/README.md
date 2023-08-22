# Java e Quarkus + GraalVM

 - Github: [@andre237](https://github.com/andre237)
 - Repositório: https://github.com/andre237/rinha-backend-2023-java

## Stack

 - Java
 - Quarkus
 - Eclipse VertX
 - PostgreSQL
 - Ngnix

## Arquitetura

 - Save síncrono, com trigger no BD para disparar notificação que atualiza cache em memória
 - Consulta por ID busca na cache ou no no BD
 - Consulta por texto usa tipo ts_vector do Postgres para full text search
 - 100% reativo com Quarkus, VertX e Mutiny
