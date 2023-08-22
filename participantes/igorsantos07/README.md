# rinha-de-backend
Comparação de backends de API no https://github.com/zanfranceschi/rinha-de-backend-2023-q3/

Source em https://github.com/igorsantos07/rinha-de-backend

## Como executar
Rode `docker-compose up` e acesse em `http://localhost:9999`

## API Explorer
Acesse `http://localhost:9999/explorer`

## Tech envolvida
- Eloquent 10: acesso a banco, com a lib do Laravel
- Phinx: migrations de banco, com a lib originária do CakePHP
- Restler 5: uma lib muito boa mas abandonada e com doc meia-boca para fazer APIs leves com PHP

## TODO
- [ ] a única forma de fazer partial match com a busca textual ainda é usando `LIKE`, mesmo com `tsvector`?
- [ ] cache HTTP
- [ ] cache no Redis
- [ ] otimizar uso de CPU e memória
- [ ] retirar/criticar o footer do explorer???

## Pequenas críticas ao modelo da API
- 400 e 422 pra erros de validação... faz diferença?
- `/contagem-pessoas` deveria ser `/pessoas/contagem`, visto que é uma outra informação do mesmo resource `pessoas`