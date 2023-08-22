# Fonte do Teste de Stress

Teste feito com a ferramenta gatling.


## Gerando carga de teste

Há duas opções de geradores: um utilizando a biblioteca Faker e outro "customizado" o qual gera strings aleatórias.

### Usando Faker como gerador

```sh
cd testes/stress
./geradores/faker/gerar-pessoas > ./user-files/resources/pessoas-payloads.tsv
./geradores/faker/gerar-termos-busca > ./user-files/resources/termos-busca.tsv
```

### Usando gerador costumizado (strings aleatórias)

```sh
cd testes/stress
./geradores/customizado/gerar-pessoas > ./user-files/resources/pessoas-payloads.tsv
./geradores/customizado/gerar-termos-busca > ./user-files/resources/termos-busca.tsv
```
