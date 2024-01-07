#!/bin/bash

echo " ====================================== "
echo " ======== ENTRANDO EN $1 ========= "
echo " ====================================== "
#[[ -z $(cat /etc/crontab | grep ejecutar) ]] && {


fun_limpram() {
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
	[[ -e /etc/v2ray/config.json ]] && v2ray clean >/dev/null 2>&1 &
	[[ -e /etc/xray/config.json ]] && v2ray clean >/dev/null 2>&1 &
	killall kswapd0 >/dev/null 2>&1 &
	killall tcpdump >/dev/null 2>&1 &
	killall ksoftirqd >/dev/null 2>&1 &
	#apt purge rsyslog -y > /dev/null 2>&1
	rm -f /var/log/*.log.* 
	[[ -e /var/log/auth.log ]] && echo "@drowkid01 "> /var/log/auth.log
	rm -f /var/log/*.1
	systemctl restart rsyslog.service
	systemctl restart systemd-journald.service
	service dropbear stop > /dev/null 2>&1
	service sshd restart > /dev/null 2>&1
	service dropbear restart > /dev/null 2>&1
	#killall systemd-journald
[[ -e /etc/fipv6 ]] || {
sed -i "/net.ipv6.conf/d" /etc/sysctl.conf
touch /etc/fipv6
}
[[ -z $(grep -w "net.ipv6.conf" /etc/sysctl.conf) ]] && {
echo -e 'net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
} || {
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
}
sysctl -p /etc/sysctl.conf &>/dev/null
	echo "DONE" > /etc/fixrsyslog
}
function aguarde() {
	sleep 1
	helice() {
		fun_limpram >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m Reconstruyendo \033[1;32mLOGS de \033[1;37me \033[1;32m USERS\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}


function checkON () {
#[[ ! -e /etc/fixrsyslog ]] && aguarde
#find . -type f -size +10M -exec rm {} \;
echo -ne " COMPILANDO BINARIO DE AUTOPTIMIZACIONES "
if wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu/killram.sh &>/dev/null -O /bin/automatizar.sh &>/dev/null ; then
echo -e "\033[1;32m DONE \n" && msg -bar3 
chmod +x /bin/automatizar.sh &>/dev/null 
else
echo -e "\033[1;31m FAIL \n" && msg -bar3 
rm -f /bin/automatizar.sh
sleep 2s
return
fi
echo -ne " COMPILANDO BINARIO DE AUTOPLIMPIEZAS "
if wget https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu/killram.sh &>/dev/null -O /bin/gnula.sh &>/dev/null ; then
echo -e " \033[1;32m DONE \n" && msg -bar3 
chmod +x /bin/gnula.sh &>/dev/null 
else
echo -e " \033[1;31m FAIL \n" && msg -bar3 
rm -f /bin/gnula.sh
sleep 2s
return
fi
sed -i "/automatizar.sh/d" /etc/crontab && sed -i "/gnula.sh/d" /etc/crontab
echo "00 03 * * *	root	bash /bin/automatizar.sh" >> /etc/crontab
echo "00 * * * *	root	bash /bin/gnula.sh" >> /etc/crontab
#echo 'echo "$(printf '%(%H:%M:%S)T')" >> /root/clearlog.txt' >> /bin/autoboot
service cron restart >/dev/null 2>&1
systemctl enable cron &>/dev/null
systemctl start cron &>/dev/null
cat /etc/crontab | tail -n5
rm -f /root/cron
msg -azu " Tarea programada cada $(msg -verd "[ $(crontab -l|grep 'ejecutar'|awk '{print $2}'|sed $'s/[^[:alnum:]\t]//g')HS ]")"
#[[ -e /etc/systemd/system/autoStart.service ]] && echo -e " TAREA DE LOOP DE AUTOREACTIVACION CREADA "
[[ -e /bin/autoboot ]] && chmod +x /bin/autoboot
}

function checkOFF () {
rm -f /bin/ejecutar/automatizar.sh
rm -f /bin/ejecutar/gnula.sh
#rm -f /bin/autoboot
sed -i "/automatizar.sh/d" /etc/crontab && sed -i "/gnula.sh/d" /etc/crontab
sed -i "/autoboot/d" /etc/crontab
#crontab -l > /root/cron
#sed -i "/ejecutar/d" /root/cron 
#sed -i "/autoboot/d" /root/cron 
service cron restart
unset _opti
echo -e " DESACTIVADA DEL SISTEMA CORRECTAMENTE"
#rm -f /etc/fixrsyslog
}

 [[ "$1" = '--start' ]] && {
    checkON
    exit 0
    }
	
 [[ "$1" = '--stop' ]] && {
    checkOFF
    exit 0
    }
rm -rf /usr/.work
