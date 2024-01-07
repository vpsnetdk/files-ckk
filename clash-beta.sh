#!/bin/sh

clear&&clear
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /bin/ejecutar/trojanports.txt && cat /bin/ejecutar/trojanports.txt`;
troport=$(cat /bin/ejecutar/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
portFTP=$(lsof -V -i tcp -P -n | grep apache2 | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | cut -d: -f2 | cut -d' ' -f1 | uniq)
portFTP=$(echo ${portFTP} | sed 's/\s\+/,/g' | cut -d , -f1)
}
#FUN_BAR
fun_bar () { 
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
echo tput cuu1 tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
} 

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
msg -bar33
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
msg -bar33
#bc
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || apt-get install golang-go -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install golang-go............ $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
msg -bar33
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
msg -bar33
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
echo -ne "\033[97m Deseas agregar Menu Clash Rapido [s/n]: "
read insta
[[ $insta = @(s|S|y|Y) ]] && enttrada
}


fun_insta(){
fun_ip
install_ini
msg -bar33
killall clash 1> /dev/null 2> /dev/null
echo -e " ➣ Creando Directorios y Archivos"
msg -bar33 
[[ -d /root/.config ]] && rm -rf /root/.config/* || mkdir /root/.config 
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
last_version=$(curl -Ls "https://api.github.com/repos/emirjorge/clash-core/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
arch=$(arch)
if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64"
else
  arch="amd64"
fi
wget -N --no-check-certificate -O /root/.config/clash/clash.gz https://github.com/emirjorge/clash-core/releases/download/${last_version}/clash-linux-${arch}-${last_version}.gz
gzip -d /root/.config/clash/clash.gz
chmod +x /root/.config/clash/clash
echo -e " ➣ Clonando Repositorio Original Dreamacro "
go get -u -v github.com/emirjorge/clash-core
clear
}



[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar3/msg)
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')
[[ ! -d /bin/ejecutar/clashFiles ]] && mkdir /bin/ejecutar/clashFiles
clashFiles='/bin/ejecutar/clashFiles/'

INITClash(){
msg -bar3
conFIN
read -p "Ingrese Nombre del Poster WEB de la configuracion: " cocolon
[[ -e /root/.config/clash/config.yaml ]] && sed -i "s%_dAtE%${fecha}%g" /root/.config/clash/config.yaml
[[ -e /root/.config/clash/config.yaml ]] && sed -i "s/_h0rA/${hora}/g" /root/.config/clash/config.yaml
cp /root/.config/clash/config.yaml /var/www/html/$cocolon.yaml && chmod +x /var/www/html/$cocolon.yaml
service apache2 restart
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "-------------------------------------------------------"
echo -e "		\033[4;31mNOTA importante\033[0m"
echo -e "Recuerda Descargar el Fichero, o cargarlo como URL!!"
echo -e "-------------------------------------------------------"
echo -e " \033[0;31mSi Usas Clash For Android, Ultima Version  "
echo -e "  Para luego usar el Link del Fichero, y puedas ."
echo -e " Descargarlo desde cualquier sitio con acceso WEB"
echo -e "        Link Clash Valido por 30 minutos "
echo -e "    Link : \033[1;42m  http://$IP:${portFTP}/$cocolon.yaml\033[0m"
echo -e "-------------------------------------------------------"
#read -p "PRESIONA ENTER PARA CARGAR ONLINE"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
scr=$(echo $(($RANDOM*3))|head -c 3)
unset yesno
echo -e " ENLACE VALIDO POR 30 MINUTOS? " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
killall clash > /dev/null &1>&2
screen -dmS clashse_$cocolon /root/.config/clash/clash
echo '#!/bin/bash -e' > /root/.config/clash/$cocolon.sh
echo "sleep 1800s" >> /root/.config/clash/$cocolon.sh && echo -e " ACTIVO POR 30 MINUTOS "  || echo " Validacion Incorrecta "
echo "mv /var/www/html/$cocolon.yaml ${clashFiles}$cocolon.yaml" >> /root/.config/clash/$cocolon.sh
echo 'echo "Fichero removido a ${clashFiles}$cocolon.yaml"' >> /root/.config/clash/$cocolon.sh
echo "service apache2 restart" >> /root/.config/clash/$cocolon.sh
echo "rm -f /root/.config/clash/$cocolon.sh" >> /root/.config/clash/$cocolon.sh
echo 'exit' >> /root/.config/clash/$cocolon.sh && screen -dmS clash${scr} bash /root/.config/clash/$cocolon.sh
} 
echo -e "Proceso Finalizado"

}

configINIT_rule () {
mode=$1
[[ -z ${mode} ]] && exit
unset tropass
echo '#SCRIPT OFICIAL drowkid01|Plus
# Formato Creado por @drowkid01 | +593987072611 Whatsapp Personal
# Creado el _dAtE - _h0rA
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: rule
log-level: info
external-controller: "0.0.0.0:9090"
secret: ""

dns:
  enable: true
  listen: :53
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 223.5.5.5
    - 8.8.8.8
    - 45.71.185.100
    - 204.199.156.138
    - 1.1.1.1
  fallback: []
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP    
tun:
  enable: true
  stack: gvisor
  auto-route: true
  auto-detect-interface: true
  dns-hijack:
    - any:53

# Clash for Windows
cfw-bypass:
  - qq.com
  - music.163.com
  - "*.music.126.net"
  - localhost
  - 127.*
  - 10.*
  - 172.16.*
  - 172.17.*
  - 172.18.*
  - 172.19.*
  - 172.20.*
  - 172.21.*
  - 172.22.*
  - 172.23.*
  - 172.24.*
  - 172.25.*
  - 172.26.*
  - 172.27.*
  - 172.28.*
  - 172.29.*
  - 172.30.*
  - 172.31.*
  - 192.168.*
  - <local>
cfw-latency-timeout: 5000
    
proxy-groups:
- name: "drowkid01-ADM"
  type: select
  proxies:    ' > /root/.config/clash/config.yaml
#sed -i "s/+/'/g"  /root/.config/clash/config.yaml
foc=1
[[ -e /usr/local/etc/trojan/config.json ]] && ConfTrojINI
unset yesno
foc=1
[[ -e /etc/v2ray/config.json ]] && ConfV2RINI
unset yesno
foc=1								
[[ -e /etc/xray/config.json ]] && ConfXRINI
}

configINIT_global () {
mode=$1
[[ -z ${mode} ]] && exit
unset tropass
echo '#SCRIPT OFICIAL drowkid01|Plus
# Formato Creado por @drowkid01 | +593987072611 Whatsapp Personal
# Creado el _dAtE - _h0rA
port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: global
log-level: info
external-controller: "0.0.0.0:9090"
secret: ""
dns:
  enable: true
  listen: :53
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 223.5.5.5
    - 8.8.8.8
    - 45.71.185.100
    - 204.199.156.138
    - 1.1.1.1
  fallback: []
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP    
tun:
  enable: true
  stack: gvisor
  auto-route: true
  auto-detect-interface: true
  dns-hijack:
    - any:53

# Clash for Windows
cfw-bypass:
  - qq.com
  - music.163.com
  - "*.music.126.net"
  - localhost
  - 127.*
  - 10.*
  - 172.16.*
  - 172.17.*
  - 172.18.*
  - 172.19.*
  - 172.20.*
  - 172.21.*
  - 172.22.*
  - 172.23.*
  - 172.24.*
  - 172.25.*
  - 172.26.*
  - 172.27.*
  - 172.28.*
  - 172.29.*
  - 172.30.*
  - 172.31.*
  - 192.168.*
  - <local>
cfw-latency-timeout: 5000   
 ' > /root/.config/clash/config.yaml
#sed -i "s/+/'/g"  /root/.config/clash/config.yaml
foc=1
[[ -e /usr/local/etc/trojan/config.json ]] && ConfTrojINI
unset yesno
foc=1
[[ -e /etc/v2ray/config.json ]] && ConfV2RINI
unset yesno
foc=1								
[[ -e /etc/xray/config.json ]] && ConfXRINI
}

proxyTRO() {
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proTRO+="- name: $1\n  type: trojan\n  server: ${IP}\n  port: ${troport}\n  password: "$2"\n  udp: true\n  sni: $3\n  alpn:\n  - h2\n  - http/1.1\n  skip-cert-verify: true\n\n" 
  }

ConfTrojINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG TROJAN " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p " [S/N]: " yesno

tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL TROJAN CLASH "
read -p ": " nameperfil
msg -bar33
[[ -z ${UUID} ]] && view_usert || { 
echo -e " USER ${Usr} : ${UUID}"
msg -bar33
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar33
proxyTRO ${nameperfil} ${UUID} ${trosni}
ConfTrojINI
								}
}

proxyV2R() {
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  udp: true\n  tls: true\n  skip-cert-verify: true\n  servername: $2\n  network: $5\n  ws-opts:  \n       path: $6\n       headers:\n         Host: $2\n  \n\n" 
  }
  
proxyV2Rgprc() {
#config=/usr/local/x-ui/bin/config.json
#cat $config | jq .inbounds[].settings.clients | grep id
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="
- name: $1\n  server: ${IP}\n  port: $7\n  type: vmess\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  tls: true\n  skip-cert-verify: true\n  network: grpc\n  servername: $2\n  grpc-opts:\n    grpc-mode: gun\n    grpc-service-name: $6\n  udp: true \n\n"
  }
proxyXR() {
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proXR+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  udp: true\n  tls: true\n  skip-cert-verify: true\n  servername: $2\n  network: $5\n  ws-opts:  \n       path: $6\n       headers:\n         Host: $2\n  \n\n" 
  }
  
proxyXRgprc() {
#config=/usr/local/x-ui/bin/config.json
#cat $config | jq .inbounds[].settings.clients | grep id
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
[[ $mode = 1 ]] && echo -e "    - $1" >> /root/.config/clash/config.yaml
proXR+="
- name: $1\n  server: ${IP}\n  port: $7\n  type: vmess\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  tls: true\n  skip-cert-verify: true\n  network: grpc\n  servername: $2\n  grpc-opts:\n    grpc-mode: gun\n    grpc-service-name: $6\n  udp: true \n\n"
  }

ConfV2RINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG V2RAY " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL V2RAY CLASH "
read -p ": " nameperfil
msg -bar33
[[ -z ${uid} ]] && view_user || { 
echo -e " USER ${ps}"
msg -bar33
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar33

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)

[[ $net = '"grpc"' ]] && {
proxyV2Rgprc ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${path} ${v2port}
} || {
proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
}

ConfV2RINI
	} 
}

ConfXRINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG XRAY " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL XRAY CLASH "
read -p ": " nameperfilX
msg -bar33
[[ -z ${uidX} ]] && _view_userXR || { 
echo -e " USER ${ps} XRAY"
msg -bar33
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosniX
msg -bar33
		psX=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uidX=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiidX=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		addX=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && addX=$(wget -qO- ipv4.icanhazip.com)
		hostX=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		netX=$(jq '.inbounds[].streamSettings.network' $config)
		parcheX=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $pathX = null ]] && parcheX='' 
		v2portX=$(jq '.inbounds[].port' $config)
		tlsX=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $netX = '"grpc"' ]] && pathX=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || pathX=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)

[[ $netX = '"grpc"' ]] && {
proxyXRgprc ${nameperfilX} ${trosniX} ${uidX} ${aluuiidX} ${netX} ${pathX} ${v2portX}
} || {
proxyXR ${nameperfilX} ${trosniX} ${uidX} ${aluuiidX} ${netX} ${parcheX} ${v2portX}
}

ConfXRINI
							}
}

confRULE() {
[[ $mode = 1 ]] && echo -e '
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# drowkid01-ADM

# By drowkid01 By CGH
- name: "【 ✵ 𝚂𝚎𝚛𝚟𝚎𝚛-𝙿𝚁𝙴𝙼𝙸𝚄𝙼 ✵ 】"
  type: select
  proxies: 
    - "drowkid01-ADM"

#- name: "【 📱 +593987072611 】"
#  type: select
#  proxies:
#    - "drowkid01-ADM"

Rule:
# Unbreak
# > Google
- DOMAIN-SUFFIX,googletraveladservices.com,drowkid01-ADM
- DOMAIN,dl.google.com,drowkid01-ADM
- DOMAIN,mtalk.google.com,drowkid01-ADM

# Internet Service Providers drowkid01-ADM 运营商劫持
- DOMAIN-SUFFIX,17gouwuba.com,drowkid01-ADM
- DOMAIN-SUFFIX,186078.com,drowkid01-ADM
- DOMAIN-SUFFIX,189zj.cn,drowkid01-ADM
- DOMAIN-SUFFIX,285680.com,drowkid01-ADM
- DOMAIN-SUFFIX,3721zh.com,drowkid01-ADM
- DOMAIN-SUFFIX,4336wang.cn,drowkid01-ADM
- DOMAIN-SUFFIX,51chumoping.com,drowkid01-ADM
- DOMAIN-SUFFIX,51mld.cn,drowkid01-ADM
- DOMAIN-SUFFIX,51mypc.cn,drowkid01-ADM
- DOMAIN-SUFFIX,58mingri.cn,drowkid01-ADM
- DOMAIN-SUFFIX,58mingtian.cn,drowkid01-ADM
- DOMAIN-SUFFIX,5vl58stm.com,drowkid01-ADM
- DOMAIN-SUFFIX,6d63d3.com,drowkid01-ADM
- DOMAIN-SUFFIX,7gg.cc,drowkid01-ADM
- DOMAIN-SUFFIX,91veg.com,drowkid01-ADM
- DOMAIN-SUFFIX,9s6q.cn,drowkid01-ADM
- DOMAIN-SUFFIX,adsame.com,drowkid01-ADM
- DOMAIN-SUFFIX,aiclk.com,drowkid01-ADM
- DOMAIN-SUFFIX,akuai.top,drowkid01-ADM
- DOMAIN-SUFFIX,atplay.cn,drowkid01-ADM
- DOMAIN-SUFFIX,baiwanchuangyi.com,drowkid01-ADM
- DOMAIN-SUFFIX,beerto.cn,drowkid01-ADM
- DOMAIN-SUFFIX,beilamusi.com,drowkid01-ADM
- DOMAIN-SUFFIX,benshiw.net,drowkid01-ADM
- DOMAIN-SUFFIX,bianxianmao.com,drowkid01-ADM
- DOMAIN-SUFFIX,bryonypie.com,drowkid01-ADM
- DOMAIN-SUFFIX,cishantao.com,drowkid01-ADM
- DOMAIN-SUFFIX,cszlks.com,drowkid01-ADM
- DOMAIN-SUFFIX,cudaojia.com,drowkid01-ADM
- DOMAIN-SUFFIX,dafapromo.com,drowkid01-ADM
- DOMAIN-SUFFIX,daitdai.com,drowkid01-ADM
- DOMAIN-SUFFIX,dsaeerf.com,drowkid01-ADM
- DOMAIN-SUFFIX,dugesheying.com,drowkid01-ADM
- DOMAIN-SUFFIX,dv8c1t.cn,drowkid01-ADM
- DOMAIN-SUFFIX,echatu.com,drowkid01-ADM
- DOMAIN-SUFFIX,erdoscs.com,drowkid01-ADM
- DOMAIN-SUFFIX,fan-yong.com,drowkid01-ADM
- DOMAIN-SUFFIX,feih.com.cn,drowkid01-ADM
- DOMAIN-SUFFIX,fjlqqc.com,drowkid01-ADM
- DOMAIN-SUFFIX,fkku194.com,drowkid01-ADM
- DOMAIN-SUFFIX,freedrive.cn,drowkid01-ADM
- DOMAIN-SUFFIX,gclick.cn,drowkid01-ADM
- DOMAIN-SUFFIX,goufanli100.com,drowkid01-ADM
- DOMAIN-SUFFIX,goupaoerdai.com,drowkid01-ADM
- DOMAIN-SUFFIX,gouwubang.com,drowkid01-ADM
- DOMAIN-SUFFIX,gzxnlk.com,drowkid01-ADM
- DOMAIN-SUFFIX,haoshengtoys.com,drowkid01-ADM
- DOMAIN-SUFFIX,hyunke.com,drowkid01-ADM
- DOMAIN-SUFFIX,ichaosheng.com,drowkid01-ADM
- DOMAIN-SUFFIX,ishop789.com,drowkid01-ADM
- DOMAIN-SUFFIX,jdkic.com,drowkid01-ADM
- DOMAIN-SUFFIX,jiubuhua.com,drowkid01-ADM
- DOMAIN-SUFFIX,jsncke.com,drowkid01-ADM
- DOMAIN-SUFFIX,junkucm.com,drowkid01-ADM
- DOMAIN-SUFFIX,jwg365.cn,drowkid01-ADM
- DOMAIN-SUFFIX,kawo77.com,drowkid01-ADM
- DOMAIN-SUFFIX,kualianyingxiao.cn,drowkid01-ADM
- DOMAIN-SUFFIX,kumihua.com,drowkid01-ADM
- DOMAIN-SUFFIX,ltheanine.cn,drowkid01-ADM
- DOMAIN-SUFFIX,maipinshangmao.com,drowkid01-ADM
- DOMAIN-SUFFIX,minisplat.cn,drowkid01-ADM
- DOMAIN-SUFFIX,mkitgfs.com,drowkid01-ADM
- DOMAIN-SUFFIX,mlnbike.com,drowkid01-ADM
- DOMAIN-SUFFIX,mobjump.com,drowkid01-ADM
- DOMAIN-SUFFIX,nbkbgd.cn,drowkid01-ADM
- DOMAIN-SUFFIX,newapi.com,drowkid01-ADM
- DOMAIN-SUFFIX,pinzhitmall.com,drowkid01-ADM
- DOMAIN-SUFFIX,poppyta.com,drowkid01-ADM
- DOMAIN-SUFFIX,qianchuanghr.com,drowkid01-ADM
- DOMAIN-SUFFIX,qichexin.com,drowkid01-ADM
- DOMAIN-SUFFIX,qinchugudao.com,drowkid01-ADM
- DOMAIN-SUFFIX,quanliyouxi.cn,drowkid01-ADM
- DOMAIN-SUFFIX,qutaobi.com,drowkid01-ADM
- DOMAIN-SUFFIX,ry51w.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sg536.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifubo.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuce.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuda.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifufu.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuge.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifugu.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuhe.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuhu.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuji.cn,drowkid01-ADM
- DOMAIN-SUFFIX,sifuka.cn,drowkid01-ADM
- DOMAIN-SUFFIX,smgru.net,drowkid01-ADM
- DOMAIN-SUFFIX,taoggou.com,drowkid01-ADM
- DOMAIN-SUFFIX,tcxshop.com,drowkid01-ADM
- DOMAIN-SUFFIX,tjqonline.cn,drowkid01-ADM
- DOMAIN-SUFFIX,topitme.com,drowkid01-ADM
- DOMAIN-SUFFIX,tt3sm4.cn,drowkid01-ADM
- DOMAIN-SUFFIX,tuia.cn,drowkid01-ADM
- DOMAIN-SUFFIX,tuipenguin.com,drowkid01-ADM
- DOMAIN-SUFFIX,tuitiger.com,drowkid01-ADM
- DOMAIN-SUFFIX,websd8.com,drowkid01-ADM
- DOMAIN-SUFFIX,wsgblw.com,drowkid01-ADM
- DOMAIN-SUFFIX,wx16999.com,drowkid01-ADM
- DOMAIN-SUFFIX,xchmai.com,drowkid01-ADM
- DOMAIN-SUFFIX,xiaohuau.xyz,drowkid01-ADM
- DOMAIN-SUFFIX,ygyzx.cn,drowkid01-ADM
- DOMAIN-SUFFIX,yinmong.com,drowkid01-ADM
- DOMAIN-SUFFIX,yitaopt.com,drowkid01-ADM
- DOMAIN-SUFFIX,yjqiqi.com,drowkid01-ADM
- DOMAIN-SUFFIX,yukhj.com,drowkid01-ADM
- DOMAIN-SUFFIX,zhaozecheng.cn,drowkid01-ADM
- DOMAIN-SUFFIX,zhenxinet.com,drowkid01-ADM
- DOMAIN-SUFFIX,zlne800.com,drowkid01-ADM
- DOMAIN-SUFFIX,zunmi.cn,drowkid01-ADM
- DOMAIN-SUFFIX,zzd6.com,drowkid01-ADM
- IP-CIDR,39.107.15.115/32,drowkid01-ADM,no-resolve
- IP-CIDR,47.89.59.182/32,drowkid01-ADM,no-resolve
- IP-CIDR,103.49.209.27/32,drowkid01-ADM,no-resolve
- IP-CIDR,123.56.152.96/32,drowkid01-ADM,no-resolve
# > ChinaTelecom
- IP-CIDR,61.160.200.223/32,drowkid01-ADM,no-resolve
- IP-CIDR,61.160.200.242/32,drowkid01-ADM,no-resolve
- IP-CIDR,61.160.200.252/32,drowkid01-ADM,no-resolve
- IP-CIDR,61.174.50.214/32,drowkid01-ADM,no-resolve
- IP-CIDR,111.175.220.163/32,drowkid01-ADM,no-resolve
- IP-CIDR,111.175.220.164/32,drowkid01-ADM,no-resolve
- IP-CIDR,122.229.8.47/32,drowkid01-ADM,no-resolve
- IP-CIDR,122.229.29.89/32,drowkid01-ADM,no-resolve
- IP-CIDR,124.232.160.178/32,drowkid01-ADM,no-resolve
- IP-CIDR,175.6.223.15/32,drowkid01-ADM,no-resolve
- IP-CIDR,183.59.53.237/32,drowkid01-ADM,no-resolve
- IP-CIDR,218.93.127.37/32,drowkid01-ADM,no-resolve
- IP-CIDR,221.228.17.152/32,drowkid01-ADM,no-resolve
- IP-CIDR,221.231.6.79/32,drowkid01-ADM,no-resolve
- IP-CIDR,222.186.61.91/32,drowkid01-ADM,no-resolve
- IP-CIDR,222.186.61.95/32,drowkid01-ADM,no-resolve
- IP-CIDR,222.186.61.96/32,drowkid01-ADM,no-resolve
- IP-CIDR,222.186.61.97/32,drowkid01-ADM,no-resolve
# > ChinaUnicom
- IP-CIDR,106.75.231.48/32,drowkid01-ADM,no-resolve
- IP-CIDR,119.4.249.166/32,drowkid01-ADM,no-resolve
- IP-CIDR,220.196.52.141/32,drowkid01-ADM,no-resolve
- IP-CIDR,221.6.4.148/32,drowkid01-ADM,no-resolve
# > ChinaMobile
- IP-CIDR,114.247.28.96/32,drowkid01-ADM,no-resolve
- IP-CIDR,221.179.131.72/32,drowkid01-ADM,no-resolve
- IP-CIDR,221.179.140.145/32,drowkid01-ADM,no-resolve
# > Dr.Peng
# - IP-CIDR,10.72.25.0/24,drowkid01-ADM,no-resolve
- IP-CIDR,115.182.16.79/32,drowkid01-ADM,no-resolve
- IP-CIDR,118.144.88.126/32,drowkid01-ADM,no-resolve
- IP-CIDR,118.144.88.215/32,drowkid01-ADM,no-resolve
- IP-CIDR,118.144.88.216/32,drowkid01-ADM,no-resolve
- IP-CIDR,120.76.189.132/32,drowkid01-ADM,no-resolve
- IP-CIDR,124.14.21.147/32,drowkid01-ADM,no-resolve
- IP-CIDR,124.14.21.151/32,drowkid01-ADM,no-resolve
- IP-CIDR,180.166.52.24/32,drowkid01-ADM,no-resolve
- IP-CIDR,211.161.101.106/32,drowkid01-ADM,no-resolve
- IP-CIDR,220.115.251.25/32,drowkid01-ADM,no-resolve
- IP-CIDR,222.73.156.235/32,drowkid01-ADM,no-resolve

# Malware 恶意网站
# > 快压
# https://zhuanlan.zhihu.com/p/39534279
- DOMAIN-SUFFIX,kuaizip.com,drowkid01-ADM
# > MacKeeper
# https://www.lizhi.io/blog/40002904
- DOMAIN-SUFFIX,mackeeper.com,drowkid01-ADM
- DOMAIN-SUFFIX,zryydi.com,drowkid01-ADM
# > Adobe Flash China Special Edition
# https://www.zhihu.com/question/281163698/answer/441388130
- DOMAIN-SUFFIX,flash.cn,drowkid01-ADM
- DOMAIN,geo2.adobe.com,drowkid01-ADM
# > C&J Marketing 思杰马克丁软件
# https://www.zhihu.com/question/46746200
- DOMAIN-SUFFIX,4009997658.com,drowkid01-ADM
- DOMAIN-SUFFIX,abbyychina.com,drowkid01-ADM
- DOMAIN-SUFFIX,bartender.cc,drowkid01-ADM
- DOMAIN-SUFFIX,betterzip.net,drowkid01-ADM
- DOMAIN-SUFFIX,betterzipcn.com,drowkid01-ADM
- DOMAIN-SUFFIX,beyondcompare.cc,drowkid01-ADM
- DOMAIN-SUFFIX,bingdianhuanyuan.cn,drowkid01-ADM
- DOMAIN-SUFFIX,chemdraw.com.cn,drowkid01-ADM
- DOMAIN-SUFFIX,cjmakeding.com,drowkid01-ADM
- DOMAIN-SUFFIX,cjmkt.com,drowkid01-ADM
- DOMAIN-SUFFIX,codesoftchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,coreldrawchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,crossoverchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,dongmansoft.com,drowkid01-ADM
- DOMAIN-SUFFIX,earmasterchina.cn,drowkid01-ADM
- DOMAIN-SUFFIX,easyrecoverychina.com,drowkid01-ADM
- DOMAIN-SUFFIX,ediuschina.com,drowkid01-ADM
- DOMAIN-SUFFIX,flstudiochina.com,drowkid01-ADM
- DOMAIN-SUFFIX,formysql.com,drowkid01-ADM
- DOMAIN-SUFFIX,guitarpro.cc,drowkid01-ADM
- DOMAIN-SUFFIX,huishenghuiying.com.cn,drowkid01-ADM
- DOMAIN-SUFFIX,hypersnap.net,drowkid01-ADM
- DOMAIN-SUFFIX,iconworkshop.cn,drowkid01-ADM
- DOMAIN-SUFFIX,imindmap.cc,drowkid01-ADM
- DOMAIN-SUFFIX,jihehuaban.com.cn,drowkid01-ADM
- DOMAIN-SUFFIX,keyshot.cc,drowkid01-ADM
- DOMAIN-SUFFIX,kingdeecn.cn,drowkid01-ADM
- DOMAIN-SUFFIX,logoshejishi.com,drowkid01-ADM
- DOMAIN-SUFFIX,luping.net.cn,drowkid01-ADM
- DOMAIN-SUFFIX,mairuan.cn,drowkid01-ADM
- DOMAIN-SUFFIX,mairuan.com,drowkid01-ADM
- DOMAIN-SUFFIX,mairuan.com.cn,drowkid01-ADM
- DOMAIN-SUFFIX,mairuan.net,drowkid01-ADM
- DOMAIN-SUFFIX,mairuanwang.com,drowkid01-ADM
- DOMAIN-SUFFIX,makeding.com,drowkid01-ADM
- DOMAIN-SUFFIX,mathtype.cn,drowkid01-ADM
- DOMAIN-SUFFIX,mindmanager.cc,drowkid01-ADM
- DOMAIN-SUFFIX,mindmanager.cn,drowkid01-ADM
- DOMAIN-SUFFIX,mindmapper.cc,drowkid01-ADM
- DOMAIN-SUFFIX,mycleanmymac.com,drowkid01-ADM
- DOMAIN-SUFFIX,nicelabel.cc,drowkid01-ADM
- DOMAIN-SUFFIX,ntfsformac.cc,drowkid01-ADM
- DOMAIN-SUFFIX,ntfsformac.cn,drowkid01-ADM
- DOMAIN-SUFFIX,overturechina.com,drowkid01-ADM
- DOMAIN-SUFFIX,passwordrecovery.cn,drowkid01-ADM
- DOMAIN-SUFFIX,pdfexpert.cc,drowkid01-ADM
- DOMAIN-SUFFIX,photozoomchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,shankejingling.com,drowkid01-ADM
- DOMAIN-SUFFIX,ultraiso.net,drowkid01-ADM
- DOMAIN-SUFFIX,vegaschina.cn,drowkid01-ADM
- DOMAIN-SUFFIX,xmindchina.net,drowkid01-ADM
- DOMAIN-SUFFIX,xshellcn.com,drowkid01-ADM
- DOMAIN-SUFFIX,yihuifu.cn,drowkid01-ADM
- DOMAIN-SUFFIX,yuanchengxiezuo.com,drowkid01-ADM
- DOMAIN-SUFFIX,zbrushcn.com,drowkid01-ADM
- DOMAIN-SUFFIX,zhzzx.com,drowkid01-ADM

# Global Area Network
# (drowkid01-ADM)
# (Music)
# > Deezer
# USER-AGENT,Deezer*,drowkid01-ADM
- DOMAIN-SUFFIX,deezer.com,drowkid01-ADM
- DOMAIN-SUFFIX,dzcdn.net,drowkid01-ADM
# > KKBOX
- DOMAIN-SUFFIX,kkbox.com,drowkid01-ADM
- DOMAIN-SUFFIX,kkbox.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,kfs.io,drowkid01-ADM
# > JOOX
# USER-AGENT,WeMusic*,drowkid01-ADM
# USER-AGENT,JOOX*,drowkid01-ADM
- DOMAIN-SUFFIX,joox.com,drowkid01-ADM
# > Pandora
# USER-AGENT,Pandora*,drowkid01-ADM
- DOMAIN-SUFFIX,pandora.com,drowkid01-ADM
# > SoundCloud
# USER-AGENT,SoundCloud*,drowkid01-ADM
- DOMAIN-SUFFIX,p-cdn.us,drowkid01-ADM
- DOMAIN-SUFFIX,sndcdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,soundcloud.com,drowkid01-ADM
# > Spotify
# USER-AGENT,Spotify*,drowkid01-ADM
- DOMAIN-SUFFIX,pscdn.co,drowkid01-ADM
- DOMAIN-SUFFIX,scdn.co,drowkid01-ADM
- DOMAIN-SUFFIX,spotify.com,drowkid01-ADM
- DOMAIN-SUFFIX,spoti.fi,drowkid01-ADM
- DOMAIN-KEYWORD,spotify.com,drowkid01-ADM
- DOMAIN-KEYWORD,-spotify-com,drowkid01-ADM
# > TIDAL
# USER-AGENT,TIDAL*,drowkid01-ADM
- DOMAIN-SUFFIX,tidal.com,drowkid01-ADM
# > YouTubeMusic
# USER-AGENT,com.google.ios.youtubemusic*,drowkid01-ADM
# USER-AGENT,YouTubeMusic*,drowkid01-ADM
# (Video)
# > All4
# USER-AGENT,All4*,drowkid01-ADM
- DOMAIN-SUFFIX,c4assets.com,drowkid01-ADM
- DOMAIN-SUFFIX,channel4.com,drowkid01-ADM
# > AbemaTV
# USER-AGENT,AbemaTV*,drowkid01-ADM
- DOMAIN-SUFFIX,abema.io,drowkid01-ADM
- DOMAIN-SUFFIX,ameba.jp,drowkid01-ADM
- DOMAIN-SUFFIX,abema.tv,drowkid01-ADM
- DOMAIN-SUFFIX,hayabusa.io,drowkid01-ADM
- DOMAIN,abematv.akamaized.net,drowkid01-ADM
- DOMAIN,ds-linear-abematv.akamaized.net,drowkid01-ADM
- DOMAIN,ds-vod-abematv.akamaized.net,drowkid01-ADM
- DOMAIN,linear-abematv.akamaized.net,drowkid01-ADM
# > Amazon Prime Video
# USER-AGENT,InstantVideo.US*,drowkid01-ADM
# USER-AGENT,Prime%20Video*,drowkid01-ADM
- DOMAIN-SUFFIX,aiv-cdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,aiv-delivery.net,drowkid01-ADM
- DOMAIN-SUFFIX,amazonvideo.com,drowkid01-ADM
- DOMAIN-SUFFIX,primevideo.com,drowkid01-ADM
- DOMAIN,avodmp4s3ww-a.akamaihd.net,drowkid01-ADM
- DOMAIN,d25xi40x97liuc.cloudfront.net,drowkid01-ADM
- DOMAIN,dmqdd6hw24ucf.cloudfront.net,drowkid01-ADM
- DOMAIN,d22qjgkvxw22r6.cloudfront.net,drowkid01-ADM
- DOMAIN,d1v5ir2lpwr8os.cloudfront.net,drowkid01-ADM
- DOMAIN-KEYWORD,avoddashs,drowkid01-ADM
# > Bahamut
# USER-AGENT,Anime*,drowkid01-ADM
- DOMAIN-SUFFIX,bahamut.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,gamer.com.tw,drowkid01-ADM
- DOMAIN,gamer-cds.cdn.hinet.net,drowkid01-ADM
- DOMAIN,gamer2-cds.cdn.hinet.net,drowkid01-ADM
# > BBC iPlayer
# USER-AGENT,BBCiPlayer*,drowkid01-ADM
- DOMAIN-SUFFIX,bbc.co.uk,drowkid01-ADM
- DOMAIN-SUFFIX,bbci.co.uk,drowkid01-ADM
- DOMAIN-KEYWORD,bbcfmt,drowkid01-ADM
- DOMAIN-KEYWORD,uk-live,drowkid01-ADM
# > DAZN
# USER-AGENT,DAZN*,drowkid01-ADM
- DOMAIN-SUFFIX,dazn.com,drowkid01-ADM
- DOMAIN-SUFFIX,dazn-api.com,drowkid01-ADM
- DOMAIN,d151l6v8er5bdm.cloudfront.net,drowkid01-ADM
- DOMAIN-KEYWORD,voddazn,drowkid01-ADM
# > Disney+
# USER-AGENT,Disney+*,drowkid01-ADM
- DOMAIN-SUFFIX,bamgrid.com,drowkid01-ADM
- DOMAIN-SUFFIX,disney-plus.net,drowkid01-ADM
- DOMAIN-SUFFIX,disneyplus.com,drowkid01-ADM
- DOMAIN-SUFFIX,dssott.com,drowkid01-ADM
- DOMAIN,cdn.registerdisney.go.com,drowkid01-ADM
# > encoreTVB
# USER-AGENT,encoreTVB*,drowkid01-ADM
- DOMAIN-SUFFIX,encoretvb.com,drowkid01-ADM
- DOMAIN,edge.api.brightcove.com,drowkid01-ADM
- DOMAIN,bcbolt446c5271-a.akamaihd.net,drowkid01-ADM
# > FOX NOW
# USER-AGENT,FOX%20NOW*,drowkid01-ADM
- DOMAIN-SUFFIX,fox.com,drowkid01-ADM
- DOMAIN-SUFFIX,foxdcg.com,drowkid01-ADM
- DOMAIN-SUFFIX,theplatform.com,drowkid01-ADM
- DOMAIN-SUFFIX,uplynk.com,drowkid01-ADM
# > HBO NOW
# USER-AGENT,HBO%20NOW*,drowkid01-ADM
- DOMAIN-SUFFIX,hbo.com,drowkid01-ADM
- DOMAIN-SUFFIX,hbogo.com,drowkid01-ADM
- DOMAIN-SUFFIX,hbonow.com,drowkid01-ADM
# > HBO GO HKG
# USER-AGENT,HBO%20GO%20PROD%20HKG*,drowkid01-ADM
- DOMAIN-SUFFIX,hbogoasia.com,drowkid01-ADM
- DOMAIN-SUFFIX,hbogoasia.hk,drowkid01-ADM
- DOMAIN,bcbolthboa-a.akamaihd.net,drowkid01-ADM
- DOMAIN,players.brightcove.net,drowkid01-ADM
- DOMAIN,s3-ap-southeast-1.amazonaws.com,drowkid01-ADM
- DOMAIN,dai3fd1oh325y.cloudfront.net,drowkid01-ADM
- DOMAIN,44wilhpljf.execute-api.ap-southeast-1.amazonaws.com,drowkid01-ADM
- DOMAIN,hboasia1-i.akamaihd.net,drowkid01-ADM
- DOMAIN,hboasia2-i.akamaihd.net,drowkid01-ADM
- DOMAIN,hboasia3-i.akamaihd.net,drowkid01-ADM
- DOMAIN,hboasia4-i.akamaihd.net,drowkid01-ADM
- DOMAIN,hboasia5-i.akamaihd.net,drowkid01-ADM
- DOMAIN,cf-images.ap-southeast-1.prod.boltdns.net,drowkid01-ADM
# > 华文电视
# USER-AGENT,HWTVMobile*,drowkid01-ADM
- DOMAIN-SUFFIX,5itv.tv,drowkid01-ADM
- DOMAIN-SUFFIX,ocnttv.com,drowkid01-ADM
# > Hulu
- DOMAIN-SUFFIX,hulu.com,drowkid01-ADM
- DOMAIN-SUFFIX,huluim.com,drowkid01-ADM
- DOMAIN-SUFFIX,hulustream.com,drowkid01-ADM
# > Hulu(フールー)
- DOMAIN-SUFFIX,happyon.jp,drowkid01-ADM
- DOMAIN-SUFFIX,hulu.jp,drowkid01-ADM
# > ITV
# USER-AGENT,ITV_Player*,drowkid01-ADM
- DOMAIN-SUFFIX,itv.com,drowkid01-ADM
- DOMAIN-SUFFIX,itvstatic.com,drowkid01-ADM
- DOMAIN,itvpnpmobile-a.akamaihd.net,drowkid01-ADM
# > KKTV
# USER-AGENT,KKTV*,drowkid01-ADM
# USER-AGENT,com.kktv.ios.kktv*,drowkid01-ADM
- DOMAIN-SUFFIX,kktv.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,kktv.me,drowkid01-ADM
- DOMAIN,kktv-theater.kk.stream,drowkid01-ADM
# > Line TV
# USER-AGENT,LINE%20TV*,drowkid01-ADM
- DOMAIN-SUFFIX,linetv.tw,drowkid01-ADM
- DOMAIN,d3c7rimkq79yfu.cloudfront.net,drowkid01-ADM
# > LiTV
- DOMAIN-SUFFIX,litv.tv,drowkid01-ADM
- DOMAIN,litvfreemobile-hichannel.cdn.hinet.net,drowkid01-ADM
# > My5
# USER-AGENT,My5*,drowkid01-ADM
- DOMAIN-SUFFIX,channel5.com,drowkid01-ADM
- DOMAIN-SUFFIX,my5.tv,drowkid01-ADM
- DOMAIN,d349g9zuie06uo.cloudfront.net,drowkid01-ADM
# > myTV SUPER
# USER-AGENT,mytv*,drowkid01-ADM
- DOMAIN-SUFFIX,mytvsuper.com,drowkid01-ADM
- DOMAIN-SUFFIX,tvb.com,drowkid01-ADM
# > Netflix
# USER-AGENT,Argo*,drowkid01-ADM
- DOMAIN-SUFFIX,netflix.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflix.net,drowkid01-ADM
- DOMAIN-SUFFIX,nflxext.com,drowkid01-ADM
- DOMAIN-SUFFIX,nflximg.com,drowkid01-ADM
- DOMAIN-SUFFIX,nflximg.net,drowkid01-ADM
- DOMAIN-SUFFIX,nflxso.net,drowkid01-ADM
- DOMAIN-SUFFIX,nflxvideo.net,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest0.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest1.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest2.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest3.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest4.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest5.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest6.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest7.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest8.com,drowkid01-ADM
- DOMAIN-SUFFIX,netflixdnstest9.com,drowkid01-ADM
- IP-CIDR,23.246.0.0/18,drowkid01-ADM,no-resolve
- IP-CIDR,37.77.184.0/21,drowkid01-ADM,no-resolve
- IP-CIDR,45.57.0.0/17,drowkid01-ADM,no-resolve
- IP-CIDR,64.120.128.0/17,drowkid01-ADM,no-resolve
- IP-CIDR,66.197.128.0/17,drowkid01-ADM,no-resolve
- IP-CIDR,108.175.32.0/20,drowkid01-ADM,no-resolve
- IP-CIDR,192.173.64.0/18,drowkid01-ADM,no-resolve
- IP-CIDR,198.38.96.0/19,drowkid01-ADM,no-resolve
- IP-CIDR,198.45.48.0/20,drowkid01-ADM,no-resolve
# > niconico
# USER-AGENT,Niconico*,drowkid01-ADM
- DOMAIN-SUFFIX,dmc.nico,drowkid01-ADM
- DOMAIN-SUFFIX,nicovideo.jp,drowkid01-ADM
- DOMAIN-SUFFIX,nimg.jp,drowkid01-ADM
- DOMAIN-SUFFIX,socdm.com,drowkid01-ADM
# > PBS
# USER-AGENT,PBS*,drowkid01-ADM
- DOMAIN-SUFFIX,pbs.org,drowkid01-ADM
# > Pornhub
- DOMAIN-SUFFIX,phncdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,pornhub.com,drowkid01-ADM
- DOMAIN-SUFFIX,pornhubpremium.com,drowkid01-ADM
# > 台湾好
# USER-AGENT,TaiwanGood*,drowkid01-ADM
- DOMAIN-SUFFIX,skyking.com.tw,drowkid01-ADM
- DOMAIN,hamifans.emome.net,drowkid01-ADM
# > Twitch
- DOMAIN-SUFFIX,twitch.tv,drowkid01-ADM
- DOMAIN-SUFFIX,twitchcdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,ttvnw.net,drowkid01-ADM
- DOMAIN-SUFFIX,jtvnw.net,drowkid01-ADM
# > ViuTV
# USER-AGENT,Viu*,drowkid01-ADM
# USER-AGENT,ViuTV*,drowkid01-ADM
- DOMAIN-SUFFIX,viu.com,drowkid01-ADM
- DOMAIN-SUFFIX,viu.tv,drowkid01-ADM
- DOMAIN,api.viu.now.com,drowkid01-ADM
- DOMAIN,d1k2us671qcoau.cloudfront.net,drowkid01-ADM
- DOMAIN,d2anahhhmp1ffz.cloudfront.net,drowkid01-ADM
- DOMAIN,dfp6rglgjqszk.cloudfront.net,drowkid01-ADM
# > YouTube
# USER-AGENT,com.google.ios.youtube*,drowkid01-ADM
# USER-AGENT,YouTube*,drowkid01-ADM
- DOMAIN-SUFFIX,googlevideo.com,drowkid01-ADM
- DOMAIN-SUFFIX,youtube.com,drowkid01-ADM
- DOMAIN,youtubei.googleapis.com,drowkid01-ADM

# (drowkid01-ADM)
# > 愛奇藝台灣站
- DOMAIN,cache.video.iqiyi.com,drowkid01-ADM
# > bilibili
- DOMAIN-SUFFIX,bilibili.com,drowkid01-ADM
- DOMAIN,upos-hz-mirrorakam.akamaized.net,drowkid01-ADM

# (DNS Cache Pollution Protection)
# > Google
- DOMAIN-SUFFIX,ampproject.org,drowkid01-ADM
- DOMAIN-SUFFIX,appspot.com,drowkid01-ADM
- DOMAIN-SUFFIX,blogger.com,drowkid01-ADM
- DOMAIN-SUFFIX,getoutline.org,drowkid01-ADM
- DOMAIN-SUFFIX,gvt0.com,drowkid01-ADM
- DOMAIN-SUFFIX,gvt1.com,drowkid01-ADM
- DOMAIN-SUFFIX,gvt3.com,drowkid01-ADM
- DOMAIN-SUFFIX,xn--ngstr-lra8j.com,drowkid01-ADM
- DOMAIN-KEYWORD,google,drowkid01-ADM
- DOMAIN-KEYWORD,blogspot,drowkid01-ADM
# > Microsoft
- DOMAIN-SUFFIX,onedrive.live.com,drowkid01-ADM
- DOMAIN-SUFFIX,xboxlive.com,drowkid01-ADM
# > Facebook
- DOMAIN-SUFFIX,cdninstagram.com,drowkid01-ADM
- DOMAIN-SUFFIX,fb.com,drowkid01-ADM
- DOMAIN-SUFFIX,fb.me,drowkid01-ADM
- DOMAIN-SUFFIX,fbaddins.com,drowkid01-ADM
- DOMAIN-SUFFIX,fbcdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,fbsbx.com,drowkid01-ADM
- DOMAIN-SUFFIX,fbworkmail.com,drowkid01-ADM
- DOMAIN-SUFFIX,instagram.com,drowkid01-ADM
- DOMAIN-SUFFIX,m.me,drowkid01-ADM
- DOMAIN-SUFFIX,messenger.com,drowkid01-ADM
- DOMAIN-SUFFIX,oculus.com,drowkid01-ADM
- DOMAIN-SUFFIX,oculuscdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,rocksdb.org,drowkid01-ADM
- DOMAIN-SUFFIX,whatsapp.com,drowkid01-ADM
- DOMAIN-SUFFIX,whatsapp.net,drowkid01-ADM
- DOMAIN-KEYWORD,facebook,drowkid01-ADM
- IP-CIDR,3.123.36.126/32,drowkid01-ADM,no-resolve
- IP-CIDR,35.157.215.84/32,drowkid01-ADM,no-resolve
- IP-CIDR,35.157.217.255/32,drowkid01-ADM,no-resolve
- IP-CIDR,52.58.209.134/32,drowkid01-ADM,no-resolve
- IP-CIDR,54.93.124.31/32,drowkid01-ADM,no-resolve
- IP-CIDR,54.162.243.80/32,drowkid01-ADM,no-resolve
- IP-CIDR,54.173.34.141/32,drowkid01-ADM,no-resolve
- IP-CIDR,54.235.23.242/32,drowkid01-ADM,no-resolve
- IP-CIDR,169.45.248.118/32,drowkid01-ADM,no-resolve
# > Twitter
- DOMAIN-SUFFIX,pscp.tv,drowkid01-ADM
- DOMAIN-SUFFIX,periscope.tv,drowkid01-ADM
- DOMAIN-SUFFIX,t.co,drowkid01-ADM
- DOMAIN-SUFFIX,twimg.co,drowkid01-ADM
- DOMAIN-SUFFIX,twimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,twitpic.com,drowkid01-ADM
- DOMAIN-SUFFIX,vine.co,drowkid01-ADM
- DOMAIN-KEYWORD,twitter,drowkid01-ADM
# > Telegram
- DOMAIN-SUFFIX,t.me,drowkid01-ADM
- DOMAIN-SUFFIX,tdesktop.com,drowkid01-ADM
- DOMAIN-SUFFIX,telegra.ph,drowkid01-ADM
- DOMAIN-SUFFIX,telegram.me,drowkid01-ADM
- DOMAIN-SUFFIX,telegram.org,drowkid01-ADM
- IP-CIDR,91.108.4.0/22,drowkid01-ADM,no-resolve
- IP-CIDR,91.108.8.0/22,drowkid01-ADM,no-resolve
- IP-CIDR,91.108.12.0/22,drowkid01-ADM,no-resolve
- IP-CIDR,91.108.16.0/22,drowkid01-ADM,no-resolve
- IP-CIDR,91.108.56.0/22,drowkid01-ADM,no-resolve
- IP-CIDR,149.154.160.0/20,drowkid01-ADM,no-resolve
# > Line
- DOMAIN-SUFFIX,line.me,drowkid01-ADM
- DOMAIN-SUFFIX,line-apps.com,drowkid01-ADM
- DOMAIN-SUFFIX,line-scdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,naver.jp,drowkid01-ADM
- IP-CIDR,103.2.30.0/23,drowkid01-ADM,no-resolve
- IP-CIDR,125.209.208.0/20,drowkid01-ADM,no-resolve
- IP-CIDR,147.92.128.0/17,drowkid01-ADM,no-resolve
- IP-CIDR,203.104.144.0/21,drowkid01-ADM,no-resolve
# > Other
- DOMAIN-SUFFIX,4shared.com,drowkid01-ADM
- DOMAIN-SUFFIX,520cc.cc,drowkid01-ADM
- DOMAIN-SUFFIX,881903.com,drowkid01-ADM
- DOMAIN-SUFFIX,9cache.com,drowkid01-ADM
- DOMAIN-SUFFIX,9gag.com,drowkid01-ADM
- DOMAIN-SUFFIX,abc.com,drowkid01-ADM
- DOMAIN-SUFFIX,abc.net.au,drowkid01-ADM
- DOMAIN-SUFFIX,abebooks.com,drowkid01-ADM
- DOMAIN-SUFFIX,amazon.co.jp,drowkid01-ADM
- DOMAIN-SUFFIX,apigee.com,drowkid01-ADM
- DOMAIN-SUFFIX,apk-dl.com,drowkid01-ADM
- DOMAIN-SUFFIX,apkfind.com,drowkid01-ADM
- DOMAIN-SUFFIX,apkmirror.com,drowkid01-ADM
- DOMAIN-SUFFIX,apkmonk.com,drowkid01-ADM
- DOMAIN-SUFFIX,apkpure.com,drowkid01-ADM
- DOMAIN-SUFFIX,aptoide.com,drowkid01-ADM
- DOMAIN-SUFFIX,archive.is,drowkid01-ADM
- DOMAIN-SUFFIX,archive.org,drowkid01-ADM
- DOMAIN-SUFFIX,arte.tv,drowkid01-ADM
- DOMAIN-SUFFIX,artstation.com,drowkid01-ADM
- DOMAIN-SUFFIX,arukas.io,drowkid01-ADM
- DOMAIN-SUFFIX,ask.com,drowkid01-ADM
- DOMAIN-SUFFIX,avg.com,drowkid01-ADM
- DOMAIN-SUFFIX,avgle.com,drowkid01-ADM
- DOMAIN-SUFFIX,badoo.com,drowkid01-ADM
- DOMAIN-SUFFIX,bandwagonhost.com,drowkid01-ADM
- DOMAIN-SUFFIX,bbc.com,drowkid01-ADM
- DOMAIN-SUFFIX,behance.net,drowkid01-ADM
- DOMAIN-SUFFIX,bibox.com,drowkid01-ADM
- DOMAIN-SUFFIX,biggo.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,binance.com,drowkid01-ADM
- DOMAIN-SUFFIX,bitcointalk.org,drowkid01-ADM
- DOMAIN-SUFFIX,bitfinex.com,drowkid01-ADM
- DOMAIN-SUFFIX,bitmex.com,drowkid01-ADM
- DOMAIN-SUFFIX,bit-z.com,drowkid01-ADM
- DOMAIN-SUFFIX,bloglovin.com,drowkid01-ADM
- DOMAIN-SUFFIX,bloomberg.cn,drowkid01-ADM
- DOMAIN-SUFFIX,bloomberg.com,drowkid01-ADM
- DOMAIN-SUFFIX,blubrry.com,drowkid01-ADM
- DOMAIN-SUFFIX,book.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,booklive.jp,drowkid01-ADM
- DOMAIN-SUFFIX,books.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,boslife.net,drowkid01-ADM
- DOMAIN-SUFFIX,box.com,drowkid01-ADM
- DOMAIN-SUFFIX,businessinsider.com,drowkid01-ADM
- DOMAIN-SUFFIX,bwh1.net,drowkid01-ADM
- DOMAIN-SUFFIX,castbox.fm,drowkid01-ADM
- DOMAIN-SUFFIX,cbc.ca,drowkid01-ADM
- DOMAIN-SUFFIX,cdw.com,drowkid01-ADM
- DOMAIN-SUFFIX,change.org,drowkid01-ADM
- DOMAIN-SUFFIX,channelnewsasia.com,drowkid01-ADM
- DOMAIN-SUFFIX,ck101.com,drowkid01-ADM
- DOMAIN-SUFFIX,clarionproject.org,drowkid01-ADM
- DOMAIN-SUFFIX,clyp.it,drowkid01-ADM
- DOMAIN-SUFFIX,cna.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,comparitech.com,drowkid01-ADM
- DOMAIN-SUFFIX,conoha.jp,drowkid01-ADM
- DOMAIN-SUFFIX,crucial.com,drowkid01-ADM
- DOMAIN-SUFFIX,cts.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,cw.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,cyberctm.com,drowkid01-ADM
- DOMAIN-SUFFIX,dailymotion.com,drowkid01-ADM
- DOMAIN-SUFFIX,dailyview.tw,drowkid01-ADM
- DOMAIN-SUFFIX,daum.net,drowkid01-ADM
- DOMAIN-SUFFIX,daumcdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,dcard.tw,drowkid01-ADM
- DOMAIN-SUFFIX,deepdiscount.com,drowkid01-ADM
- DOMAIN-SUFFIX,depositphotos.com,drowkid01-ADM
- DOMAIN-SUFFIX,deviantart.com,drowkid01-ADM
- DOMAIN-SUFFIX,disconnect.me,drowkid01-ADM
- DOMAIN-SUFFIX,discordapp.com,drowkid01-ADM
- DOMAIN-SUFFIX,discordapp.net,drowkid01-ADM
- DOMAIN-SUFFIX,disqus.com,drowkid01-ADM
- DOMAIN-SUFFIX,dlercloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,dns2go.com,drowkid01-ADM
- DOMAIN-SUFFIX,dowjones.com,drowkid01-ADM
- DOMAIN-SUFFIX,dropbox.com,drowkid01-ADM
- DOMAIN-SUFFIX,dropboxusercontent.com,drowkid01-ADM
- DOMAIN-SUFFIX,duckduckgo.com,drowkid01-ADM
- DOMAIN-SUFFIX,dw.com,drowkid01-ADM
- DOMAIN-SUFFIX,dynu.com,drowkid01-ADM
- DOMAIN-SUFFIX,earthcam.com,drowkid01-ADM
- DOMAIN-SUFFIX,ebookservice.tw,drowkid01-ADM
- DOMAIN-SUFFIX,economist.com,drowkid01-ADM
- DOMAIN-SUFFIX,edgecastcdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,edu,drowkid01-ADM
- DOMAIN-SUFFIX,elpais.com,drowkid01-ADM
- DOMAIN-SUFFIX,enanyang.my,drowkid01-ADM
- DOMAIN-SUFFIX,encyclopedia.com,drowkid01-ADM
- DOMAIN-SUFFIX,esoir.be,drowkid01-ADM
- DOMAIN-SUFFIX,etherscan.io,drowkid01-ADM
- DOMAIN-SUFFIX,euronews.com,drowkid01-ADM
- DOMAIN-SUFFIX,evozi.com,drowkid01-ADM
- DOMAIN-SUFFIX,feedly.com,drowkid01-ADM
- DOMAIN-SUFFIX,firech.at,drowkid01-ADM
- DOMAIN-SUFFIX,flickr.com,drowkid01-ADM
- DOMAIN-SUFFIX,flitto.com,drowkid01-ADM
- DOMAIN-SUFFIX,foreignpolicy.com,drowkid01-ADM
- DOMAIN-SUFFIX,freebrowser.org,drowkid01-ADM
- DOMAIN-SUFFIX,freewechat.com,drowkid01-ADM
- DOMAIN-SUFFIX,freeweibo.com,drowkid01-ADM
- DOMAIN-SUFFIX,friday.tw,drowkid01-ADM
- DOMAIN-SUFFIX,ftchinese.com,drowkid01-ADM
- DOMAIN-SUFFIX,ftimg.net,drowkid01-ADM
- DOMAIN-SUFFIX,gate.io,drowkid01-ADM
- DOMAIN-SUFFIX,getlantern.org,drowkid01-ADM
- DOMAIN-SUFFIX,getsync.com,drowkid01-ADM
- DOMAIN-SUFFIX,globalvoices.org,drowkid01-ADM
- DOMAIN-SUFFIX,goo.ne.jp,drowkid01-ADM
- DOMAIN-SUFFIX,goodreads.com,drowkid01-ADM
- DOMAIN-SUFFIX,gov,drowkid01-ADM
- DOMAIN-SUFFIX,gov.tw,drowkid01-ADM
- DOMAIN-SUFFIX,greatfire.org,drowkid01-ADM
- DOMAIN-SUFFIX,gumroad.com,drowkid01-ADM
- DOMAIN-SUFFIX,hbg.com,drowkid01-ADM
- DOMAIN-SUFFIX,heroku.com,drowkid01-ADM
- DOMAIN-SUFFIX,hightail.com,drowkid01-ADM
- DOMAIN-SUFFIX,hk01.com,drowkid01-ADM
- DOMAIN-SUFFIX,hkbf.org,drowkid01-ADM
- DOMAIN-SUFFIX,hkbookcity.com,drowkid01-ADM
- DOMAIN-SUFFIX,hkej.com,drowkid01-ADM
- DOMAIN-SUFFIX,hket.com,drowkid01-ADM
- DOMAIN-SUFFIX,hkgolden.com,drowkid01-ADM
- DOMAIN-SUFFIX,hootsuite.com,drowkid01-ADM
- DOMAIN-SUFFIX,hudson.org,drowkid01-ADM
- DOMAIN-SUFFIX,hyread.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,ibtimes.com,drowkid01-ADM
- DOMAIN-SUFFIX,i-cable.com,drowkid01-ADM
- DOMAIN-SUFFIX,icij.org,drowkid01-ADM
- DOMAIN-SUFFIX,icoco.com,drowkid01-ADM
- DOMAIN-SUFFIX,imgur.com,drowkid01-ADM
- DOMAIN-SUFFIX,initiummall.com,drowkid01-ADM
- DOMAIN-SUFFIX,insecam.org,drowkid01-ADM
- DOMAIN-SUFFIX,ipfs.io,drowkid01-ADM
- DOMAIN-SUFFIX,issuu.com,drowkid01-ADM
- DOMAIN-SUFFIX,istockphoto.com,drowkid01-ADM
- DOMAIN-SUFFIX,japantimes.co.jp,drowkid01-ADM
- DOMAIN-SUFFIX,jiji.com,drowkid01-ADM
- DOMAIN-SUFFIX,jinx.com,drowkid01-ADM
- DOMAIN-SUFFIX,jkforum.net,drowkid01-ADM
- DOMAIN-SUFFIX,joinmastodon.org,drowkid01-ADM
- DOMAIN-SUFFIX,justmysocks.net,drowkid01-ADM
- DOMAIN-SUFFIX,justpaste.it,drowkid01-ADM
- DOMAIN-SUFFIX,kakao.com,drowkid01-ADM
- DOMAIN-SUFFIX,kakaocorp.com,drowkid01-ADM
- DOMAIN-SUFFIX,kik.com,drowkid01-ADM
- DOMAIN-SUFFIX,kobo.com,drowkid01-ADM
- DOMAIN-SUFFIX,kobobooks.com,drowkid01-ADM
- DOMAIN-SUFFIX,kodingen.com,drowkid01-ADM
- DOMAIN-SUFFIX,lemonde.fr,drowkid01-ADM
- DOMAIN-SUFFIX,lepoint.fr,drowkid01-ADM
- DOMAIN-SUFFIX,lihkg.com,drowkid01-ADM
- DOMAIN-SUFFIX,listennotes.com,drowkid01-ADM
- DOMAIN-SUFFIX,livestream.com,drowkid01-ADM
- DOMAIN-SUFFIX,logmein.com,drowkid01-ADM
- DOMAIN-SUFFIX,mail.ru,drowkid01-ADM
- DOMAIN-SUFFIX,mailchimp.com,drowkid01-ADM
- DOMAIN-SUFFIX,marc.info,drowkid01-ADM
- DOMAIN-SUFFIX,matters.news,drowkid01-ADM
- DOMAIN-SUFFIX,maying.co,drowkid01-ADM
- DOMAIN-SUFFIX,medium.com,drowkid01-ADM
- DOMAIN-SUFFIX,mega.nz,drowkid01-ADM
- DOMAIN-SUFFIX,mil,drowkid01-ADM
- DOMAIN-SUFFIX,mingpao.com,drowkid01-ADM
- DOMAIN-SUFFIX,mobile01.com,drowkid01-ADM
- DOMAIN-SUFFIX,myspace.com,drowkid01-ADM
- DOMAIN-SUFFIX,myspacecdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,nanyang.com,drowkid01-ADM
- DOMAIN-SUFFIX,naver.com,drowkid01-ADM
- DOMAIN-SUFFIX,neowin.net,drowkid01-ADM
- DOMAIN-SUFFIX,newstapa.org,drowkid01-ADM
- DOMAIN-SUFFIX,nexitally.com,drowkid01-ADM
- DOMAIN-SUFFIX,nhk.or.jp,drowkid01-ADM
- DOMAIN-SUFFIX,nicovideo.jp,drowkid01-ADM
- DOMAIN-SUFFIX,nii.ac.jp,drowkid01-ADM
- DOMAIN-SUFFIX,nikkei.com,drowkid01-ADM
- DOMAIN-SUFFIX,nofile.io,drowkid01-ADM
- DOMAIN-SUFFIX,now.com,drowkid01-ADM
- DOMAIN-SUFFIX,nrk.no,drowkid01-ADM
- DOMAIN-SUFFIX,nyt.com,drowkid01-ADM
- DOMAIN-SUFFIX,nytchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,nytcn.me,drowkid01-ADM
- DOMAIN-SUFFIX,nytco.com,drowkid01-ADM
- DOMAIN-SUFFIX,nytimes.com,drowkid01-ADM
- DOMAIN-SUFFIX,nytimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,nytlog.com,drowkid01-ADM
- DOMAIN-SUFFIX,nytstyle.com,drowkid01-ADM
- DOMAIN-SUFFIX,ok.ru,drowkid01-ADM
- DOMAIN-SUFFIX,okex.com,drowkid01-ADM
- DOMAIN-SUFFIX,on.cc,drowkid01-ADM
- DOMAIN-SUFFIX,orientaldaily.com.my,drowkid01-ADM
- DOMAIN-SUFFIX,overcast.fm,drowkid01-ADM
- DOMAIN-SUFFIX,paltalk.com,drowkid01-ADM
- DOMAIN-SUFFIX,pao-pao.net,drowkid01-ADM
- DOMAIN-SUFFIX,parsevideo.com,drowkid01-ADM
- DOMAIN-SUFFIX,pbxes.com,drowkid01-ADM
- DOMAIN-SUFFIX,pcdvd.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,pchome.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,pcloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,picacomic.com,drowkid01-ADM
- DOMAIN-SUFFIX,pinimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,pixiv.net,drowkid01-ADM
- DOMAIN-SUFFIX,player.fm,drowkid01-ADM
- DOMAIN-SUFFIX,plurk.com,drowkid01-ADM
- DOMAIN-SUFFIX,po18.tw,drowkid01-ADM
- DOMAIN-SUFFIX,potato.im,drowkid01-ADM
- DOMAIN-SUFFIX,potatso.com,drowkid01-ADM
- DOMAIN-SUFFIX,prism-break.org,drowkid01-ADM
- DOMAIN-SUFFIX,proxifier.com,drowkid01-ADM
- DOMAIN-SUFFIX,pt.im,drowkid01-ADM
- DOMAIN-SUFFIX,pts.org.tw,drowkid01-ADM
- DOMAIN-SUFFIX,pubu.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,pubu.tw,drowkid01-ADM
- DOMAIN-SUFFIX,pureapk.com,drowkid01-ADM
- DOMAIN-SUFFIX,quora.com,drowkid01-ADM
- DOMAIN-SUFFIX,quoracdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,rakuten.co.jp,drowkid01-ADM
- DOMAIN-SUFFIX,readingtimes.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,readmoo.com,drowkid01-ADM
- DOMAIN-SUFFIX,redbubble.com,drowkid01-ADM
- DOMAIN-SUFFIX,reddit.com,drowkid01-ADM
- DOMAIN-SUFFIX,redditmedia.com,drowkid01-ADM
- DOMAIN-SUFFIX,resilio.com,drowkid01-ADM
- DOMAIN-SUFFIX,reuters.com,drowkid01-ADM
- DOMAIN-SUFFIX,reutersmedia.net,drowkid01-ADM
- DOMAIN-SUFFIX,rfi.fr,drowkid01-ADM
- DOMAIN-SUFFIX,rixcloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,roadshow.hk,drowkid01-ADM
- DOMAIN-SUFFIX,scmp.com,drowkid01-ADM
- DOMAIN-SUFFIX,scribd.com,drowkid01-ADM
- DOMAIN-SUFFIX,seatguru.com,drowkid01-ADM
- DOMAIN-SUFFIX,shadowsocks.org,drowkid01-ADM
- DOMAIN-SUFFIX,shopee.tw,drowkid01-ADM
- DOMAIN-SUFFIX,slideshare.net,drowkid01-ADM
- DOMAIN-SUFFIX,softfamous.com,drowkid01-ADM
- DOMAIN-SUFFIX,soundcloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,ssrcloud.org,drowkid01-ADM
- DOMAIN-SUFFIX,startpage.com,drowkid01-ADM
- DOMAIN-SUFFIX,steamcommunity.com,drowkid01-ADM
- DOMAIN-SUFFIX,steemit.com,drowkid01-ADM
- DOMAIN-SUFFIX,steemitwallet.com,drowkid01-ADM
- DOMAIN-SUFFIX,t66y.com,drowkid01-ADM
- DOMAIN-SUFFIX,tapatalk.com,drowkid01-ADM
- DOMAIN-SUFFIX,teco-hk.org,drowkid01-ADM
- DOMAIN-SUFFIX,teco-mo.org,drowkid01-ADM
- DOMAIN-SUFFIX,teddysun.com,drowkid01-ADM
- DOMAIN-SUFFIX,textnow.me,drowkid01-ADM
- DOMAIN-SUFFIX,theguardian.com,drowkid01-ADM
- DOMAIN-SUFFIX,theinitium.com,drowkid01-ADM
- DOMAIN-SUFFIX,thetvdb.com,drowkid01-ADM
- DOMAIN-SUFFIX,tineye.com,drowkid01-ADM
- DOMAIN-SUFFIX,torproject.org,drowkid01-ADM
- DOMAIN-SUFFIX,tumblr.com,drowkid01-ADM
- DOMAIN-SUFFIX,turbobit.net,drowkid01-ADM
- DOMAIN-SUFFIX,tutanota.com,drowkid01-ADM
- DOMAIN-SUFFIX,tvboxnow.com,drowkid01-ADM
- DOMAIN-SUFFIX,udn.com,drowkid01-ADM
- DOMAIN-SUFFIX,unseen.is,drowkid01-ADM
- DOMAIN-SUFFIX,upmedia.mg,drowkid01-ADM
- DOMAIN-SUFFIX,uptodown.com,drowkid01-ADM
- DOMAIN-SUFFIX,urbandictionary.com,drowkid01-ADM
- DOMAIN-SUFFIX,ustream.tv,drowkid01-ADM
- DOMAIN-SUFFIX,uwants.com,drowkid01-ADM
- DOMAIN-SUFFIX,v2ray.com,drowkid01-ADM
- DOMAIN-SUFFIX,viber.com,drowkid01-ADM
- DOMAIN-SUFFIX,videopress.com,drowkid01-ADM
- DOMAIN-SUFFIX,vimeo.com,drowkid01-ADM
- DOMAIN-SUFFIX,voachinese.com,drowkid01-ADM
- DOMAIN-SUFFIX,voanews.com,drowkid01-ADM
- DOMAIN-SUFFIX,voxer.com,drowkid01-ADM
- DOMAIN-SUFFIX,vzw.com,drowkid01-ADM
- DOMAIN-SUFFIX,w3schools.com,drowkid01-ADM
- DOMAIN-SUFFIX,washingtonpost.com,drowkid01-ADM
- DOMAIN-SUFFIX,wattpad.com,drowkid01-ADM
- DOMAIN-SUFFIX,whoer.net,drowkid01-ADM
- DOMAIN-SUFFIX,wikimapia.org,drowkid01-ADM
- DOMAIN-SUFFIX,wikipedia.org,drowkid01-ADM
- DOMAIN-SUFFIX,wikiquote.org,drowkid01-ADM
- DOMAIN-SUFFIX,wikiwand.com,drowkid01-ADM
- DOMAIN-SUFFIX,winudf.com,drowkid01-ADM
- DOMAIN-SUFFIX,wire.com,drowkid01-ADM
- DOMAIN-SUFFIX,wordpress.com,drowkid01-ADM
- DOMAIN-SUFFIX,workflow.is,drowkid01-ADM
- DOMAIN-SUFFIX,worldcat.org,drowkid01-ADM
- DOMAIN-SUFFIX,wsj.com,drowkid01-ADM
- DOMAIN-SUFFIX,wsj.net,drowkid01-ADM
- DOMAIN-SUFFIX,xhamster.com,drowkid01-ADM
- DOMAIN-SUFFIX,xn--90wwvt03e.com,drowkid01-ADM
- DOMAIN-SUFFIX,xn--i2ru8q2qg.com,drowkid01-ADM
- DOMAIN-SUFFIX,xnxx.com,drowkid01-ADM
- DOMAIN-SUFFIX,xvideos.com,drowkid01-ADM
- DOMAIN-SUFFIX,yahoo.com,drowkid01-ADM
- DOMAIN-SUFFIX,yandex.ru,drowkid01-ADM
- DOMAIN-SUFFIX,ycombinator.com,drowkid01-ADM
- DOMAIN-SUFFIX,yesasia.com,drowkid01-ADM
- DOMAIN-SUFFIX,yes-news.com,drowkid01-ADM
- DOMAIN-SUFFIX,yomiuri.co.jp,drowkid01-ADM
- DOMAIN-SUFFIX,you-get.org,drowkid01-ADM
- DOMAIN-SUFFIX,zaobao.com,drowkid01-ADM
- DOMAIN-SUFFIX,zb.com,drowkid01-ADM
- DOMAIN-SUFFIX,zello.com,drowkid01-ADM
- DOMAIN-SUFFIX,zeronet.io,drowkid01-ADM
- DOMAIN-SUFFIX,zoom.us,drowkid01-ADM
- DOMAIN-KEYWORD,github,drowkid01-ADM
- DOMAIN-KEYWORD,jav,drowkid01-ADM
- DOMAIN-KEYWORD,pinterest,drowkid01-ADM
- DOMAIN-KEYWORD,porn,drowkid01-ADM
- DOMAIN-KEYWORD,wikileaks,drowkid01-ADM

# (Region-Restricted Access Denied)
- DOMAIN-SUFFIX,apartmentratings.com,drowkid01-ADM
- DOMAIN-SUFFIX,apartments.com,drowkid01-ADM
- DOMAIN-SUFFIX,bankmobilevibe.com,drowkid01-ADM
- DOMAIN-SUFFIX,bing.com,drowkid01-ADM
- DOMAIN-SUFFIX,booktopia.com.au,drowkid01-ADM
- DOMAIN-SUFFIX,cccat.io,drowkid01-ADM
- DOMAIN-SUFFIX,centauro.com.br,drowkid01-ADM
- DOMAIN-SUFFIX,clearsurance.com,drowkid01-ADM
- DOMAIN-SUFFIX,costco.com,drowkid01-ADM
- DOMAIN-SUFFIX,crackle.com,drowkid01-ADM
- DOMAIN-SUFFIX,depositphotos.cn,drowkid01-ADM
- DOMAIN-SUFFIX,dish.com,drowkid01-ADM
- DOMAIN-SUFFIX,dmm.co.jp,drowkid01-ADM
- DOMAIN-SUFFIX,dmm.com,drowkid01-ADM
- DOMAIN-SUFFIX,dnvod.tv,drowkid01-ADM
- DOMAIN-SUFFIX,esurance.com,drowkid01-ADM
- DOMAIN-SUFFIX,extmatrix.com,drowkid01-ADM
- DOMAIN-SUFFIX,fastpic.ru,drowkid01-ADM
- DOMAIN-SUFFIX,flipboard.com,drowkid01-ADM
- DOMAIN-SUFFIX,fnac.be,drowkid01-ADM
- DOMAIN-SUFFIX,fnac.com,drowkid01-ADM
- DOMAIN-SUFFIX,funkyimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,fxnetworks.com,drowkid01-ADM
- DOMAIN-SUFFIX,gettyimages.com,drowkid01-ADM
- DOMAIN-SUFFIX,go.com,drowkid01-ADM
- DOMAIN-SUFFIX,here.com,drowkid01-ADM
- DOMAIN-SUFFIX,jcpenney.com,drowkid01-ADM
- DOMAIN-SUFFIX,jiehua.tv,drowkid01-ADM
- DOMAIN-SUFFIX,mailfence.com,drowkid01-ADM
- DOMAIN-SUFFIX,nationwide.com,drowkid01-ADM
- DOMAIN-SUFFIX,nbc.com,drowkid01-ADM
- DOMAIN-SUFFIX,nexon.com,drowkid01-ADM
- DOMAIN-SUFFIX,nordstrom.com,drowkid01-ADM
- DOMAIN-SUFFIX,nordstromimage.com,drowkid01-ADM
- DOMAIN-SUFFIX,nordstromrack.com,drowkid01-ADM
- DOMAIN-SUFFIX,superpages.com,drowkid01-ADM
- DOMAIN-SUFFIX,target.com,drowkid01-ADM
- DOMAIN-SUFFIX,thinkgeek.com,drowkid01-ADM
- DOMAIN-SUFFIX,tracfone.com,drowkid01-ADM
- DOMAIN-SUFFIX,unity3d.com,drowkid01-ADM
- DOMAIN-SUFFIX,uploader.jp,drowkid01-ADM
- DOMAIN-SUFFIX,vevo.com,drowkid01-ADM
- DOMAIN-SUFFIX,viu.tv,drowkid01-ADM
- DOMAIN-SUFFIX,vk.com,drowkid01-ADM
- DOMAIN-SUFFIX,vsco.co,drowkid01-ADM
- DOMAIN-SUFFIX,xfinity.com,drowkid01-ADM
- DOMAIN-SUFFIX,zattoo.com,drowkid01-ADM
# USER-AGENT,Roam*,drowkid01-ADM

# (The Most Popular Sites)
# > drowkid01-ADM
# >> TestFlight
- DOMAIN,testflight.apple.com,drowkid01-ADM
# >> drowkid01-ADM URL Shortener
- DOMAIN-SUFFIX,appsto.re,drowkid01-ADM
# >> iBooks Store download
- DOMAIN,books.itunes.apple.com,drowkid01-ADM
# >> iTunes Store Moveis Trailers
- DOMAIN,hls.itunes.apple.com,drowkid01-ADM
# >> App Store Preview
- DOMAIN,apps.apple.com,drowkid01-ADM
- DOMAIN,itunes.apple.com,drowkid01-ADM
# >> Spotlight
- DOMAIN,api-glb-sea.smoot.apple.com,drowkid01-ADM
# >> Dictionary
- DOMAIN,lookup-api.apple.com,drowkid01-ADM
# > Google
- DOMAIN-SUFFIX,abc.xyz,drowkid01-ADM
- DOMAIN-SUFFIX,android.com,drowkid01-ADM
- DOMAIN-SUFFIX,androidify.com,drowkid01-ADM
- DOMAIN-SUFFIX,dialogflow.com,drowkid01-ADM
- DOMAIN-SUFFIX,autodraw.com,drowkid01-ADM
- DOMAIN-SUFFIX,capitalg.com,drowkid01-ADM
- DOMAIN-SUFFIX,certificate-transparency.org,drowkid01-ADM
- DOMAIN-SUFFIX,chrome.com,drowkid01-ADM
- DOMAIN-SUFFIX,chromeexperiments.com,drowkid01-ADM
- DOMAIN-SUFFIX,chromestatus.com,drowkid01-ADM
- DOMAIN-SUFFIX,chromium.org,drowkid01-ADM
- DOMAIN-SUFFIX,creativelab5.com,drowkid01-ADM
- DOMAIN-SUFFIX,debug.com,drowkid01-ADM
- DOMAIN-SUFFIX,deepmind.com,drowkid01-ADM
- DOMAIN-SUFFIX,firebaseio.com,drowkid01-ADM
- DOMAIN-SUFFIX,getmdl.io,drowkid01-ADM
- DOMAIN-SUFFIX,ggpht.com,drowkid01-ADM
- DOMAIN-SUFFIX,gmail.com,drowkid01-ADM
- DOMAIN-SUFFIX,gmodules.com,drowkid01-ADM
- DOMAIN-SUFFIX,godoc.org,drowkid01-ADM
- DOMAIN-SUFFIX,golang.org,drowkid01-ADM
- DOMAIN-SUFFIX,gstatic.com,drowkid01-ADM
- DOMAIN-SUFFIX,gv.com,drowkid01-ADM
- DOMAIN-SUFFIX,gwtproject.org,drowkid01-ADM
- DOMAIN-SUFFIX,itasoftware.com,drowkid01-ADM
- DOMAIN-SUFFIX,madewithcode.com,drowkid01-ADM
- DOMAIN-SUFFIX,material.io,drowkid01-ADM
- DOMAIN-SUFFIX,polymer-project.org,drowkid01-ADM
- DOMAIN-SUFFIX,admin.recaptcha.net,drowkid01-ADM
- DOMAIN-SUFFIX,recaptcha.net,drowkid01-ADM
- DOMAIN-SUFFIX,shattered.io,drowkid01-ADM
- DOMAIN-SUFFIX,synergyse.com,drowkid01-ADM
- DOMAIN-SUFFIX,tensorflow.org,drowkid01-ADM
- DOMAIN-SUFFIX,tfhub.dev,drowkid01-ADM
- DOMAIN-SUFFIX,tiltbrush.com,drowkid01-ADM
- DOMAIN-SUFFIX,waveprotocol.org,drowkid01-ADM
- DOMAIN-SUFFIX,waymo.com,drowkid01-ADM
- DOMAIN-SUFFIX,webmproject.org,drowkid01-ADM
- DOMAIN-SUFFIX,webrtc.org,drowkid01-ADM
- DOMAIN-SUFFIX,whatbrowser.org,drowkid01-ADM
- DOMAIN-SUFFIX,widevine.com,drowkid01-ADM
- DOMAIN-SUFFIX,x.company,drowkid01-ADM
- DOMAIN-SUFFIX,youtu.be,drowkid01-ADM
- DOMAIN-SUFFIX,yt.be,drowkid01-ADM
- DOMAIN-SUFFIX,ytimg.com,drowkid01-ADM
# > Microsoft
# >> Microsoft OneDrive
- DOMAIN-SUFFIX,1drv.com,drowkid01-ADM
- DOMAIN-SUFFIX,1drv.ms,drowkid01-ADM
- DOMAIN-SUFFIX,blob.core.windows.net,drowkid01-ADM
- DOMAIN-SUFFIX,livefilestore.com,drowkid01-ADM
- DOMAIN-SUFFIX,onedrive.com,drowkid01-ADM
- DOMAIN-SUFFIX,storage.live.com,drowkid01-ADM
- DOMAIN-SUFFIX,storage.msn.com,drowkid01-ADM
- DOMAIN,oneclient.sfx.ms,drowkid01-ADM
# > Other
- DOMAIN-SUFFIX,0rz.tw,drowkid01-ADM
- DOMAIN-SUFFIX,4bluestones.biz,drowkid01-ADM
- DOMAIN-SUFFIX,9bis.net,drowkid01-ADM
- DOMAIN-SUFFIX,allconnected.co,drowkid01-ADM
- DOMAIN-SUFFIX,aol.com,drowkid01-ADM
- DOMAIN-SUFFIX,bcc.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,bit.ly,drowkid01-ADM
- DOMAIN-SUFFIX,bitshare.com,drowkid01-ADM
- DOMAIN-SUFFIX,blog.jp,drowkid01-ADM
- DOMAIN-SUFFIX,blogimg.jp,drowkid01-ADM
- DOMAIN-SUFFIX,blogtd.org,drowkid01-ADM
- DOMAIN-SUFFIX,broadcast.co.nz,drowkid01-ADM
- DOMAIN-SUFFIX,camfrog.com,drowkid01-ADM
- DOMAIN-SUFFIX,cfos.de,drowkid01-ADM
- DOMAIN-SUFFIX,citypopulation.de,drowkid01-ADM
- DOMAIN-SUFFIX,cloudfront.net,drowkid01-ADM
- DOMAIN-SUFFIX,ctitv.com.tw,drowkid01-ADM
- DOMAIN-SUFFIX,cuhk.edu.hk,drowkid01-ADM
- DOMAIN-SUFFIX,cusu.hk,drowkid01-ADM
- DOMAIN-SUFFIX,discord.gg,drowkid01-ADM
- DOMAIN-SUFFIX,discuss.com.hk,drowkid01-ADM
- DOMAIN-SUFFIX,dropboxapi.com,drowkid01-ADM
- DOMAIN-SUFFIX,duolingo.cn,drowkid01-ADM
- DOMAIN-SUFFIX,edditstatic.com,drowkid01-ADM
- DOMAIN-SUFFIX,flickriver.com,drowkid01-ADM
- DOMAIN-SUFFIX,focustaiwan.tw,drowkid01-ADM
- DOMAIN-SUFFIX,free.fr,drowkid01-ADM
- DOMAIN-SUFFIX,gigacircle.com,drowkid01-ADM
- DOMAIN-SUFFIX,hk-pub.com,drowkid01-ADM
- DOMAIN-SUFFIX,hosting.co.uk,drowkid01-ADM
- DOMAIN-SUFFIX,hwcdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,ifixit.com,drowkid01-ADM
- DOMAIN-SUFFIX,iphone4hongkong.com,drowkid01-ADM
- DOMAIN-SUFFIX,iphonetaiwan.org,drowkid01-ADM
- DOMAIN-SUFFIX,iptvbin.com,drowkid01-ADM
- DOMAIN-SUFFIX,linksalpha.com,drowkid01-ADM
- DOMAIN-SUFFIX,manyvids.com,drowkid01-ADM
- DOMAIN-SUFFIX,myactimes.com,drowkid01-ADM
- DOMAIN-SUFFIX,newsblur.com,drowkid01-ADM
- DOMAIN-SUFFIX,now.im,drowkid01-ADM
- DOMAIN-SUFFIX,nowe.com,drowkid01-ADM
- DOMAIN-SUFFIX,redditlist.com,drowkid01-ADM
- DOMAIN-SUFFIX,s3.amazonaws.com,drowkid01-ADM
- DOMAIN-SUFFIX,signal.org,drowkid01-ADM
- DOMAIN-SUFFIX,smartmailcloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,sparknotes.com,drowkid01-ADM
- DOMAIN-SUFFIX,streetvoice.com,drowkid01-ADM
- DOMAIN-SUFFIX,supertop.co,drowkid01-ADM
- DOMAIN-SUFFIX,tv.com,drowkid01-ADM
- DOMAIN-SUFFIX,typepad.com,drowkid01-ADM
- DOMAIN-SUFFIX,udnbkk.com,drowkid01-ADM
- DOMAIN-SUFFIX,urbanairship.com,drowkid01-ADM
- DOMAIN-SUFFIX,whispersystems.org,drowkid01-ADM
- DOMAIN-SUFFIX,wikia.com,drowkid01-ADM
- DOMAIN-SUFFIX,wn.com,drowkid01-ADM
- DOMAIN-SUFFIX,wolframalpha.com,drowkid01-ADM
- DOMAIN-SUFFIX,x-art.com,drowkid01-ADM
- DOMAIN-SUFFIX,yimg.com,drowkid01-ADM
- DOMAIN,api.steampowered.com,drowkid01-ADM
- DOMAIN,store.steampowered.com,drowkid01-ADM

# China Area Network
# > 360
- DOMAIN-SUFFIX,qhres.com,drowkid01-ADM
- DOMAIN-SUFFIX,qhimg.com,drowkid01-ADM
# > Akamai
- DOMAIN-SUFFIX,akadns.net,drowkid01-ADM
# - DOMAIN-SUFFIX,akamai.net,drowkid01-ADM
# - DOMAIN-SUFFIX,akamaiedge.net,drowkid01-ADM
# - DOMAIN-SUFFIX,akamaihd.net,drowkid01-ADM
# - DOMAIN-SUFFIX,akamaistream.net,drowkid01-ADM
# - DOMAIN-SUFFIX,akamaized.net,drowkid01-ADM
# > Alibaba
# USER-AGENT,%E4%BC%98%E9%85%B7*,drowkid01-ADM
- DOMAIN-SUFFIX,alibaba.com,drowkid01-ADM
- DOMAIN-SUFFIX,alicdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,alikunlun.com,drowkid01-ADM
- DOMAIN-SUFFIX,alipay.com,drowkid01-ADM
- DOMAIN-SUFFIX,amap.com,drowkid01-ADM
- DOMAIN-SUFFIX,autonavi.com,drowkid01-ADM
- DOMAIN-SUFFIX,dingtalk.com,drowkid01-ADM
- DOMAIN-SUFFIX,mxhichina.com,drowkid01-ADM
- DOMAIN-SUFFIX,soku.com,drowkid01-ADM
- DOMAIN-SUFFIX,taobao.com,drowkid01-ADM
- DOMAIN-SUFFIX,tmall.com,drowkid01-ADM
- DOMAIN-SUFFIX,tmall.hk,drowkid01-ADM
- DOMAIN-SUFFIX,ykimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,youku.com,drowkid01-ADM
- DOMAIN-SUFFIX,xiami.com,drowkid01-ADM
- DOMAIN-SUFFIX,xiami.net,drowkid01-ADM
# > Baidu
- DOMAIN-SUFFIX,baidu.com,drowkid01-ADM
- DOMAIN-SUFFIX,baidubcr.com,drowkid01-ADM
- DOMAIN-SUFFIX,bdstatic.com,drowkid01-ADM
- DOMAIN-SUFFIX,yunjiasu-cdn.net,drowkid01-ADM
# > bilibili
- DOMAIN-SUFFIX,acgvideo.com,drowkid01-ADM
- DOMAIN-SUFFIX,biliapi.com,drowkid01-ADM
- DOMAIN-SUFFIX,biliapi.net,drowkid01-ADM
- DOMAIN-SUFFIX,bilibili.com,drowkid01-ADM
- DOMAIN-SUFFIX,bilibili.tv,drowkid01-ADM
- DOMAIN-SUFFIX,hdslb.com,drowkid01-ADM
# > Blizzard
- DOMAIN-SUFFIX,blizzard.com,drowkid01-ADM
- DOMAIN-SUFFIX,battle.net,drowkid01-ADM
- DOMAIN,blzddist1-a.akamaihd.net,drowkid01-ADM
# > ByteDance
- DOMAIN-SUFFIX,feiliao.com,drowkid01-ADM
- DOMAIN-SUFFIX,pstatp.com,drowkid01-ADM
- DOMAIN-SUFFIX,snssdk.com,drowkid01-ADM
- DOMAIN-SUFFIX,iesdouyin.com,drowkid01-ADM
- DOMAIN-SUFFIX,toutiao.com,drowkid01-ADM
# > CCTV
- DOMAIN-SUFFIX,cctv.com,drowkid01-ADM
- DOMAIN-SUFFIX,cctvpic.com,drowkid01-ADM
- DOMAIN-SUFFIX,livechina.com,drowkid01-ADM
# > DiDi
- DOMAIN-SUFFIX,didialift.com,drowkid01-ADM
- DOMAIN-SUFFIX,didiglobal.com,drowkid01-ADM
- DOMAIN-SUFFIX,udache.com,drowkid01-ADM
# > 蛋蛋赞
- DOMAIN-SUFFIX,343480.com,drowkid01-ADM
- DOMAIN-SUFFIX,baduziyuan.com,drowkid01-ADM
- DOMAIN-SUFFIX,com-hs-hkdy.com,drowkid01-ADM
- DOMAIN-SUFFIX,czybjz.com,drowkid01-ADM
- DOMAIN-SUFFIX,dandanzan.com,drowkid01-ADM
- DOMAIN-SUFFIX,fjhps.com,drowkid01-ADM
- DOMAIN-SUFFIX,kuyunbo.club,drowkid01-ADM
# > ChinaNet
- DOMAIN-SUFFIX,21cn.com,drowkid01-ADM
# > HunanTV
- DOMAIN-SUFFIX,hitv.com,drowkid01-ADM
- DOMAIN-SUFFIX,mgtv.com,drowkid01-ADM
# > iQiyi
- DOMAIN-SUFFIX,iqiyi.com,drowkid01-ADM
- DOMAIN-SUFFIX,iqiyipic.com,drowkid01-ADM
- DOMAIN-SUFFIX,71.am.com,drowkid01-ADM
# > JD
- DOMAIN-SUFFIX,jd.com,drowkid01-ADM
- DOMAIN-SUFFIX,jd.hk,drowkid01-ADM
- DOMAIN-SUFFIX,jdpay.com,drowkid01-ADM
- DOMAIN-SUFFIX,360buyimg.com,drowkid01-ADM
# > Kingsoft
- DOMAIN-SUFFIX,iciba.com,drowkid01-ADM
- DOMAIN-SUFFIX,ksosoft.com,drowkid01-ADM
# > Meitu
- DOMAIN-SUFFIX,meitu.com,drowkid01-ADM
- DOMAIN-SUFFIX,meitudata.com,drowkid01-ADM
- DOMAIN-SUFFIX,meitustat.com,drowkid01-ADM
- DOMAIN-SUFFIX,meipai.com,drowkid01-ADM
# > MI
- DOMAIN-SUFFIX,duokan.com,drowkid01-ADM
- DOMAIN-SUFFIX,mi-img.com,drowkid01-ADM
- DOMAIN-SUFFIX,miui.com,drowkid01-ADM
- DOMAIN-SUFFIX,miwifi.com,drowkid01-ADM
- DOMAIN-SUFFIX,xiaomi.com,drowkid01-ADM
# > Microsoft
- DOMAIN-SUFFIX,microsoft.com,drowkid01-ADM
- DOMAIN-SUFFIX,msecnd.net,drowkid01-ADM
- DOMAIN-SUFFIX,office365.com,drowkid01-ADM
- DOMAIN-SUFFIX,outlook.com,drowkid01-ADM
- DOMAIN-SUFFIX,s-microsoft.com,drowkid01-ADM
- DOMAIN-SUFFIX,visualstudio.com,drowkid01-ADM
- DOMAIN-SUFFIX,windows.com,drowkid01-ADM
- DOMAIN-SUFFIX,windowsupdate.com,drowkid01-ADM
- DOMAIN,officecdn-microsoft-com.akamaized.net,drowkid01-ADM
# > NetEase
# USER-AGENT,NeteaseMusic*,drowkid01-ADM
# USER-AGENT,%E7%BD%91%E6%98%93%E4%BA%91%E9%9F%B3%E4%B9%90*,drowkid01-ADM
- DOMAIN-SUFFIX,163.com,drowkid01-ADM
- DOMAIN-SUFFIX,126.net,drowkid01-ADM
- DOMAIN-SUFFIX,127.net,drowkid01-ADM
- DOMAIN-SUFFIX,163yun.com,drowkid01-ADM
- DOMAIN-SUFFIX,lofter.com,drowkid01-ADM
- DOMAIN-SUFFIX,netease.com,drowkid01-ADM
- DOMAIN-SUFFIX,ydstatic.com,drowkid01-ADM
# > Sina
- DOMAIN-SUFFIX,sina.com,drowkid01-ADM
- DOMAIN-SUFFIX,weibo.com,drowkid01-ADM
- DOMAIN-SUFFIX,weibocdn.com,drowkid01-ADM
# > Sohu
- DOMAIN-SUFFIX,sohu.com,drowkid01-ADM
- DOMAIN-SUFFIX,sohucs.com,drowkid01-ADM
- DOMAIN-SUFFIX,sohu-inc.com,drowkid01-ADM
- DOMAIN-SUFFIX,v-56.com,drowkid01-ADM
# > Sogo
- DOMAIN-SUFFIX,sogo.com,drowkid01-ADM
- DOMAIN-SUFFIX,sogou.com,drowkid01-ADM
- DOMAIN-SUFFIX,sogoucdn.com,drowkid01-ADM
# > Steam
- DOMAIN-SUFFIX,steampowered.com,drowkid01-ADM
- DOMAIN-SUFFIX,steam-chat.com,drowkid01-ADM
- DOMAIN-SUFFIX,steamgames.com,drowkid01-ADM
- DOMAIN-SUFFIX,steamusercontent.com,drowkid01-ADM
- DOMAIN-SUFFIX,steamcontent.com,drowkid01-ADM
- DOMAIN-SUFFIX,steamstatic.com,drowkid01-ADM
- DOMAIN-SUFFIX,steamcdn-a.akamaihd.net,drowkid01-ADM
- DOMAIN-SUFFIX,steamstat.us,drowkid01-ADM
# > Tencent
# USER-AGENT,MicroMessenger%20Client,drowkid01-ADM
# USER-AGENT,WeChat*,drowkid01-ADM
- DOMAIN-SUFFIX,gtimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,idqqimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,igamecj.com,drowkid01-ADM
- DOMAIN-SUFFIX,myapp.com,drowkid01-ADM
- DOMAIN-SUFFIX,myqcloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,qq.com,drowkid01-ADM
- DOMAIN-SUFFIX,tencent.com,drowkid01-ADM
- DOMAIN-SUFFIX,tencent-cloud.net,drowkid01-ADM
# > YYeTs
# USER-AGENT,YYeTs*,drowkid01-ADM
- DOMAIN-SUFFIX,jstucdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,zimuzu.io,drowkid01-ADM
- DOMAIN-SUFFIX,zimuzu.tv,drowkid01-ADM
- DOMAIN-SUFFIX,zmz2019.com,drowkid01-ADM
- DOMAIN-SUFFIX,zmzapi.com,drowkid01-ADM
- DOMAIN-SUFFIX,zmzapi.net,drowkid01-ADM
- DOMAIN-SUFFIX,zmzfile.com,drowkid01-ADM
# > Content Delivery Network
- DOMAIN-SUFFIX,ccgslb.com,drowkid01-ADM
- DOMAIN-SUFFIX,ccgslb.net,drowkid01-ADM
- DOMAIN-SUFFIX,chinanetcenter.com,drowkid01-ADM
- DOMAIN-SUFFIX,meixincdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,ourdvs.com,drowkid01-ADM
- DOMAIN-SUFFIX,staticdn.net,drowkid01-ADM
- DOMAIN-SUFFIX,wangsu.com,drowkid01-ADM
# > IP Query
- DOMAIN-SUFFIX,ipip.net,drowkid01-ADM
- DOMAIN-SUFFIX,ip.la,drowkid01-ADM
- DOMAIN-SUFFIX,ip-cdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,ipv6-test.com,drowkid01-ADM
- DOMAIN-SUFFIX,test-ipv6.com,drowkid01-ADM
- DOMAIN-SUFFIX,whatismyip.com,drowkid01-ADM
# > Speed Test
# - DOMAIN-SUFFIX,speedtest.net,drowkid01-ADM
- DOMAIN-SUFFIX,netspeedtestmaster.com,drowkid01-ADM
- DOMAIN,speedtest.macpaw.com,drowkid01-ADM
# > Private Tracker
- DOMAIN-SUFFIX,awesome-hd.me,drowkid01-ADM
- DOMAIN-SUFFIX,broadcasthe.net,drowkid01-ADM
- DOMAIN-SUFFIX,chdbits.co,drowkid01-ADM
- DOMAIN-SUFFIX,classix-unlimited.co.uk,drowkid01-ADM
- DOMAIN-SUFFIX,empornium.me,drowkid01-ADM
- DOMAIN-SUFFIX,gazellegames.net,drowkid01-ADM
- DOMAIN-SUFFIX,hdchina.org,drowkid01-ADM
- DOMAIN-SUFFIX,hdsky.me,drowkid01-ADM
- DOMAIN-SUFFIX,icetorrent.org,drowkid01-ADM
- DOMAIN-SUFFIX,jpopsuki.eu,drowkid01-ADM
- DOMAIN-SUFFIX,keepfrds.com,drowkid01-ADM
- DOMAIN-SUFFIX,madsrevolution.net,drowkid01-ADM
- DOMAIN-SUFFIX,m-team.cc,drowkid01-ADM
- DOMAIN-SUFFIX,nanyangpt.com,drowkid01-ADM
- DOMAIN-SUFFIX,ncore.cc,drowkid01-ADM
- DOMAIN-SUFFIX,open.cd,drowkid01-ADM
- DOMAIN-SUFFIX,ourbits.club,drowkid01-ADM
- DOMAIN-SUFFIX,passthepopcorn.me,drowkid01-ADM
- DOMAIN-SUFFIX,privatehd.to,drowkid01-ADM
- DOMAIN-SUFFIX,redacted.ch,drowkid01-ADM
- DOMAIN-SUFFIX,springsunday.net,drowkid01-ADM
- DOMAIN-SUFFIX,tjupt.org,drowkid01-ADM
- DOMAIN-SUFFIX,totheglory.im,drowkid01-ADM
# > Scholar
- DOMAIN-SUFFIX,acm.org,drowkid01-ADM
- DOMAIN-SUFFIX,acs.org,drowkid01-ADM
- DOMAIN-SUFFIX,aip.org,drowkid01-ADM
- DOMAIN-SUFFIX,ams.org,drowkid01-ADM
- DOMAIN-SUFFIX,annualreviews.org,drowkid01-ADM
- DOMAIN-SUFFIX,aps.org,drowkid01-ADM
- DOMAIN-SUFFIX,ascelibrary.org,drowkid01-ADM
- DOMAIN-SUFFIX,asm.org,drowkid01-ADM
- DOMAIN-SUFFIX,asme.org,drowkid01-ADM
- DOMAIN-SUFFIX,astm.org,drowkid01-ADM
- DOMAIN-SUFFIX,bmj.com,drowkid01-ADM
- DOMAIN-SUFFIX,cambridge.org,drowkid01-ADM
- DOMAIN-SUFFIX,cas.org,drowkid01-ADM
- DOMAIN-SUFFIX,clarivate.com,drowkid01-ADM
- DOMAIN-SUFFIX,ebscohost.com,drowkid01-ADM
- DOMAIN-SUFFIX,emerald.com,drowkid01-ADM
- DOMAIN-SUFFIX,engineeringvillage.com,drowkid01-ADM
- DOMAIN-SUFFIX,icevirtuallibrary.com,drowkid01-ADM
- DOMAIN-SUFFIX,ieee.org,drowkid01-ADM
- DOMAIN-SUFFIX,imf.org,drowkid01-ADM
- DOMAIN-SUFFIX,iop.org,drowkid01-ADM
- DOMAIN-SUFFIX,jamanetwork.com,drowkid01-ADM
- DOMAIN-SUFFIX,jhu.edu,drowkid01-ADM
- DOMAIN-SUFFIX,jstor.org,drowkid01-ADM
- DOMAIN-SUFFIX,karger.com,drowkid01-ADM
- DOMAIN-SUFFIX,libguides.com,drowkid01-ADM
- DOMAIN-SUFFIX,madsrevolution.net,drowkid01-ADM
- DOMAIN-SUFFIX,mpg.de,drowkid01-ADM
- DOMAIN-SUFFIX,myilibrary.com,drowkid01-ADM
- DOMAIN-SUFFIX,nature.com,drowkid01-ADM
- DOMAIN-SUFFIX,oecd-ilibrary.org,drowkid01-ADM
- DOMAIN-SUFFIX,osapublishing.org,drowkid01-ADM
- DOMAIN-SUFFIX,oup.com,drowkid01-ADM
- DOMAIN-SUFFIX,ovid.com,drowkid01-ADM
- DOMAIN-SUFFIX,oxfordartonline.com,drowkid01-ADM
- DOMAIN-SUFFIX,oxfordbibliographies.com,drowkid01-ADM
- DOMAIN-SUFFIX,oxfordmusiconline.com,drowkid01-ADM
- DOMAIN-SUFFIX,pnas.org,drowkid01-ADM
- DOMAIN-SUFFIX,proquest.com,drowkid01-ADM
- DOMAIN-SUFFIX,rsc.org,drowkid01-ADM
- DOMAIN-SUFFIX,sagepub.com,drowkid01-ADM
- DOMAIN-SUFFIX,sciencedirect.com,drowkid01-ADM
- DOMAIN-SUFFIX,sciencemag.org,drowkid01-ADM
- DOMAIN-SUFFIX,scopus.com,drowkid01-ADM
- DOMAIN-SUFFIX,siam.org,drowkid01-ADM
- DOMAIN-SUFFIX,spiedigitallibrary.org,drowkid01-ADM
- DOMAIN-SUFFIX,springer.com,drowkid01-ADM
- DOMAIN-SUFFIX,springerlink.com,drowkid01-ADM
- DOMAIN-SUFFIX,tandfonline.com,drowkid01-ADM
- DOMAIN-SUFFIX,un.org,drowkid01-ADM
- DOMAIN-SUFFIX,uni-bielefeld.de,drowkid01-ADM
- DOMAIN-SUFFIX,webofknowledge.com,drowkid01-ADM
- DOMAIN-SUFFIX,westlaw.com,drowkid01-ADM
- DOMAIN-SUFFIX,wiley.com,drowkid01-ADM
- DOMAIN-SUFFIX,worldbank.org,drowkid01-ADM
- DOMAIN-SUFFIX,worldscientific.com,drowkid01-ADM
# > Plex Media Server
- DOMAIN-SUFFIX,plex.tv,drowkid01-ADM
# > Other
- DOMAIN-SUFFIX,cn,drowkid01-ADM
- DOMAIN-SUFFIX,360in.com,drowkid01-ADM
- DOMAIN-SUFFIX,51ym.me,drowkid01-ADM
- DOMAIN-SUFFIX,8686c.com,drowkid01-ADM
- DOMAIN-SUFFIX,abchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,accuweather.com,drowkid01-ADM
- DOMAIN-SUFFIX,aicoinstorge.com,drowkid01-ADM
- DOMAIN-SUFFIX,air-matters.com,drowkid01-ADM
- DOMAIN-SUFFIX,air-matters.io,drowkid01-ADM
- DOMAIN-SUFFIX,aixifan.com,drowkid01-ADM
- DOMAIN-SUFFIX,amd.com,drowkid01-ADM
- DOMAIN-SUFFIX,b612.net,drowkid01-ADM
- DOMAIN-SUFFIX,bdatu.com,drowkid01-ADM
- DOMAIN-SUFFIX,beitaichufang.com,drowkid01-ADM
- DOMAIN-SUFFIX,bjango.com,drowkid01-ADM
- DOMAIN-SUFFIX,booking.com,drowkid01-ADM
- DOMAIN-SUFFIX,bstatic.com,drowkid01-ADM
- DOMAIN-SUFFIX,cailianpress.com,drowkid01-ADM
- DOMAIN-SUFFIX,camera360.com,drowkid01-ADM
- DOMAIN-SUFFIX,chinaso.com,drowkid01-ADM
- DOMAIN-SUFFIX,chua.pro,drowkid01-ADM
- DOMAIN-SUFFIX,chuimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,chunyu.mobi,drowkid01-ADM
- DOMAIN-SUFFIX,chushou.tv,drowkid01-ADM
- DOMAIN-SUFFIX,cmbchina.com,drowkid01-ADM
- DOMAIN-SUFFIX,cmbimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,ctrip.com,drowkid01-ADM
- DOMAIN-SUFFIX,dfcfw.com,drowkid01-ADM
- DOMAIN-SUFFIX,docschina.org,drowkid01-ADM
- DOMAIN-SUFFIX,douban.com,drowkid01-ADM
- DOMAIN-SUFFIX,doubanio.com,drowkid01-ADM
- DOMAIN-SUFFIX,douyu.com,drowkid01-ADM
- DOMAIN-SUFFIX,dxycdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,dytt8.net,drowkid01-ADM
- DOMAIN-SUFFIX,eastmoney.com,drowkid01-ADM
- DOMAIN-SUFFIX,eudic.net,drowkid01-ADM
- DOMAIN-SUFFIX,feng.com,drowkid01-ADM
- DOMAIN-SUFFIX,fengkongcloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,frdic.com,drowkid01-ADM
- DOMAIN-SUFFIX,futu5.com,drowkid01-ADM
- DOMAIN-SUFFIX,futunn.com,drowkid01-ADM
- DOMAIN-SUFFIX,gandi.net,drowkid01-ADM
- DOMAIN-SUFFIX,geilicdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,getpricetag.com,drowkid01-ADM
- DOMAIN-SUFFIX,gifshow.com,drowkid01-ADM
- DOMAIN-SUFFIX,godic.net,drowkid01-ADM
- DOMAIN-SUFFIX,hicloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,hongxiu.com,drowkid01-ADM
- DOMAIN-SUFFIX,hostbuf.com,drowkid01-ADM
- DOMAIN-SUFFIX,huxiucdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,huya.com,drowkid01-ADM
- DOMAIN-SUFFIX,infinitynewtab.com,drowkid01-ADM
- DOMAIN-SUFFIX,ithome.com,drowkid01-ADM
- DOMAIN-SUFFIX,java.com,drowkid01-ADM
- DOMAIN-SUFFIX,jidian.im,drowkid01-ADM
- DOMAIN-SUFFIX,kaiyanapp.com,drowkid01-ADM
- DOMAIN-SUFFIX,kaspersky-labs.com,drowkid01-ADM
- DOMAIN-SUFFIX,keepcdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,kkmh.com,drowkid01-ADM
- DOMAIN-SUFFIX,licdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,linkedin.com,drowkid01-ADM
- DOMAIN-SUFFIX,loli.net,drowkid01-ADM
- DOMAIN-SUFFIX,luojilab.com,drowkid01-ADM
- DOMAIN-SUFFIX,maoyan.com,drowkid01-ADM
- DOMAIN-SUFFIX,maoyun.tv,drowkid01-ADM
- DOMAIN-SUFFIX,meituan.com,drowkid01-ADM
- DOMAIN-SUFFIX,meituan.net,drowkid01-ADM
- DOMAIN-SUFFIX,mobike.com,drowkid01-ADM
- DOMAIN-SUFFIX,moke.com,drowkid01-ADM
- DOMAIN-SUFFIX,mubu.com,drowkid01-ADM
- DOMAIN-SUFFIX,myzaker.com,drowkid01-ADM
- DOMAIN-SUFFIX,nim-lang-cn.org,drowkid01-ADM
- DOMAIN-SUFFIX,nvidia.com,drowkid01-ADM
- DOMAIN-SUFFIX,oracle.com,drowkid01-ADM
- DOMAIN-SUFFIX,paypal.com,drowkid01-ADM
- DOMAIN-SUFFIX,paypalobjects.com,drowkid01-ADM
- DOMAIN-SUFFIX,qdaily.com,drowkid01-ADM
- DOMAIN-SUFFIX,qidian.com,drowkid01-ADM
- DOMAIN-SUFFIX,qyer.com,drowkid01-ADM
- DOMAIN-SUFFIX,qyerstatic.com,drowkid01-ADM
- DOMAIN-SUFFIX,raychase.net,drowkid01-ADM
- DOMAIN-SUFFIX,ronghub.com,drowkid01-ADM
- DOMAIN-SUFFIX,ruguoapp.com,drowkid01-ADM
- DOMAIN-SUFFIX,s-reader.com,drowkid01-ADM
- DOMAIN-SUFFIX,sankuai.com,drowkid01-ADM
- DOMAIN-SUFFIX,scomper.me,drowkid01-ADM
- DOMAIN-SUFFIX,seafile.com,drowkid01-ADM
- DOMAIN-SUFFIX,sm.ms,drowkid01-ADM
- DOMAIN-SUFFIX,smzdm.com,drowkid01-ADM
- DOMAIN-SUFFIX,snapdrop.net,drowkid01-ADM
- DOMAIN-SUFFIX,snwx.com,drowkid01-ADM
- DOMAIN-SUFFIX,sspai.com,drowkid01-ADM
- DOMAIN-SUFFIX,takungpao.com,drowkid01-ADM
- DOMAIN-SUFFIX,teamviewer.com,drowkid01-ADM
- DOMAIN-SUFFIX,tianyancha.com,drowkid01-ADM
- DOMAIN-SUFFIX,udacity.com,drowkid01-ADM
- DOMAIN-SUFFIX,uning.com,drowkid01-ADM
- DOMAIN-SUFFIX,vmware.com,drowkid01-ADM
- DOMAIN-SUFFIX,weather.com,drowkid01-ADM
- DOMAIN-SUFFIX,weico.cc,drowkid01-ADM
- DOMAIN-SUFFIX,weidian.com,drowkid01-ADM
- DOMAIN-SUFFIX,xiachufang.com,drowkid01-ADM
- DOMAIN-SUFFIX,ximalaya.com,drowkid01-ADM
- DOMAIN-SUFFIX,xinhuanet.com,drowkid01-ADM
- DOMAIN-SUFFIX,xmcdn.com,drowkid01-ADM
- DOMAIN-SUFFIX,yangkeduo.com,drowkid01-ADM
- DOMAIN-SUFFIX,zhangzishi.cc,drowkid01-ADM
- DOMAIN-SUFFIX,zhihu.com,drowkid01-ADM
- DOMAIN-SUFFIX,zhimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,zhuihd.com,drowkid01-ADM
- DOMAIN,download.jetbrains.com,drowkid01-ADM
- DOMAIN,images-cn.ssl-images-amazon.com,drowkid01-ADM

# > drowkid01-ADM
- DOMAIN-SUFFIX,aaplimg.com,drowkid01-ADM
- DOMAIN-SUFFIX,apple.co,drowkid01-ADM
- DOMAIN-SUFFIX,apple.com,drowkid01-ADM
- DOMAIN-SUFFIX,apple-cloudkit.com,drowkid01-ADM
- DOMAIN-SUFFIX,appstore.com,drowkid01-ADM
- DOMAIN-SUFFIX,cdn-apple.com,drowkid01-ADM
- DOMAIN-SUFFIX,crashlytics.com,drowkid01-ADM
- DOMAIN-SUFFIX,icloud.com,drowkid01-ADM
- DOMAIN-SUFFIX,icloud-content.com,drowkid01-ADM
- DOMAIN-SUFFIX,me.com,drowkid01-ADM
- DOMAIN-SUFFIX,mzstatic.com,drowkid01-ADM
- DOMAIN,www-cdn.icloud.com.akadns.net,drowkid01-ADM
- DOMAIN,clash.razord.top,drowkid01-ADM
- DOMAIN,v2ex.com,drowkid01-ADM
- IP-CIDR,17.0.0.0/8,drowkid01-ADM,no-resolve

# Local Area Network
- IP-CIDR,192.168.0.0/16,drowkid01-ADM
- IP-CIDR,10.0.0.0/8,drowkid01-ADM
- IP-CIDR,172.16.0.0/12,drowkid01-ADM
- IP-CIDR,127.0.0.0/8,drowkid01-ADM
- IP-CIDR,100.64.0.0/10,drowkid01-ADM

# DNSPod Public DNS+
- IP-CIDR,119.28.28.28/32,drowkid01-ADM,no-resolve
# GeoIP China
- GEOIP,CN,drowkid01-ADM

- MATCH,drowkid01-ADM

proxies:' >> /root/.config/clash/config.yaml 
[[ $mode = 2 ]] && echo -e '
proxies:' >> /root/.config/clash/config.yaml 
}

conFIN() {
confRULE
[[ ! -z ${proTRO} ]] && echo -e "${proTRO}" >> /root/.config/clash/config.yaml
[[ ! -z ${proV2R} ]] && echo -e "${proV2R}" >> /root/.config/clash/config.yaml
[[ ! -z ${proXR} ]] && echo -e "${proXR}" >> /root/.config/clash/config.yaml

#echo ''

echo "#POWER BY @drowkid01" >> /root/.config/clash/config.yaml
}

enon(){
		clear
		msg -bar33
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar33
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * clash.sh * !!!"
		msg -bar33
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar33
		continuar
		read foo
}
enoff(){
rm -f /bin/clash.sh
		msg -bar33
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de clash.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar33
		continuar
		read foo
}

enttrada () {
echo 'source <(curl -sSL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/ClashForAndroidGLOBAL.sh)' > /bin/clash.sh && chmod +x /bin/clash.sh
}

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}
title(){
	msg -bar33
	blanco "$1"
	msg -bar33
}
col(){
	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}
col2(){
	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}
vacio(){
blanco "\n no se puede ingresar campos vacios..."
}
cancelar(){
echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}
continuar(){
echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}
userDat(){
	blanco "	NÂ°    Usuarios 		  fech exp   dias"
	msg -bar33
}
view_usert(){
configt="/usr/local/etc/trojan/config.json"
tempt="/etc/trojan/temp.json"
trojdirt="/etc/trojan" 
user_conf="/etc/trojan/user"
backdirt="/etc/trojan/back" 
tmpdirt="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
	nick="$(cat $configt | grep ',"')"
	users="$(cat $configt | jq -r .password[])"
		title "	ESCOJE USUARIO TROJAN"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = drowkid01script ]] && {
				Usr="Admin"
				DateExp=" Ilimitado"
			} || {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}
			col "$n)" "${Usr}" "$DateExp" "$exp"
			let n++
		done
		msg -bar33
		col "0)" "VOLVER"
		msg -bar33
		blanco "SELECCIONA USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && tropass="user_null" && break
		n=1
		unset i
		for i in $users
		do
		[[ $n = $opcion ]] && tropass=$i
			let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		host=$(cat $configt | jq -r .ssl.sni)
		trojanport=$(cat $configt | jq -r .local_port)
		UUID=$(cat $configt | jq -r .password[$opcion])
		Usr="$(cat ${user_conf}|grep -w "${UUID}"|cut -d'|' -f1)"
		echo "USER ${Usr} : $UUID " 
		break
	done
}

view_user(){
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO V2RAY REGISTRADO"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar33
		col "0)" "VOLVER"
		msg -bar33
		blanco "Escoje Tu Usuario : " 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && break
		let opcion--
		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $net = '"grpc"' ]] && path=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addip=$(wget -qO- ifconfig.me)
		echo "Usuario $ps Seleccionado" 
		break
	done
}

_view_userXR(){
config="/etc/xray/config.json"
temp="/etc/xray/temp.json"
v2rdir="/etc/xr" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/xr/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/xr/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO XRAY REGISTRADO"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar33
		col "0)" "VOLVER"
		msg -bar33
		blanco "Escoje Tu Usuario : " 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && break
		let opcion--
		psX=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $psX = null ]] && ps="default"
		uidX=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiidX=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		addX=$(jq '.inbounds[].domain' $config) && [[ $addX = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		hostX=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $hostX = null ]] && hostX=''
		netX=$(jq '.inbounds[].streamSettings.network' $config)
		parcheX=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $pathX = null ]] && parcheX='' 
		v2portX=$(jq '.inbounds[].port' $config)
		tlsX=$(jq '.inbounds[].streamSettings.security' $config)
		[[ $netX = '"grpc"' ]] && pathX=$(jq '.inbounds[].streamSettings.grpcSettings.serviceName'  $config) || pathX=$(jq '.inbounds[].streamSettings.wsSettings.path' $config)
		addipX=$(wget -qO- ifconfig.me)
		echo "Usuario XRAY SERA  $psX Seleccionado" 
		break
	done
}

[[ ! -d /root/.config/clash ]] && fun_insta || fun_ip
clear
[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New drowkid01ðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
fileon=$(ls -la /var/www/html | grep "yaml" | wc -l)
filelo=$(ls -la /root/.config/clash | grep "yaml" | wc -l)
cd
msg -bar33
echo -e "\033[1;37m ✬  Linux Dist: $(less /etc/issue.net)\033[0m"
msg -bar33
echo -e "\033[1;37m ✬ Ficheros Online:	$fileon  ✬ Ficheros Locales: $filelo\033[0m"
msg -bar33
echo -e "\033[1;37m - Menu Iterativo Clash for Android - drowkid01 \033[0m"
msg -bar33
echo -e "\033[1;37mSeleccione :    Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
unset yesno
echo -e " DESEAS CONTINUAR CON LA CARGA DE CONFIG CLASH?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno numwt
#[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New drowkid01ðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa tu Whatsapp junto a tu codigo de Pais"
read -p " Ejemplo: +593987072611 : " numwt
if [[ -z $numwt ]]; then
numwt='+593987072611'
fi
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa Clase de Servidor ( Gratis - PREMIUM )"
read -p " Ejemplo: PREMIUM : " srvip
if [[ -z $srvip ]]; then
srvip="NewADM"
fi
	while :
	do
	[[ -z ${opcion} ]] || break
		clear
		echo -e " ESCOJE TU METODO DE SELECCION "
		echo -e "  "
		echo -e " SINO CONOCES DE ESTO, ESCOJE 2 "
		echo -e "  "
		msg -bar3
		echo -e "1 - SELECTOR RULES"
		echo -e "2 - SELECTOR GLOBAL"
		msg -bar3
		echo -e " 0) CANCELAR"
		msg -bar3
		read -p " ESCOJE : " opcion
		case $opcion in
			1)configINIT_rule "$opcion"
			break;;
			2)configINIT_global "$opcion"
			break;;
			0) break;;
			*) echo -e "\n selecione una opcion del 0 al 2" && sleep 0.3s;;
		esac
	done
INITClash
fi
