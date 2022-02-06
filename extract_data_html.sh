#!/usr/bin/env bash

# VARIAVEIS

ARQUIVO_DE_TITULOS="titulos.txt"

VERMELHO="\033[31;1m"
AMARELO="\033[33;1m"

# TESTES

[ ! -x "$(which lynx)" ] && sudo apt-get install lynx -y # Lynx instalado?

# EXECUÇÃO

lynx -source lxer.com | grep 'blur' | sed 's/<div.*line">//;s/<\/span.*//' > $ARQUIVO_DE_TITULOS

while read -r titulo
do
    echo -e "${AMARELO}Título: ${VERMELHO}${titulo}"
done < "$ARQUIVO_DE_TITULOS"

rm -rf $ARQUIVO_DE_TITULOS
