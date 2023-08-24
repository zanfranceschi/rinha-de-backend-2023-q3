#!/usr/bin/bash

docker system prune -f

GATLING_BIN_DIR=$HOME/gatling/bin
GATLING_WORKSPACE=$HOME/rinha-de-backend-2023-q3/stress-test
RESULTS_WORKSPACE=$HOME/rinha-de-backend-2023-q3/resultados/primeira-fase

for diretorio in participantes/*/; do
(
    participante=$(echo $diretorio | sed -e 's/participantes\///g' -e 's/\///g')
    echo "======================"
    echo $participante

    if test -f "$RESULTS_WORKSPACE/$participante/testado"; then
        echo "$participante já testado - ignorando."
    else
        cd $diretorio
        echo "iniciando e logando execução da API"
        mkdir "$RESULTS_WORKSPACE/$participante"
        docker-compose up -d --build
        docker-compose logs > "$RESULTS_WORKSPACE/$participante/docker-compose.logs"
        echo "pausa de 10 segundos para startup pra API"
        sleep 45
        echo "iniciando teste"
        sh $GATLING_BIN_DIR/gatling.sh -rm local -s RinhaBackendSimulation \
            -rd $participante \
            -rf "$RESULTS_WORKSPACE/$participante" \
            -sf $GATLING_WORKSPACE/user-files/simulations \
            -rsf $GATLING_WORKSPACE/user-files/resources
        echo "teste finalizado"
        echo "fazendo request e salvando a contagem de pessoas"
        curl -v "http://localhost:9999/contagem-pessoas" > "$RESULTS_WORKSPACE/$participante/contagem-pessoas.log"
        echo "cleaning up do docker"
        docker-compose rm -f
        docker-compose down
        touch "$RESULTS_WORKSPACE/$participante/testado"
    fi
)
done
