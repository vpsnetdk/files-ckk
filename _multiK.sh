#!/bin/bash

tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1

msg -bar
echo -e "${cor[4]} VERIFICAR ACTIVIDAD MULTILOGUIN"
msg -bar
sleep 2s
clear
echo
		echo -e "		\033[4;31mNOTA importante\033[0m"
echo
msg -bar
		echo -e " \033[0;31mEste controlador Multilogin, registra las conexiones"
		echo -e " que se conectan a este servidor, via SSH , DROPBEAR, OPENVPN"
		echo -e "               SI NOTAS MUCHAS RECONEXIONES"
		echo -e "     APAGA ESTA OPC, POR METODOS INESTABLES (RECOMENDADO)"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
msg -bar
read "PRESIONE ENTER PARA CONTINUAR"
clear&&clear
select_users
if [ "$select_name" = "" ]; then
return
fi
namer="$select_name"
[[ $(cat /etc/adm-lite/userDIR/$namer | grep "limite" | awk '{print $2}') = "HWID" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
[[ $(cat /etc/adm-lite/userDIR/$namer | grep "limite" | awk '{print $2}') = "TOKEN" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
msg -bar
echo -e "${cor[5]} RECUERDE QUE EL LOG SE ALMACENA EN /root/limiter.log"
msg -bar
#for _lim in $(cat /root/limiter.log | grep -w ${name}|  cut -d " " -f6 | cut -d "/" -f1); then
_dateIP="$(cat /root/limiter.log | grep -w ${namer}| grep -w $(date +%m/%d/%y) | head -1)" #cut -d " " -f6 | cut -d "/" -f1)"
_dateIU="$(cat /root/limiter.log | grep -w ${namer}| grep -w $(date +%m/%d/%y) | tail -1)" #cut -d " " -f6 | cut -d "/" -f1)"
_dateF="$(cat /root/limiter.log | grep -w ${namer}|  cut -d " " -f6 | cut -d "/" -f1)"
array="$(cat /root/limiter.log | grep -w ${namer}|  cut -d " " -f6 | cut -d "/" -f1)"
cantidad=${#array};
_l="$(cat /root/limiter.log|grep -w ${namer} | wc -l)"
numeroMayor=0
for i in $array; do          
[[ $i -gt $numeroMayor ]] && numeroMayor=$i
  let n++       
done      

echo -e "## PRIMERA MULTICONEXION ESTIMADA EL DIA DE HOY ${_dateIP} "
echo -e "## ULTIMA MULTICONEXION ESTIMADA EL DIA DE HOY ${_dateIU} "
echo -e "##  EXCESO DE CONEXIONES : ${numeroMayor} LA MAS ALTA"
echo -e " USUARIO : ${nameFX} tiene $(cat /root/limiter.log|grep -w ${namer} | wc -l) RECONEXIONES CON "
echo -e "${cor[5]} ESCOJE LA OPCION A CAMBIAR DE $namer"
