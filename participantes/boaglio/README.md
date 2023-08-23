
# rinha-backend-2023-q3-java

Backend pra rinha backend 2023 q3 - [https://github.com/boaglio/rinha-backend-2023-q3-java](https://github.com/boaglio/rinha-backend-2023-q3-java)

Projeto fork de   [https://github.com/hugomarques/rinha-backend-2023-q3-java](https://github.com/hugomarques/rinha-backend-2023-q3-java)

## Implementação

A adaptação feita foi:

- trocar o PostgreSQL por MongoDB Reactive
- trocar o Spring MVC pelo  Spring WebFlux
- utilizar o Full Text Search do MongoDB na classe domain (@TextIndexed cria o índice automaticamente)

## Imagem publicada

docker pull boaglio/rinhabackend2023:latest

## Execução com a imagem publicada

Dentro do diretório infra:

```bash
docker compose rm -f
docker compose down
docker compose up --build --force-recreate
```

