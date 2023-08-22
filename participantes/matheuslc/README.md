# Rinha de back-end

Projeto desenvolvido usando PostgreSQL, Golang e nginx.

A escrita é feita de maneira assíncrona em batch. Primeiro escrevemos em um cache em memória por container, e depois colocamos em um channel. Após um período, o batch fecha, e escrevemos no banco de dados usando um batch de INSERT's.

A leitura acontece primeiro no cache. Caso o usuário não seja encontrado no container, retornamos um 404. O nginx vai tratar essa response, e vai procurar no cache do outro container. Se também não houver, então procuramos no banco de dados. Essa estratégia foi utilizada para não haver a necessidade de adicionar mais uma dependência para o cache, como um Redis.

Github: [matheuslc](https://github.com/matheuslc)

Twitter: [caaaaarmel](https://twitter.com/caaaaarmel)

Repositório da rinha: [matheuslc](https://github.com/matheuslc/rinha)