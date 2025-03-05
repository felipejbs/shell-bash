#!/bin/bash

ARQUIVO="$1"
BACKUP="${ARQUIVO%.*}_bkp.txt"

if [ ! -f "$ARQUIVO" ]; then
    echo "Erro: O arquivo fornecido não existe."
    exit 1
fi

cp "$ARQUIVO" "$BACKUP"
echo "Backup criado: $BACKUP"

substituir() {
    read -p "Digite a palavra a ser substituída: " p_antiga
    read -p "Digite a nova palavra: " p_nova
    sed -i "s/$p_antiga/$p_nova/g" "$ARQUIVO"
    echo "Substituição concluída."
}

remover() {
    read -p "Digite a palavra para ser removida: " palavra
    sed -i "/$palavra/d" "$ARQUIVO"
    echo "Linhas contendo '$palavra' foram removidas."
}

add_prefixo() {
    read -p "Digite o prefixo para ser adicionado: " prefixo
    sed -i "s/^/$prefixo/" "$ARQUIVO"
    echo "Prefixo '$prefixo' adicionado a todas as linhas."
}

listar() {
    read -p "Digite a palavra para filtrar: " palavra
    grep "$palavra" "$ARQUIVO"
}

menu() {
    while true; do
        echo "----------------------------"
	echo "     Menu de Opções         "        
	echo "----------------------------"
	echo "1 - Substituir uma palavra"
        echo "2 - Remover linhas contendo uma palavra"
        echo "3 - Adicionar um prefixo a todas as linhas"
        echo "4 - Listar apenas as linhas que contêm uma palavra"
        echo "5 - Sair"
        echo "----------------------------"
        read -p "Escolha uma opção: " opc

        case $opc in
            1) substituir ;;
            2) remover ;;
            3) add_prefixo ;;
            4) listar ;;
            5) echo "Execução do Script finalizada."; exit 0 ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}

menu
