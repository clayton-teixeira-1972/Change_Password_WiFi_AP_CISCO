# Password-AP-Cisco

   - Autor: Clayton Teixeira

Automação para alterar senha wifi em concentrador CISCO.<br>
O script irá acessar o equipamento CISCO através de usuário, senha e ip do equipamento definidos dentro do script nas váriaveis:
Endereço Ip do equipamento
usuario do equipamento
senha do usuário do equipamento
lista de e-mails para envio da nova senha gerada pelo sistema

A senha é gerada automáticamente de forma criptografada sem acesso a mesma pelo código, e enviada via email para os usuários no final do processo.

# Pré-requisitos:

Acesso ssh ao equipamento concentrador CISCO para que possa ser feito a comunicação e execucção do processo de troca automática de senha.

# Sintaxe de utilização:

wifi_pw_change.sh 

Ao executar o script através do Jenkins com períodos de agendamento definidos o script criará automáticamente uma senha aleatória e repassará via email (emails definidos dentro do script) para os usuários da rede.


# Autor:

Clayton Teixeira

Utiliza linguagem iterativa TCL/TK 
