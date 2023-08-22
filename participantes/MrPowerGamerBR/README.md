<h1 align="center">🐔 RINHA DE BACKEND 2023 Q3™ em Kotlin 🐔</h1>
 
Uma implementação feita em [Kotlin](https://kotlinlang.org), pois Kotlin is my beloved. <img src="https://cdn.discordapp.com/emojis/841285914159611914.gif" height="24" />

É uma implementação bem básica, feita em menos de 3 horas. Algumas coisas estão faltando, mas tudo funciona. *insira estampa de "funciona na minha máquina" aqui*.

O sistema foi implementado usando Ktor (Web Server), Exposed (para comunicar com o banco de dados usando uma DSL), Nginx (Load Balancer), PostgreSQL (Banco de Dados) e, é claro, Docker (Gerenciador de Containers). Sim, sem cache, pois a gente carrega os dados na marra, direto do banco de dados. Aqui é natty e não fake natty desgraça. 💪

Espero que gostem! Ah, e se você quiser ver o código-fonte, ele [está aqui](https://github.com/MrPowerGamerBR/RinhaDeBackend2023Q3Kotlin)!

(A única coisa que eu "propositalmente" não implementei, foi a parte de retornar Bad Request caso o JSON esteja sinteticamente incorreto, pois infelizmente tentar verificar a diferença entre "o nome é null então isso deve ser um Unprocessable Entity" e verificar "o nome é um número então isso deve ser um Bad Request" é difícil pelo kotlinx.serialization, já que ele acaba retornando a mesma exception independentemente de qual foi o problema na hora de deserializar o JSON)

## 🔗 Redes Sociais
* **GitHub:** [`@MrPowerGamerBR`](https://github.com/MrPowerGamerBR)
* **Twitter/X:** [`@MrPowerGamerBR`](https://twitter.com/MrPowerGamerBR)
* **Website:** [`mrpowergamerbr.com`](https://mrpowergamerbr.com/)