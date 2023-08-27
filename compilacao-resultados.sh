#!/usr/bin/bash

RESULTS_WORKSPACE=$HOME/projects/rinha-de-backend-2023-q3/resultados/final
SUB_WORKSPACE=$HOME/projects/rinha-de-backend-2023-q3/participantes

for diretorio in resultados/final/*/; do
(
    participante=$(echo $diretorio | sed -e 's/resultados\/final\///g' -e 's/\///g')
    cd $diretorio
    contagem=$(cat "$RESULTS_WORKSPACE/$participante/contagem-pessoas.log")
    report_dir=$(find "$RESULTS_WORKSPACE/$participante" -maxdepth 1 -type d | grep simul)
    readme=$(find "$SUB_WORKSPACE/$participante" -maxdepth 1 | grep -i read)
    p99=$(jq '.stats.percentiles4.ok' "$report_dir/js/stats.json")
    echo "$participante $contagem   $p99    [README]($readme)"
)
done
