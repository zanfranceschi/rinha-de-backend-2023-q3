#! /usr/bin/env sh

# Exemplos de requests
# curl -v -XPOST -H "content-type: application/json" -d '{"apelido" : "xpto", "nome" : "xpto xpto", "nascimento" : "2000-01-01", "stack": null}' "http://localhost:9999/pessoas"
# curl -v -XGET "http://localhost:9999/pessoas/1"
# curl -v -XGET "http://localhost:9999/pessoas?t=xpto"
# curl -v "http://localhost:9999/contagem-pessoas"

WORKSPACE=$(pwd)
GATLING_BIN_DIR="${WORKSPACE}/deps/gatling/bin"

sh ${GATLING_BIN_DIR}/gatling.sh \
  -rm local \
  -s RinhaBackendSimulation \
  -rd "DESCRICAO" \
  -rf ${WORKSPACE}/user-files/results \
  -sf ${WORKSPACE}/user-files/simulations \
  -rsf ${WORKSPACE}/user-files/resources

sleep 3

COUNT=$(curl -fsSL "http://localhost:9999/contagem-pessoas")
echo "${COUNT}"
