#!/usr/bin/env bash

# VARIÁVEIS

ARQUIVO_DE_CONFIGURACAO="configuracao.cf"
USAR_CORES=
USAR_MAIUSCULAS=
MENSAGEM="Essa é uma mensagem de teste."

VERMELHO="\033[31;1m"

# TESTES

[[ -f "$ARQUIVO_DE_CONFIGURACAO" && ! -r "$ARQUIVO_DE_CONFIGURACAO" ]] && echo "Não temos permissão de leitura no arquivo $ARQUIVO_DE_CONFIGURACAO" && exit 1
[[ ! -f "$ARQUIVO_DE_CONFIGURACAO" ]] && echo "Arquivo $ARQUIVO_DE_CONFIGURACAO não encontrado." && exit 1

# FUNÇÕES

DefinirParametros() {
    local parametro="$(echo $1 | cut -d = -f 1)"
    local valor="$(echo $1 | cut -d = -f 2)"

    case "$parametro" in
        USAR_CORES) USAR_CORES="$valor" ;;
	USAR_MAIUSCULAS) USAR_MAIUSCULAS="$valor" ;;
    esac
}

# EXECUÇÃO

while read -r linha
do
    [[ "$(echo $linha | cut -c1)" = "#" || ! -n "$linha"  ]] && continue
    DefinirParametros "$linha"
done < "$ARQUIVO_DE_CONFIGURACAO"

[ "$USAR_MAIUSCULAS" = "1" ] && MENSAGEM="$(echo -e $MENSAGEM | tr [a-z] [A-Z])"
[ "$USAR_CORES" = "1" ] && MENSAGEM="$(echo -e ${VERMELHO}$MENSAGEM)"

echo "$MENSAGEM"
