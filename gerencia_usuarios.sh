#!/bin/bash

criar(){
	read -p "Digite o nome do usuario: " usuario
	if id "$usuario" &>/dev/null; then
		echo "Erro: o usuario já existe"
	else
		sudo useradd "$usuario" && echo "usuario criado com sucesso." || echo "erro ao criar usuario."
	fi
}

excluir(){
	read -p "Digite o nome do usuario: " usuario
	if id "$usuario" &>/dev/null; then
		sudo userdel "$usuario" && echo "usuario removido." || "Erro ao remover usuario."
	else
		echo "Erro: usuario não existe."
	fi
}

criar_grupo(){
	read -p "Digite o nome do grupo: " grupo
	if getent group "$grupo" > /dev/null; then
		echo "Erro: O grupo já existe."
	else
		sudo groupadd "$grupo" && echo "grupo criado." || "Erro ao criar grupo."
	fi
}

excluir_grupo(){
	read -p "Digite o nome do grupo: " grupo
	if getent group "$grupo" > /dev/null; then
		sudo groupdel "$grupo" && echo "grupo removido." || echo "Erro ao remover o grupo."
	else
		echo "Erro: grupo não existe."
	fi
}

add_usuario_grupo() {
    read -p "Digite o nome do usurio: " usuario
    read -p "Digite o nome do grupo: " grupo
    if id "$usuario" &>/dev/null && getent group "$grupo" > /dev/null; then
        sudo usermod -aG "$grupo" "$usuario" && echo "usuario adicionado ao grupo com sucesso." || echo "Erro ao adicionar usuario ao grupo."
    else
        echo "Erro: Usuario ou grupo não existe."
    fi
}

remover_usuario() {
    read -p "Digite o nome do usuario: " usuario
    read -p "Digite o nome do grupo: " grupo
    if id "$usuario" &>/dev/null && getent group "$grupo" > /dev/null; then
        sudo gpasswd -d "$usuario" "$grupo" && echo "usuario removido do grupo com sucesso." || echo "Erro ao remover usuario do grupo."
    else
        echo "Erro: usuario ou grupo não existe."
    fi
}

listar() {
    read -p "Digite o nome do grupo: " grupo
    if getent group "$grupo" > /dev/null; then
        echo "Usuarios no grupo '$grupo':"
        getent group "$grupo" | cut -d: -f4
    else
        echo "Erro: O grupo não existe."
    fi
}


menu() {
	while true; do
		echo "------"
		echo "     Oções   "
		echo "1 - Criar usuário"
		echo "2 - Excluir usuário"
		echo "3 - Criar grupo"
		echo "4 - Excluir grupo"
		echo "5 - Adicionar usuário a grupo"
		echo "6 - Remover usuário de grupo"
		echo "7 - Listar usuários de um grupo"
		echo "8 - Sair"
		echo "--------"
		read -p "Opção: " opc
		
		case $opc in
			1) criar;;
			2) excluir;;
			3) criar_grupo;;
			4) excluir_grupo;;
			5) add_usuario_grupo;;
			6) remover_usuario;;
			7) listar;;
			8) echo "Saindo..."; exit 0;;
			*) echo "Opção invalida!";;
		esac
	done
}

menu
