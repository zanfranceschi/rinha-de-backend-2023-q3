# Rinha de Backend 2023

![logo da rinha de backend](/misc/default.jpg)

## O que é?
Tudo começou com [esse tweet](https://twitter.com/zanfranceschi/status/1685083383397765120). E termininou com uma [live no youtube](https://www.youtube.com/watch?v=VupOWCVQwR8).


De 28 de Julho a 25 de Agosto foi realizada a Rinha de Backend que é um torneio em que a API que suportasse mais carga durante um teste de stress seria a vencedora. Participantes tiveram que implementar uma API com endpoints para criar, consultar e buscar 'pessoas' (uma espécie de CRUD sem UPDATE e DELETE). No torneio, participantes ainda tiveram que lidar com restrições de CPU e memória – cada participantes teve que entregar a API no formato de docker-compose podendo usar apenas 1,5 unidades de CPU e 3GB de memória. Mais detalhes sobre aspectos técnicos podem ser encontrados [nas instruções](/INSTRUCOES.md).


## Resultados
A Rinha usou um critério simples e irrealista apenas para finalidade de haver um ranking qualquer: a API que tiver mais registros no banco.
Você pode conferir todos os resultados e relatórios acessando o diretório [resultados](/resultados/) e cada submissão em [participantes](/participantes/). Todos os testes foram executados numa instância EC2 na AWS e as especificações podem ser encontradas [aqui](/misc/lshw-aws).

### Resultado da Etapa Final

| posição | participante | contagem de pessoas | p99 geral | submissão |
| --- | --- | --- | --- | --- |
| 1 | viniciusfonseca | 44936 | 17418 | [README](/participantes/viniciusfonseca/README.md) |
| 2 | h4nkb31f0ng | 44270 | 15690 | [README](/participantes/h4nkb31f0ng/README.md) |
| 3 | grupo-2a | 44200 | 17668 | [README](/participantes/grupo-2a/README.md) |
| 4 | sofia_aripiprazole | 43731 | 58571 | [README](/participantes/sofia_aripiprazole/README.md) |
| 5 | lpicanco | 42832 | 29764 | [README](/participantes/lpicanco/README.md) |
| 6 | isadora-souza | 42612 | 57327 | [README](/participantes/isadora-souza/README.md) |
| 7 | vimsos | 42041 | 3159 | [README](/participantes/vimsos/README.md) |
| 8 | jrodrigues | 41193 | 44445 | [README](/participantes/jrodrigues/README.md) |
| 9 | navarro | 39356 | 23958 | [README](/participantes/navarro/README.md) |
| 10 | navarro-touche | 36106 | 11772 | [README](/participantes/navarro-touche/README.md) |


### Resultado da Primeira Etapa

| posição | participante | contagem de pessoas | p99 geral | submissão |
| --- | --- | --- | --- | --- |
| 1 | viniciusfonseca | 44628 | 16994 | [README](/participantes/viniciusfonseca/README.md) |
| 2 | h4nkb31f0ng | 44270 | 16405 | [README](/participantes/h4nkb31f0ng/README.md) |
| 3 | grupo-2a | 44100 | 17588 | [README](/participantes/grupo-2a/README.md) |
| 4 | isadora-souza | 42122 | 55570 | [README](/participantes/isadora-souza/README.md) |
| 5 | sofia_aripiprazole | 40938 | 62753 | [README](/participantes/sofia_aripiprazole/README.md) |
| 6 | vimsos | 39996 | 2799 | [README](/participantes/vimsos/README.md) |
| 7 | jrodrigues | 39070 | 44045 | [README](/participantes/jrodrigues/README.md) |
| 8 | lpicanco | 37693 | 28739 | [README](/participantes/lpicanco/README.md) |
| 9 | navarro | 37567 | 18183 | [README](/participantes/navarro/README.md) |
| 10 | navarro-touche | 35865 | 12773 | [README](/participantes/navarro-touche/README.md) |
| 11 | oliveigah | 34809 | 47416 | [README](/participantes/oliveigah/README.md) |
| 12 | lucaswilliameufrasio | 34680 | 1127 | [README](/participantes/lucaswilliameufrasio/README.md) |
| 13 | luucaspole | 34165 | 48510 | [README](/participantes/luucaspole/README.md) |
| 14 | met4tron | 27904 | 59707 | [README](/participantes/met4tron/readme.md) |
| 15 | rode | 26607 | 2674 | [README](/participantes/rode/README.md) |
| 16 | saiintbrisson | 26567 | 3454 | [README]() |
| 17 | lauroappelt | 25493 | 21533 | [README](/participantes/lauroappelt/README.md) |
| 18 | brunoborges | 25352 | 44867 | [README](/participantes/brunoborges/README.md) |
| 19 | lazaronixon | 24466 | 3097 | [README](/participantes/lazaronixon/README.md) |
| 20 | leandronsp | 24418 | 54741 | [README](/participantes/leandronsp/README.md) |
| 21 | iancambrea | 23831 | 19279 | [README](/participantes/iancambrea/README.md) |
| 22 | thelinuxlich | 22762 | 25409 | [README](/participantes/thelinuxlich/README.md) |
| 23 | luanpontes100 | 21315 | 54779 | [README](/participantes/luanpontes100/README.md) |
| 24 | lauroappeltv2 | 16554 | 13854 | [README](/participantes/lauroappeltv2/README.md) |
| 25 | true_eduardo | 16415 | 7893 | [README](/participantes/true_eduardo/README.md) |
| 26 | rodrigoknol | 16265 | 59210 | [README](/participantes/rodrigoknol/README.md) |
| 27 | korodzi | 16217 | 5178 | [README](/participantes/korodzi/README.md) |
| 28 | lucasteles | 16074 | 20162 | [README](/participantes/lucasteles/README.md) |
| 29 | MarcosCostaDev | 13368 | 17304 | [README](/participantes/MarcosCostaDev/README.md) |
| 30 | boaglio | 12957 | 59724 | [README](/participantes/boaglio/README.md) |
| 31 | viniciusferraz-nativo | 12247 | 5879 | [README](/participantes/viniciusferraz-nativo/README.md) |
| 32 | andrelsmelo | 11933 | 25576 | [README](/participantes/andrelsmelo/README.md) |
| 33 | viniciusferraz | 11521 | 7916 | [README]() |
| 34 | OpenCodeCo | 10960 | 20236 | [README](/participantes/OpenCodeCo/README.md) |
| 35 | EuFountai | 10549 | 58238 | [README](/participantes/EuFountai/README.md) |
| 36 | andrew-vasco | 8869 | 59655 | [README](/participantes/andrew-vasco/README.md) |
| 37 | willy-r | 8458 | 36359 | [README](/participantes/willy-r/README.md) |
| 38 | gustavocs789 | 8002 | 18608 | [README](/participantes/gustavocs789/README.md) |
| 39 | juniorleaoo | 7761 | 58901 | [README](/participantes/juniorleaoo/README.md) |
| 40 | dscamargo | 7503 | 16511 | [README](/participantes/dscamargo/README.md) |
| 41 | bpaulino0 | 7351 | 37202 | [README](/participantes/bpaulino0/README.md) |
| 42 | wesleynepo | 7320 | 21249 | [README](/participantes/wesleynepo/README.md) |
| 43 | ftsuda | 6951 | 60299 | [README](/participantes/ftsuda/README.md) |
| 44 | fernandozanutto | 6233 | 39774 | [README](/participantes/fernandozanutto/README.md) |
| 45 | reonardoleis | 5844 | 8810 | [README](/participantes/reonardoleis/README.md) |
| 46 | giovannibassi | 5658 | 58745 | [README](/participantes/giovannibassi/README.md) |
| 47 | Bandolin | 5205 | 16210 | [README](/participantes/Bandolin/README.md) |
| 48 | cleciusjm | 3720 | 50390 | [README](/participantes/cleciusjm/README.md) |
| 49 | Pr3d4dor-php-puro | 3002 | 59348 | [README](/participantes/Pr3d4dor-php-puro/README.md) |
| 50 | wendryo | 2835 | 44839 | [README](/participantes/wendryo/README.md) |
| 51 | leandronsp-bash | 17 | 47482 | [README](/participantes/leandronsp-bash/README.md) |
| - | felipemarkson (43667 - desq.) | 0 | 58617 | [README](/participantes/felipemarkson/README.md) |
| - | alberto_souza | 0 | 0 | [README](/participantes/alberto_souza/README.md) |
| - | allan-cordeiro | 0 | 0 | [README](/participantes/allan-cordeiro/readme.MD) |
| - | andre237 | 0 | 0 | [README](/participantes/andre237/README.md) |
| - | Bandolin_simplified_api | 0 | 40267 | [README](/participantes/Bandolin_simplified_api/README.md) |
| - | brahma | 0 | 5759 | [README](/participantes/brahma/README.md) |
| - | CaravanaCloud | 0 | 19377 | [README](/participantes/CaravanaCloud/README.md) |
| - | carlosdaniiel07 | 0 | 0 | [README](/participantes/carlosdaniiel07/README.md) |
| - | danielfireman | 0 | 0 | [README](/participantes/danielfireman/README.md) |
| - | davidlins | 0 | 0 | [README](/participantes/davidlins/README.md) |
| - | dupla-de-2 | 0 | 51942 | [README](/participantes/dupla-de-2/README.md) |
| - | fabricio_juliatto | 0 | 0 | [README](/participantes/fabricio_juliatto/README.md) |
| - | flavio1110 | 0 | 0 | [README](/participantes/flavio1110/README.md) |
| - | guimeira | 0 | 20227 | [README](/participantes/guimeira/README.md) |
| - | gustmrg | 0 | 16880 | [README](/participantes/gustmrg/README.md) |
| - | h4ad | 0 | 54593 | [README](/participantes/h4ad/README.md) |
| - | hampshire | 0 | 0 | [README](/participantes/hampshire/README.md) |
| - | igorsantos07 | 0 | 0 | [README](/participantes/igorsantos07/README.md) |
| - | insalubre | 0 | 0 | [README](/participantes/insalubre/README.MD) |
| - | isaacnborges | 0 | 40090 | [README](/participantes/isaacnborges/README.md) |
| - | kalogs-c | 0 | 59594 | [README](/participantes/kalogs-c/README.md) |
| - | krymancer | 0 | 10231 | [README](/participantes/krymancer/README.md) |
| - | lucasmadeira | 0 | 5720 | [README](/participantes/lucasmadeira/README.md) |
| - | lucasnribeiro | 0 | 11740 | [README](/participantes/lucasnribeiro/README.md) |
| - | lucasraziel | 0 | 0 | [README](/participantes/lucasraziel/README.md) |
| - | LuisKpBeta | 0 | 41978 | [README](/participantes/LuisKpBeta/README.md) |
| - | marcospaulo | 0 | 50418 | [README](/participantes/marcospaulo/README.md) |
| - | matheuslc | 0 | 0 | [README](/participantes/matheuslc/README.md) |
| - | MrPowerGamerBR | 0 | 0 | [README](/participantes/MrPowerGamerBR/README.md) |
| - | natanaelsimoes | 0 | 0 | [README](/participantes/natanaelsimoes/README.md) |
| - | Pr3d4dor-laravel | 0 | 24781 | [README](/participantes/Pr3d4dor-laravel/README.md) |
| - | ramoncunha | 0 | 0 | [README](/participantes/ramoncunha/README.md) |
| - | rodrigograudo | 0 | 0 | [README](/participantes/rodrigograudo/README.md) |
| - | rwillians | 0 | 245 | [README]() |
| - | sinhorinho | 0 | 23474 | [README]() |
| - | Tagliatti | 0 | 16077 | [README](/participantes/Tagliatti/README.md) |
| - | uasouz | 0 | 0 | [README](/participantes/uasouz/README.md) |
| - | vhogemann | 0 | 20054 | [README](/participantes/vhogemann/README.md) |
| - | willian | 0 | 0 | [README](/participantes/willian/README.md) |


## Premiação

Ao final do torneio, o pessoal da Gatling decidiu apoiar a Rinha e ofereceu prêmios para os 10 primeiros colocados. Mais detalhes sobre os prêmios, podem ser encontrados na [página da rinha no site da Gatling](https://content.gatling.io/rinha-de-backend).