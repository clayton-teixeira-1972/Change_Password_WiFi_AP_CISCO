#/bin/bash
##################################################################################
#
# Autor: Clayton Teixeira - 2021 - TIVIT POD3 - Automation Team
#        Troca de senha automatizada para wifi usando CISCO concentrator
#
##################################################################################

# troque as variaveis baixo pelo seu conetudo desejado:
# usuario = usuario que tem permissao no equipamento CISCO concentrator
# endip = endereco ip do equipamento CISCO concentrator
# senha = senha de acesso ao equipamento CISCO concentrator

clear

data=`date +'%d-%m-%y_%H_%M_%S'`
usuario="USUARIO_EQUIPAMENTO"
endip=ENDERECO_IP_EQUIPAMENTO
senha=SENHA_EQUIPAMENTO
nova_pw_wifi=`date +%N%S%M%H%d%m%S|sha256sum|base64|head -c 8`

echo "_______________________________________________________________________________" > wifi_pw_chg_${endip}_${data}.log
echo "Data: ${data}" >> wifi_pw_chg_${endip}_${data}.log


wifi_password_change(){
echo "-------------------------------------------------------------------------"
echo "Processing WI-FI password change..."
expect <<EOF
     spawn ssh ${usuario}@${endip}
     sleep 2
     expect "User:"
     send "${usuario}\r"
     sleep 1
     expect "Password:"
     send "${senha}\r"
     expect ">"
     log_file -append wifi_pw_chg_${endip}_${data}.log;
     expect ">"
     send "config wlan disable 13\r"
     expect ">"
     send "config wlan security wpa akm psk set-key ascii ${nova_pw_wifi} 13\r"
     expect ">"
     send "config wlan enable 13\r"
     expect ">"
     send "logout \r"
     expect ">"
     log_file;
EOF
}
wifi_password_change

echo "Prezado usuário, a nova senha de Wifi é: ${nova_pw_wifi}" | mutt -e 'set content_type=text/html;set edit_headers=yes; set from=noreply@DOMINIO' -s "NOME_DO_CLIENTE  - Automatic wifi password change - `date`" -c EMAIL@DOMINIO
