# :heart_on_fire: GoSeventh - Competição de Backend 

## :thinking: O que é isso?
Este repositório contem o código-fonte do servidor http para a [competição de backends](https://github.com/zanfranceschi/rinha-de-backend-2023-q3/blob/main/INSTRUCOES.md)

## :star2: Recursos e Conteúdo
Neste repositório, você encontrará o **código-fonte** completo da api rest e todas as **estratégias desenvolvidas** com o propósito de construir **a melhor versão do software** que entrega o **equilibrio** entre **performance** e **segurança**. Algumas estratégias são focadas em apenas **performance** para fins de benchmark e comparações com versões seguras, mas em cenários reais a **estratégia principal vs a estratégia convencional** são o que realmente importa. Há diversos testes de benchmarks para que você mesmo tire suas conclusões e descubra a melhor estratégia para lidar com altas demandas consumindo baixos recursos, e **entregando alto desempenho e velocidade**. **Lembre-se** de que os benchmarks efetuam **leituras e escritas intensas no seu disco** e talvez seu hardware não consiga acompanhar o rítimo dos testes, **esteja preparado**. 

# :books: Arquitetura do proejto:

:unlock: **cmd**: Esta pasta contém os arquivos principais (main) em linguagem Go. Cada arquivo main pode representar um componente independente do servidor ou uma funcionalidade específica. Geralmente, esses arquivos são os pontos de entrada da aplicação, iniciando a execução do servidor e gerenciando configurações.

:lock: **internal**: Aqui, estão localizados os pacotes internos do projeto. Esses pacotes contêm a lógica de negócios e a implementação central do backend. Eles são projetados para serem utilizados internamente dentro do projeto e podem ser importados por outros componentes do servidor, como os arquivos main na pasta "cmd".

:loudspeaker: **pkg**: Nesta pasta, você encontrará pacotes públicos. Esses pacotes são bibliotecas ou componentes reutilizáveis que podem ser compartilhados com outros projetos ou utilizados por desenvolvedores externos. Eles oferecem funcionalidades complexas que podem ser facilmente integradas em outros sistemas.egócio 

# :clap: Créditos:
❤️ **Criado por:** [@alph4b3th](https://github.com/alph4b3th)
