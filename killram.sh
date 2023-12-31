#!/bin/sh
#Autor: Henry Chumo 
#Alias : drowkid01
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
kill $(ps -A -ostat,ppid | awk '/[zZ]/{print $2}')
tiempo=$(printf '%(%D-%H:%M:%S)T')
unLimit=$(free --mega | awk 'NR==2{printf $7}') 
#[[ $(dpkg --get-selections|grep -w "snapd"|head -1) ]] && apt purge snapd -y &>/dev/null
killall multipathd  
killall systemd-journald
killall udisksd
sudo systemctl disable systemd-journald
sudo systemctl stop systemd-journald
if [ ${unLimit} -le 200 ]; then 
echo $(free --mega -h | awk 'NR==2{printf $4}') " EN " $tiempo >> /root/lm.log
sudo sync
sudo sysctl -w vm.drop_caches=3  
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
echo "@drowkid01" > /var/log/syslog
echo "@drowkid01" > /var/log/auth.log && rm -f /var/log/*.log.*
killall kswapd0 
killall ksoftirqd 
killall tcpdump 
killall multipathd 
killall snapd 
killall droplet-agent 
[[ -e /etc/v2ray/config.json ]] && v2ray clean
[[ -e /etc/xray/config.json ]] && xray clean
swapoff -a && swapon -a 
rm -rf /tmp/*
echo $(free --kilo -h | awk 'NR==2{printf $4}') " LUEGO " $tiempo >> /root/lm.log
else 
echo "@drowkid01" > /var/log/syslog
echo "@drowkid01" > /var/log/auth.log && rm -f /var/log/*.log.*
sync
echo 3 >/proc/sys/vm/drop_caches
sync && sysctl -w vm.drop_caches=3
sysctl -w vm.drop_caches=0
swapoff -a
swapon -a
rm -rf /tmp/*  
killall kswapd0  
killall tcpdump  
killall ksoftirqd  
killall multipathd  
[[ -e /etc/v2ray/config.json ]] && v2ray clean &&  v2ray restart
[[ -e /etc/xray/config.json ]] &&  xray clean && xray clean
tiempo=$(printf '%(%D-%H:%M:%S)T') 
echo -e >> $HOME/lm.log
echo "Limpio >" $tiempo >> /root/lm.log
echo ${unLimit} "MB - Esta bajo el limite 100MB en " $tiempo >> /root/lm.log
fi
wget -q -O /bin/ejecutar/msg https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg
[[ -e /bin/ejecutar/autt ]] && { 
name=$(cat < /bin/ejecutar/autt)
echo "Haciendo COPIA DE USUARIOS EN $name " $tiempo >> /root/lm.log
source <(curl -sL https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu/autobackup.sh) 
} || {
[[ -e /var/www/html/backup ]] && rm /var/www/html/backup
echo "NO FileSystem " $tiempo >> /root/lm.log
}
