#!/bin/bash  
clear  
#${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ##
#ADM_inst="/ADMcgh/slow/dnsi" && [[ ! -d ${ADM_inst} ]] && mkdir ${ADM_inst}
#ADM_inst="/ADMcgh/slow/dnsi" && [[ ! -d ${ADM_inst} ]] && mkdir ${ADM_inst}
[[ ! -d /etc/adm-lite/slow/ ]] && mkdir /etc/adm-lite/slow
ADM_slow="/etc/adm-lite/slow/dnsi" && [[ ! -d ${ADM_slow} ]] && mkdir ${ADM_slow}
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg > /dev/null || source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar3/msg) > /dev/null 
#${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ##
#${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ##

#FELICIDADES, NUNCA DEJES DE APRENDER


clear

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m ${flech} Selecione una Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}


info(){
  clear
  nodata(){
  msg -bar3
  msg -ama "        !SIN INFORMACION SLOWDNS!"
  read -p "ENTER PARA CONTINUAR"
  exit 0
  }  
  if [[ -e  ${ADM_slow}/domain_ns ]]; then
  ns=$(cat ${ADM_slow}/domain_ns)
  if [[ -z "$ns" ]]; then
  nodata
  fi
  else
  nodata
  fi  
  
  if [[ -e ${ADM_slow}/server.pub ]]; then
  key=$(cat ${ADM_slow}/server.pub)
  if [[ -z "$key" ]]; then
  nodata
  fi
  else
  nodata
  fi  
  
  msg -bar3
  msg -ama "         DATOS DE SU CONECCION SLOWDNS"
  msg -bar3
  msg -ama "Su NameServer: $(cat ${ADM_slow}/domain_ns)"
  msg -bar3
  msg -ama "Su Llave: $(cat ${ADM_slow}/server.pub)"   msg -bar3  
  read -p "ENTER PARA CONTINUAR"
  }    
  
  drop_port(){      
  local portasVAR=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")      
  local NOREPEAT      
  local reQ      
  local Port      
  unset DPB      
  while read port; do          
  reQ=$(echo ${port}|awk '{print $1}')
  Port=$(echo {$port} | awk '{print $9}' | awk -F ":" '{print $2}')          
  [[ $(echo -e $NOREPEAT|grep -w "$Port") ]] && continue          
  NOREPEAT+="$Port\n"            
  case ${reQ} in
  sshd|dropbear|stunnel4|stunnel|trojan|v2ray|xray|python|python3|openvpn|node|squid|squid3|sslh|snell-ser|ss-server|obfs-serv|trojan-go)DPB+=" $reQ:$Port";;              
  *) continue;;          
  esac      
  done <<< "${portasVAR}"   
  }    
  
  ini_slow(){
  msg -bra "INSTALADOR SLOWDNS"
  drop_port
  n=1      
  for i in $DPB; do          
  proto=$(echo $i|awk -F ":" '{print $1}')          
  proto2=$(printf '%-12s' "$proto")          
  port=$(echo $i|awk -F ":" '{print $2}')          
  echo -e " $(msg -verd "[$n]") $(msg -verm2 ">") $(msg -ama " $(echo -e " ${flech} $proto2 "| tr [:lower:] [:upper:])")$(msg -azu "$port")"          
  drop[$n]=$port          
  dPROT[$n]=$proto2          
  num_opc="$n"          
  let n++       
  done      
  msg -bar3      
  opc=$(selection_fun $num_opc)      
  echo "${drop[$opc]}" > ${ADM_slow}/puerto      
  echo "${dPROT[$opc]}" > ${ADM_slow}/protc      
  PORT=$(cat ${ADM_slow}/puerto)      
  PRT=$(cat ${ADM_slow}/protc)      
  msg -bra " INSTALADOR SLOWDNS "    
  msg -bar3  
  echo -e " $(msg -ama "Redireccion SlowDns:") $(msg -verd "$(echo -e "${PRT}" | tr [:lower:] [:upper:])") : $(msg -verd "$PORT") $(msg -ama " -> ") $(msg -verd "5300")" 
  msg -bar3 
  [[ -e /dominio_NS.txt && ! -e ${ADM_slow}/domain_ns ]] && cp /dominio_NS.txt ${ADM_slow}/domain_ns
  [[ -e ${ADM_slow}/domain_ns ]] && NS1=$(cat < ${ADM_slow}/domain_ns) || unset NS1 NS
  unset NS   
  [[ -z $NS1 ]] && {
  while [[ -z $NS ]]; do 
  msg -bar3 
  echo -ne "\e[1;31m TU DOMINIO NS \e[1;37m: "    
  read NS 
  tput cuu1 && tput dl1      
  done    
    } || {
  msg -bar3 
  echo -e "\e[1;31m      TIENES UN DOMINIO NS YA REGISTRADO \e[1;37m "    
  echo -e "\e[1;32m   TU NS ES : ${NS1} \e[1;37m "    
  echo -e "  SI QUIERES UTILIZARLO, SOLO PRESIONA ENTER "
  echo -e "       CASO CONTRARIO DIJITA TU NUEVO NS "
  msg -bar3 
  echo -ne "\e[1;31m TU DOMINIO NS \e[1;37m: "    
  read NS
  [[ -z $NS ]] && NS="${NS1}"  
  tput cuu1 && tput dl1          
  echo "$NS" > ${ADM_slow}/domain_ns      
	}
  echo "$NS" > ${ADM_slow}/domain_ns 
  echo -e " $(msg -ama "NAME SERVER:") $(msg -verd "$NS")"      
  msg -bar3        
  if [[ ! -e ${ADM_inst}/dns-server ]]; then    
  msg -ama " Descargando binario...." 
  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  if wget -O ${ADM_inst}/dns-server https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/binarios/SlowDNS/autoStart-ARM &>/dev/null ; then
  chmod +x ${ADM_inst}/dns-server    
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion cancelada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  if wget -O ${ADM_inst}/dns-server https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/binarios/SlowDNS/autoStart-x86-64 &>/dev/null ; then
  chmod +x ${ADM_inst}/dns-server    
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
  msg -bar3      
  fi        
  [[ -e "${ADM_slow}/server.pub" ]] && pub=$(cat ${ADM_slow}/server.pub)        
  if [[ ! -z "$pub" ]]; then    
  echo -ne "$(msg -ama " Usar clave existente [S/N]: ")"
  read ex_key      
  case $ex_key in    
  s|S|y|Y) tput cuu1 && tput dl1    
  echo -e " $(msg -ama "KEY.PUB:") $(msg -verd "$(cat ${ADM_slow}/server.pub)")";;    
  n|N) tput cuu1 && tput dl1    
  rm -rf ${ADM_slow}/server.key    
  rm -rf ${ADM_slow}/server.pub    
  ${ADM_inst}/dns-server -gen-key -privkey-file ${ADM_slow}/server.key -pubkey-file ${ADM_slow}/server.pub &>/dev/null    
  echo -e " $(msg -ama "KE:") $(msg -verd "$(cat ${ADM_slow}/server.pub)")";;    
  *);;    
  esac
  else    
  rm -rf ${ADM_slow}/server.key    
  rm -rf ${ADM_slow}/server.pub    
  ${ADM_inst}/dns-server -gen-key -privkey-file ${ADM_slow}/server.key -pubkey-file ${ADM_slow}/server.pub &>/dev/null
  echo -e " $(msg -ama "KEY.PUB:") $(msg -verd "$(cat ${ADM_slow}/server.pub)")"
  fi      
  msg -bar3      
  msg -azu "..._SLOWDNS ACTIVADO_..."        
  iptables -I INPUT -p udp --dport 5300 -j ACCEPT
  iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
  if screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; then
  #-------------------------
	[[ $(grep -wc "slowdns" /bin/autoboot) = '0' ]] && {
						echo -e "netstat -au | grep -w 5300 > /dev/null || {  screen -r -S 'slowdns' -X quit;  screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; }" >>/bin/autoboot
					} || {
						sed -i '/slowdns/d' /bin/autoboot
						echo -e "netstat -au | grep -w 5300 > /dev/null || {  screen -r -S 'slowdns' -X quit;  screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file ${ADM_slow}/server.key $NS 127.0.0.1:$PORT ; }" >>/bin/autoboot
					}
	#crontab -l > /root/cron
	#echo "@reboot /bin/autoboot" >> /root/cron
	#crontab /root/cron
	service cron restart
  #-------------------------
  msg -verd "    Con Exito!!!"       
  msg -bar3      
  else    
  msg -verm "    Con Fallo!!!"       
  msg -bar3      
  fi      
  read -p "ENTER PARA CONTINUAR"
  }    
  
  reset_slow(){
  clear
  msg -bar3
  msg -ama "        Reiniciando SlowDNS...."
  screen -ls | grep slowdns | cut -d. -f1 | awk '{print $1}' | xargs kill
  NS=$(cat ${ADM_slow}/domain_ns)
  PORT=$(cat ${ADM_slow}/puerto)
  if screen -dmS slowdns ${ADM_inst}/dns-server -udp :5300 -privkey-file /root/server.key $NS 127.0.0.1:$PORT ;then
  msg -verd "        Con exito!!!"    
  msg -bar3
  else    
  msg -verm "        Con fallo!!!"    
  msg -bar3
  fi
  read -p "ENTER PARA CONTINUAR"
  }  
  
  stop_slow(){
  clear
  msg -bar3
  msg -ama "        Deteniendo SlowDNS...."
  if screen -ls | grep slowdns | cut -d. -f1 | awk '{print $1}' | xargs kill ; then
    	for pidslow in $(screen -ls | grep ".slowdns" | awk {'print $1'}); do
						 screen -r -S "$pidslow" -X quit
			done
			[[ $(grep -wc "slowdns" /bin/autoboot) != '0' ]] && {
						sed -i '/slowdns/d' /bin/autoboot
			}
  screen -wipe >/dev/null
  msg -verd "         Con exito!!!"   msg -bar3
  else
  msg -verm "        Con fallo!!!"    msg -bar3
  fi
  read -p "ENTER PARA CONTINUAR"
  }    
  
  remove_slow(){
  stop_slow
  rm -rf /ADMcgh/slow/*
  }

while true; do
[[ -e ${ADM_slow}/protc ]] && PRT=$(cat ${ADM_slow}/protc | tr [:lower:] [:upper:]) || PRT='NULL' 
[[ -e ${ADM_slow}/puerto ]] && PT=$(cat ${ADM_slow}/puerto) || PT='NULL' 
[[ $(ps x | grep dns-server | grep -v grep) ]] && MT=$(msg -verd "ACTIVO!!!" ) || MT=$(msg -verm "INACTIVO!!!")
  msg -bar3
  tittle
  msg -ama "         INSTALADOR SLOWDNS | @drowkid01${p1t0}Plus"
  msg -bar3 #
  echo -e " SlowDNS +" "${PRT} ""->" "${PT}"  "| ESTADO -> ${MT}"
  msg -bar3
  #${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ## #${mbar2} ## #${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ###${mbar2} ##
  #[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
#echo -e "\033[1;32mÎ” SlowDNS no compatible en procesadores ARM " 
#echo -e "\033[1;32mÎ”  Motor no disponible en ARM by @drowkid01 " 
#msg -bar3
#echo -e "\033[1;32mÎ”  Visita https://t.me/drowkid01_ADM , para detalles " 
#msg -bar3
#read -p "ENTER PARA CONTINUAR"
#exit
#}
msg -bar3
  
  menu_func "Instalar SlowDns" "$(msg -verd "Ver Informacion")" "$(msg -ama "Reiniciar SlowDns")" "$(msg -verm2 "Detener SlowDns")" "$(msg -verm2 "Remover SlowDns")"
  msg -bar3
  echo -ne "$(msg -verd "  [0]") $(msg -verm2 "=>>") " && msg -bra "\033[1;41m Volver "
  msg -bar3
  opcion=$(selection_fun 5)  
  case $opcion in
  1)ini_slow;;
  2)info;;
  3)reset_slow;;
  4)stop_slow;;
  5)remove_slow;;
  0)break;;
  esac  
done

ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
