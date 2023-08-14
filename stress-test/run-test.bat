@echo off

SET "GATLING_HOME=%USERPROFILE%\gatling\3.9.5"
SET "GATLING_BIN_DIR=%USERPROFILE%\gatling\3.9.5\bin"
SET "WORKSPACE=%USERPROFILE%\git\rinha-de-backend-2023-q3\stress-test"

CALL "%GATLING_BIN_DIR%\gatling.bat" -rm local -s RinhaBackendSimulation ^
    -rd "DESCRICAO" ^
    -rf "%WORKSPACE%\user-files\results" ^
    -sf "%WORKSPACE%\user-files\simulations" ^
    -rsf "%WORKSPACE%\user-files\resources"

ping 127.0.0.1 -n 3 >nul

curl -v "http://localhost:9999/contagem-pessoas"
