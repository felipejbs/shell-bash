#!/bin/bash

listar_processos() {
    ps -eo pid,user,comm | sed '1d'
}

filtrar_processos() {
    read -p "Digite o nome do processo: " processo
    ps -eo pid,user,comm | grep "$processo" | sed 's/^ *//'
}

finalizar_id() {
    read -p "Digite o PID do processo: " pid
    if kill "$pid" 2>/dev/null; then
        echo "Processo  finalizado com sucesso."
    else
        echo "Erro ao finalizar o processo."
    fi
}

finalizar_nome() {
    read -p "Digite o nome do processo: " processo
    pids=$(pgrep "$processo")
    if [ -n "$pids" ]; then
        kill $pids && echo "Todos os processos foram finalizados." || echo "Erro ao finalizar processos."
    else
        echo "Nenhum processo encontrado."
    fi
}

menu() {
	while true; do
		echo "------"
		echo "     Oções   "
		echo "1 - Listar processos"
		echo "2 - Filtrar processos por nome"
		echo "3 - Finalizar processo por ID"
		echo "4 - Finalizar processos por nome"
		echo "5 - Sair"
		echo "--------"
		read -p "Opção: " opc
		
		case $opc in
			1) listar_processos;;
			2) filtrar_processos;;
			3) finalizar_id;;
			4) finalizar_nome;;
			5) echo "Saindo..."; exit 0;;
			*) echo "Opção invalida!";;
		esac
	done
}

menu
