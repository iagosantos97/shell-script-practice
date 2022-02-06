#!/usr/bin/env bash

USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"

MENSAGEM_USO="
  $(basename $0) - [OPÇÕES]
    -h - Menu de Ajuda
    -v - Versão do Programa
    -s - Ordenar a saída
"

VERSAO="v1.0"
CHAVE_ORDENA=0
CHAVE_MAIUSCULA=0

while test -n "$1"
do
  case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0 ;;
    -v) echo "Versão: $VERSAO" && exit 0 ;;
    -s) CHAVE_ORDENA=1 ;;
    -m) CHAVE_MAIUSCULA=1 ;;
    * ) echo "Opção inválida, valie o -h." && exit 1 ;;
  esac
  shift
done

[ $CHAVE_ORDENA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort)
[ $CHAVE_MAIUSCULA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
