#!/bin/bash

ARQUIVO="$1"
BACKUP="${ARQUIVO%.*}_bkp.txt"

if [ ! -f "$ARQUIVO" ]; then
    echo "Erro: O arquivo fornecido não existe."
    exit 1
fi

cp "$ARQUIVO" "$BACKUP"
echo "Backup criado: $BACKUP"

listar() {
    read -p "Digite o erro a ser buscado: " palavra
    echo "Ocorrências de '$palavra':"
    grep "$palavra" "$ARQUIVO" || echo "Nenhuma ocorrência encontrada."
}

remover() {
    read -p "Digite a palavra: " palavra
    sed -i "/$palavra/d" "$ARQUIVO"
    echo "Linhas contendo '$palavra' foram removidas."
}

qtd_ocorrencias() {
    read -p "Digite a palavra do erro: " palavra
    qtd=$(grep -c "$palavra" "$ARQUIVO")
    echo "O erro '$palavra' apareceu $qtd vezes no log."
}

last() {
    echo "As 10 últimas linhas do log são:"
    tail -n 10 "$ARQUIVO"
}

menu() {
    while true; do
        echo "----------------------------"
        echo "      Menu de Opções        "
        echo "----------------------------"
        echo "1 - Listar ocorrências de um erro"
        echo "2 - Remover linhas irrelevantes"
        echo "3 - Contar ocorrências de um erro"
        echo "4 - Exibir as 10 últimas linhas do log"
        echo "5 - Sair"
        echo "----------------------------"
        read -p "Escolha uma opção: " opc

        case $opc in
            1) listar ;;
            2) remover ;;
            3) qtd_ocorrencias ;;
            4) last ;;
            5) echo "Execução do Script finalizada."; exit 0 ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}

menu
