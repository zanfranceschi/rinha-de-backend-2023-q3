# Rinha de Backend - Edição 2023 Q3

> Baseda nesse tuíte: https://twitter.com/zanfranceschi/status/1685083383397765120

A ideia é fazer um torneio de APIs que passariam por um teste de stress. A API que aguentar mais, ganha :)

## Instruções

Sua API deverá ter os seguintes endpoints.

**POST /pessoas**

Deverá criar um registro de "pessoa" com o seguinte payload no formato JSON:
```json
{
    "apelido" : "[atributo obrigatório e único, string de até 32 caracteres – letras maiúsculas/minúsculas, números, símbolos, qq coisa]",
    "nome" : "[atributo obrigatório, string de até 75 caracteres – apenas letras maiúsculas/minúsculas e espaços]",
    "data_nascimento" : "[atributo obrigatório, string para data no formato AAAA-MM-DD]",
    "stack" : "[atributo opcional, array de string de até 10 caracteres de qq coisa para cada elemento]"
}
```
- A resposta duma requisição bem sucedida deverá ter o status code 201, um header `Location: /pessoas/[:id]` com a URL do novo recurso criado onde `/pessoas/[:id]` é a URL do novo recurso criado. Para o corpo, não há especificação – retorne o que quiser.

- Para o caso de requisições inválidas (atributos obrigatórios não preenchidos, formato de data inválido, e/ou limites de caracteres excedidos, etc), a resposta deverá retornar um status code 422. Para o corpo, não há especificação – retorne o que quiser.


**GET /pessoas/[:id]**

Deverá retornar um recurso criado através da requisição **POST /pessoas** mencionada anteriormente. Caso o recurso não exista, a resposta deverá retornar um status code 404. Para requisições bem sucedidas, um payload como a seguir deverá ser retornado:
```json
{
    "id": [depende da sua escolha de modelagem (número, string)],
    "apelido" : [string],
    "nome" : [string],
    "data_nascimento" : [string no formato AAAA-MM-DD],
    "stack" : ["lista", "da", "stack", "cadastrada", "ou", null, "(stack: null)", "para", "o", "caso", "da stack não", "ter sido informada"]
}
```


**GET /pessoas**

Deverá retornar o resultado da busca por recursos cadastrados em **POST /pessoas** e exigir o string parameter `q` e aceitar o parâmetro opcinal `pagina` (`/pessoas?q=[termo da busca]&pagina=[número da página]`) – quando `pagina` não for informado, considerar o valor como `0`. Para requisições bem sucedidas, o status code deverá ser 200 com um payload como a seguir:
```json
{
    "qtd": [número de registros encontrados com o termo da busca],
    "pagina": [número da página da busca – sim, o resultado precisa ser paginado de 10 em 10 registros],
    "anterior": [url da página anterior se houver, caso contrário null],
    "proxima": [url da próxima página se houver, caso contrário null],
    "resultados": [uma lista contendo os recursos encontrados (como na resposta de GET /pessoas/[:id])]
}
```

Se a busca não retornar resultados, o payload deve ser como o seguinte ainda com o status code 200:
```json
{
    "qtd": 0,
    "pagina": 0,
    "anterior": null,
    "proxima": null,
    "resultados": []
}
```
O termo `q` para busca deve considerar os atributos `nome`, `apelido`, e os elementos de `stack`. Pode diferenciar letras maiúsculas e minúsculas (a decisão é sua). A busca pode ser no estilo "contains" – ou seja, se houver um recurso de nome "Ana Barbosa", este deverá ser retornado para uma busca por apenas "Barbosa". 


## Inscrições

Faça um pull request incluindo sua intenção de participar pra eu ter uma noção de quantas pessoas participariam, por favor.

Se preferir, preenche [esse formulário](https://docs.google.com/forms/d/e/1FAIpQLSevmaqfjh9r9K0f9l-MD-cNcM6Te4P4HnIvhM0-9WNxz5pwhg/viewform) aqui do Google em vez de fazer um PR.

| @ do Twitter | Anos de XP | Stack |
| --- | --- | --- |
| [@coproduto](https://twitter.com/coproduto) | 12 | Elixir, Rust, Zig, Julia |
| [@lffgz](https://twitter.com/lffgz) | 2 | Rust |
| [@menta01001](https://twitter.com/Menta01001) | 2 | C# |
| [@v_hadara](https://twitter.com/v_hadara) | 11 | Golang, Node.JS, Python |
| [@minha_logica](https://twitter.com/minha_logica) | 5 | Python, Java, PHP |
| [@lliw_r](https://twitter.com/lliw_r) | 2 | Python, Node.JS, Java |

