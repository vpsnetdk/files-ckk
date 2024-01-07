#!/bin/bash

BadVPN () {
msg -bar3 
pid_badvpn=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')
unset bot_ini
if [ "$pid_badvpn" = "" ]; then
msg -ama " FUNCION EXPERIMENTAL AGREGARA PUERTO 7300 en BADVPN-UDP"
msg -ama "  ADICIONAL APERTURARENOS EL 7200 PARA UN DUAL CHANNEL"
#msg -ama "        MAXIMO DE 100 CONEXIONES POR CLIENTE"
msg -bar3 
[[ $(dpkg --get-selections|grep -w "toilet"|head -1) ]] || apt-get install toilet -y &>/dev/null
    if [[ ! -e /bin/badvpn-udpgw ]]; then
	echo -ne "	    DESCARGANDO BINARIO UDP .."
  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  if wget -O /bin/badvpn-udpgw https://github.com/emirjorge/Script-Z/raw/master/CHUMO/Recursos/ferramentas/badvpn-udpgw-arm &>/dev/null ; then
  chmod 777 /bin/badvpn-udpgw
  msg -verd "[OK]"  
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  if wget -O /bin/badvpn-udpgw https://github.com/emirjorge/Script-Z/raw/master/CHUMO/Recursos/ferramentas/badvpn-udpgw-plus &>/dev/null ; then
  chmod 777 /bin/badvpn-udpgw
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  }
	msg -ama "                   ACTIVANDO BADVPN Plus"
	msg -bar3
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
    fi
    (
	screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 #--client-socket-sndbuf 10000
	screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10 #--client-socket-sndbuf 10000
#	screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 
#	screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10 
	) || msg -ama "                Error al Activar BadVPN" 
	sleep 2s 
	msg -bar3
    [[ ! -z $(ps x | grep badvpn | grep -v grep ) ]] && { 
	msg -verd "                  ACTIVADO CON EXITO" 
		msg -bar3
	echo -e "  PREGUNTA PREVIA POR 15 SEGUNDOS !!!"
	msg -bar3
	read -t 15 -p " $(echo -e "\033[1;97m Poner en linea despues de un reinicio [s/n]: ")" -e -i "s" bot_ini
	msg -bar3
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
		[[ $bot_ini = @(s|S|y|Y) ]] && {
	[[ $(grep -wc "badvpn" /bin/autoboot) = '0' ]] && {
						echo -e " AUTOREINICIO EN INACTIVIDAD PREACTIVADO !! " && sleep 2s
						tput cuu1 && tput dl1
						echo -e "netstat -tlpn | grep -w 7300 > /dev/null || {  screen -r -S 'badvpn' -X quit;  screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
						echo -e "netstat -tlpn | grep -w 7200 > /dev/null || {  screen -r -S 'badUDP72' -X quit;  screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 10000 --max-connections-for-client 10; }" >>/bin/autoboot
					} || {
						sed -i '/badvpn/d' /bin/autoboot
						echo -e " AUTOREINICIO EN INACTIVIDAD REACTIVADO !! " && sleep 2s
						tput cuu1 && tput dl1
						echo -e "netstat -tlpn | grep -w 7300 > /dev/null || {  screen -r -S 'badvpn' -X quit;  screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
						echo -e "netstat -tlpn | grep -w 7200 > /dev/null || {  screen -r -S 'badUDP72' -X quit;  screen -dmS badUDP72 $(which badvpn-udpgw) --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
					}
	#-------------------------
} ||  sed -i '/badvpn-udpgw/d' /bin/autoboot
}

else
clear&&clear
msg -bar3
msg -ama "      Administrador BadVPN UDP | @ChumoGH•Plus"
msg -bar3
menu_func "AÑADIR 1+ PUERTO BadVPN $_pid" "$(msg -verm2 "Detener BadVPN")" #"$(msg -ama "Reiniciar BadVPN")"
 echo -ne "$(msg -verd " [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar3
  opcion=$(selection_fun 2)  
  case $opcion in
  1)
msg -bar3 
msg -ama " FUNCION EXPERIMENTAL AGREGARA PUERTO en BADVPN-UDP"
#msg -ama "  ADICIONAL APERTURARENOS EL 7200 PARA UN DUAL CHANNEL"
#msg -ama "        MAXIMO DE 100 CONEXIONES POR CLIENTE"
msg -bar3 
read -p " DIJITA TU PUERTO CUSTOM PARA BADVPN :" -e -i "7100" port
echo -e " VERIFICANDO BADVPN "
msg -bar3 
screen -dmS badvpn$port /bin/badvpn-udpgw --listen-addr 127.0.0.1:${port} --max-clients 1000 --max-connections-for-client 10 && msg -ama "               BadVPN ACTIVADA CON EXITO"  || msg -ama "                Error al Activar BadVPN" 
echo -e "netstat -tlpn | grep -w ${port} > /dev/null || {  screen -r -S 'badvpn'$port -X quit;  screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:${port} --max-clients 1000 --max-connections-for-client 10; }" >>/bin/autoboot
msg -bar3
return
  ;;
  2)
msg -ama "                DESACTIVANDO BADVPN"
    msg -bar3
	kill -9 $(ps x | grep badvpn | grep -v grep | awk '{print $1'}) > /dev/null 2>&1
    killall badvpn-udpgw > /dev/null 2>&1
	sed -i '/badvpn/d' /bin/autoboot
	echo -e " AUTOREINICIO EN INACTIVIDAD ELIMINADO !! " && sleep 2s
	tput cuu1 && tput dl1
    [[ ! "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -ama "                APAGADO EXITOSAMENTE \n" || msg -verm "                ERROR AL DETENER BadVPN!! \n"
    unset pid_badvpn
	msg -bar3
return
  ;;
  3) exit;;
  0) exit;;
 esac   	
fi
unset pid_badvpn
}
BadVPN
msg -bar3
clear&&clear
msg -bar3
toilet -f pagga "ChumoGH-UDP" | lolcat
msg -bar3
return
