#!/bin/bash
echo ""
wget -q -O /tmp/ssr https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/msg-bar/msg 
cat /tmp/ssr > /tmp/ssrrmu.sh
wget -q -O /tmp/ssr https://raw.githubusercontent.com/emirjorge/Script-Z/master/CHUMO/Recursos/menu_inst/C-SSR.sh
cat /tmp/ssr >> /tmp/ssrrmu.sh
#curl  https://www.dropbox.com/s/re3lbbkxro23h4g/C-SSR.sh >> 
sed -i "s;VPS•MX;drowkid01H-ADM;g" /tmp/ssrrmu.sh
sed -i "s;@Kalix1;drowkid01H;g" /tmp/ssrrmu.sh
sed -i "s;VPS-MX;drowkid01h;g" /tmp/ssrrmu.sh
chmod +x /tmp/ssrrmu.sh && bash /tmp/ssrrmu.sh
#sed '/gnula.sh/ d' /tmp/ssrrmu.sh > /bin/ejecutar/crontab
