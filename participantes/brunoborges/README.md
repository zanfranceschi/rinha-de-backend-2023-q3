# Rinha App com Quarkus

Essa implementação usa o seguinte stack:

- Quarkus 3
- OpenJDK 17
- PostgreSQL (latest)
- Nginx (latest)

## Como o sistema está ajustado

O foco dessa implementação é o método [K.I.S.S](https://www.baeldung.com/cs/kiss-software-design-principle#:~:text=KISS%20stands%20for%20Keep%20It,complexity%20as%20much%20as%20possible.).

Por exemplo, não tem cache (e.g., Redis), e o número de conexões com o banco está configurado para 20 (por instância de API).
Outro ajuste importante foi o heap da JVM para `80%`.

A configuração do PostgreSQL é delicada, e utiliza alguns pontos importantes:

1. max_connections=200

Número máximo de conexões. Com certeza não precisamos mais do que 200. [Mais informações](https://postgresqlco.nf/doc/en/param/max_connections/).

2. shared_buffers=256MB

Aumenta o tamanho do buffer em memória para evitar escrita em disco. O padrão é 128MB. [Mais informações](https://postgresqlco.nf/doc/en/param/shared_buffers/).

3. synchronous_commit=off

Executa inserts mais rápido, retornando a conexão imediatamente para o pool. Com este parâmetro, atingimos "consistência eventual" no sistema. [Mais informações](https://postgresqlco.nf/doc/en/param/synchronous_commit/).

1. fsync=off

Diminui o número de chamadas para o disco. [Mais informações](https://postgresqlco.nf/doc/en/param/fsync/).

1. full_page_writes=off

Desabilita escritas do estado do banco após completar diversas atividades do banco. Por ser um benchmark, não precisamos disso.

## Código fonte

O código está no GitHub, no repositório [brunoborges/rinha-app](https://github.com/brunoborges/rinha-app).

# Autor

Bruno Borges ([@brunoborges](https://twitter.com/brunoborges))
