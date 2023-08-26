#!/usr/bin/bash

# docker system prune -f

GATLING_BIN_DIR=$HOME/gatling/bin
GATLING_WORKSPACE=$HOME/rinha-de-backend-2023-q3/stress-test
RESULTS_WORKSPACE=$HOME/rinha-de-backend-2023-q3/resultados/final

finalistas=(
	"viniciusfonseca"
	"h4nkb31f0ng"
	"grupo-2a"
	"isadora-souza"
	"sofia_aripiprazole"
	"vimsos"
	"jrodrigues"
	"lpicanco"
	"navarro"
	"navarro-touche")

for finalista in ${finalistas[@]}; do
(
    diretorio="participantes/$finalista/"
    echo "======================"
    echo $finalista

    if test -f "$RESULTS_WORKSPACE/$finalista/testado"; then
        echo "$finalista já testado - ignorando."
    else
        cd $diretorio
        echo "iniciando e logando execução da API"
        mkdir "$RESULTS_WORKSPACE/$finalista"
        docker-compose up -d --build
        docker-compose logs > "$RESULTS_WORKSPACE/$finalista/docker-compose.logs"
        echo "pausa de 15 segundos para startup pra API"
        sleep 15
        echo "iniciando teste"
        sh $GATLING_BIN_DIR/gatling.sh -rm local -s RinhaBackendSimulation \
            -rd $finalista \
            -rf "$RESULTS_WORKSPACE/$finalista" \
            -sf $GATLING_WORKSPACE/user-files/simulations \
            -rsf $GATLING_WORKSPACE/user-files/resources
        echo "teste finalizado"
        echo "fazendo request e salvando a contagem de pessoas"
        curl -v "http://localhost:9999/contagem-pessoas" > "$RESULTS_WORKSPACE/$finalista/contagem-pessoas.log"
        echo "cleaning up do docker"
        docker-compose rm -f
        docker-compose down
        touch "$RESULTS_WORKSPACE/$finalista/testado"
    fi
)
done
