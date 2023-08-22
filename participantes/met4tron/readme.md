
# Rinha Backend

- NodeJS
- Hyper Express
- PostgreSQL (PostgresJS)
- Esbuild (tsup + tsx)
- Redis (ioredis)

## Instalação

```bash
  npm i
```

## Build

```bash
  npm run build
```


## Docker

```bash
docker build . -t rinha
docker compose up

## Buildkit
docker buildx create --name rinha-nodejs --platform linux/amd64,linux/arm64,linux/arm64/v8
docker buildx build -t met4tron/rinha-nodejs:latest --builder rinha-nodejs --push --platform linux/arm64/v8,linux/amd64,linux/arm64 .
```

## Licença

[MIT](https://choosealicense.com/licenses/mit/)

## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/yuurig)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/async_http)


