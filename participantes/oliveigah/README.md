# Objetivo

A ideia era tentar implementar todos os requisitos usando o menor numero de dependencias possivel.

Sendo assim implementei todos os compomentes usando somente elixir tanto o banco de dados quanto o load balancer.

A persistencia é feita utilizando mnesia um banco de dados built in do erlang com garantias ACID.

O "load balancer" é bem simples utilizando cluster elixir onde cada request HTTP que chega para o server1 é feito o phash e executado em algum nó do cluster.

A parte mais complicada foi a rota de full text search pois tive que implementar meu proprio indice (que obviamente acabou não sendo tão eficiente. haha) mas pelos meus testes deve ser o suficiente.

# Aplicação

https://github.com/oliveigah/rinha_backend

# Stack

- Elixir