#!/bin/sh
#Autor: Henry Chumo 
#Alias : drowkid01
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/

echo '@drowkid01 ' > /var/log/auth.log

rm -rf /usr/.work
#echo > /var/log/auth.log
#killall rsyslog
#systemctl restart rsyslog.service
#clear&&clear
rm -f /root/cron
_puertas() {
    unset portas
    portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
    while read port; do
      var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
      [[ "$(echo -e $portas | grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
    done <<<"$portas_var"
    i=1
    echo -e "$portas"
}

reiniciar_ser () {
screen -wipe &>/dev/null
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
##
echo ""
echo -ne " \033[1;31m[ ! ] Services AUTOREBOOT RESTART FIX"
killall $(cat /bin/autoboot| grep -w screen |awk '{print $20}') &>/dev/null
/bin/autoboot &>/dev/null && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e " \033[1;31m[ ! ] Services BADVPN UDP RESTART "
[[ -e /etc/systemd/system/badvpn.service ]] && { 
systemctl restart badvpn.service > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
} || {
portasx="$(ps x | grep badvpn | grep -v grep | grep -v SCREEN | cut -d ":" -f3 | awk '{print $1'})"
killall badvpn-udpgw 1> /dev/null 2> /dev/null
totalporta=($portasx)
    unset PORT
    for ((i = 0; i < ${#totalporta[@]}; i++)); do
      [[ $(_puertas | grep "${totalporta[$i]}") = "" ]] && {
        echo -ne " \033[1;33m BADVPN:\033[1;32m ${totalporta[$i]}"
        PORT+="${totalporta[$i]}\n"
        screen -dmS badvpn $(which badvpn-udpgw) --listen-addr 127.0.0.1:${totalporta[$i]} --max-clients 1000 --max-connections-for-client 10 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
      } || {
        echo -e "\033[1;33m Puerto Escojido:\033[1;31m ${totalporta[$i]} FAIL"
      }
    done
} || echo -e "\033[1;31m [ SERVICE NO INSTALL ]"
#killall /etc/adm-lite/slow/dnsi/dns-server > /dev/null 2>&1
echo -ne " \033[1;31m[ ! ] Services ssh restart"
service dropbear stop > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services dropbear restart"
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && /etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services stunnel4 restart"
service stunnel4 restart > /dev/null 2>&1
systemctl restart stunnel > /dev/null 2>&1
[[ -e /etc/init.d/stunnel4 ]] && /etc/init.d/stunnel4 restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services stunnel5 restart"
service stunnel5 restart > /dev/null 2>&1
systemctl restart stunnel5.service > /dev/null 2>&1
[[ -e /etc/init.d/stunnel5 ]] && systemctl restart stunnel5.service > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services V2RAY restart"
[[ -e /etc/v2ray/config.json ]] && {
(
v2ray restart > /dev/null 2>&1 
service v2ray restart > /dev/null 2>&1
v2ray clean >/dev/null 2>&1 &
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
} || echo -e "\033[1;31m [ SERVICE NO INSTALL ]"
echo -ne " \033[1;31m[ ! ] Services XRAY restart"
[[ -e /etc/xray/config.json ]] && {
(
xray restart > /dev/null 2>&1 
service xray restart > /dev/null 2>&1
xray clean >/dev/null 2>&1 &
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
} || echo -e "\033[1;31m [ SERVICE NO INSTALL ]"
echo -ne " \033[1;31m[ ! ] Services X-UI restart"
[[ -e /usr/local/x-ui/bin/config.json ]] && { 
systemctl restart x-ui > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" 
} || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services Trojan-GO restart IN "
killall trojan &> /dev/null 2>&1
[[ -e /usr/local/etc/trojan/config.json ]] && {
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
echo -ne "\033[1;32m ARM X64 " && (screen -dmS trojanserv trojan --config /usr/local/etc/trojan/config.json &) && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
} || echo -ne "\033[1;32m X86-64 " && (screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json -l /root/server.log &) && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
}
echo -ne " \033[1;31m[ ! ] Services KeyGen restart"
[[ -e "$(which genon)" ]] && genon && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services squid restart"
service squid restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services squid3 restart"
service squid3 restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services apache2 restart"
service apache2 restart > /dev/null 2>&1
[[ -e /etc/init.d/apache2 ]] && /etc/init.d/apache2 restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services openvpn restart"
service openvpn restart > /dev/null 2>&1
[[ -e /etc/init.d/openvpn ]] && /etc/init.d/openvpn restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services KeyGen restart"
killall http-server.sh &> /dev/null 2>&1
[[ -e /bin/http-server.sh ]] && screen -dmS generador /bin/http-server.sh -start > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services fail2ban restart"
( 
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart
fail2ban-client -x stop && fail2ban-client -x start
) > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"

killall kswapd0 > /dev/null 2>&1
killall systemd-journald > /dev/null 2>&1
killall tcpdump > /dev/null 2>&1
killall ksoftirqd > /dev/null 2>&1
killall menu_inst > /dev/null 2>&1
killall usercodes > /dev/null 2>&1
killall menu > /dev/null 2>&1
rm -f /file
return
}

#[[ "$1" = "--menu" ]] && reiniciar_ser || reiniciar_ser >> /root/Autoblog.log
reiniciar_ser >> /root/Autoblog.log
