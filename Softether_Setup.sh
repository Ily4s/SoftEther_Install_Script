#Update and Upgrade
apt-get update -y
apt-get upgrade -y
#Install Compiler Tools
apt-get install curl -y
apt-get install build-essential -y
#Download SoftEther
wget http://www.softether-download.com/files/softether/v4.10-9473-beta-2014.07.12-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.10-9473-beta-2014.07.12-linux-x64-64bit.tar.gz
sleep 5
#Extract SoftEther
tar -xzvf softether-vpnserver-v4.10-9473-beta-2014.07.12-linux-x64-64bit.tar.gz
sleep 5
#Compile SoftEther
cd vpnserver
yes 1 | make
sleep 5
#Install SoftEther
cd ..
mv vpnserver /usr/local
cd /usr/local/vpnserver/
#Fix Permissions
chmod 600 *
chmod 700 vpnserver
chmod 700 vpncmd
sleep 5
#Write Startup Script
echo '#!/bin/sh' >> /etc/init.d/vpnserver
echo '# chkconfig: 2345 99 01' >> /etc/init.d/vpnserver
echo '# description: SoftEther VPN Server' >> /etc/init.d/vpnserver
echo 'DAEMON=/usr/local/vpnserver/vpnserver' >> /etc/init.d/vpnserver
echo 'LOCK=/var/lock/subsys/vpnserver' >> /etc/init.d/vpnserver
echo 'test -x $DAEMON || exit 0' >> /etc/init.d/vpnserver
echo 'case "$1" in' >> /etc/init.d/vpnserver
echo 'start)' >> /etc/init.d/vpnserver
echo '$DAEMON start' >> /etc/init.d/vpnserver
echo 'touch $LOCK' >> /etc/init.d/vpnserver
echo ';;' >> /etc/init.d/vpnserver
echo 'stop)' >> /etc/init.d/vpnserver
echo '$DAEMON stop' >> /etc/init.d/vpnserver
echo 'rm $LOCK' >> /etc/init.d/vpnserver
echo ';;' >> /etc/init.d/vpnserver
echo 'restart)' >> /etc/init.d/vpnserver
echo '$DAEMON stop' >> /etc/init.d/vpnserver
echo 'sleep 3' >> /etc/init.d/vpnserver
echo '$DAEMON start' >> /etc/init.d/vpnserver
echo ';;' >> /etc/init.d/vpnserver
echo '*)' >> /etc/init.d/vpnserver
echo 'echo "Usage: $0 {start|stop|restart}"' >> /etc/init.d/vpnserver
echo 'exit 1' >> /etc/init.d/vpnserver
echo 'esac' >> /etc/init.d/vpnserver
echo 'exit 0' >> /etc/init.d/vpnserver
chmod 755 /etc/init.d/vpnserver
#Write Mutex?
mkdir /var/lock/subsys
#Start Server
/etc/init.d/vpnserver start
#Update Stuff
update-rc.d vpnserver defaults
sleep 5
#Download and Install Config
/etc/init.d/vpnserver stop
yes | rm vpn_server.config
curl $ http://hastebin.com/raw/vetolajiyu.txt > vpn_server.config
chmod 600 vpn_server.config
sleep 5
/etc/init.d/vpnserver start
#Install DHCP Server
sleep 5
ifconfig tap_sevpn
apt-get install dnsmasq -y
echo 'interface=tap_sevpn' >> /etc/dnsmasq.conf
echo 'dhcp-range=tap_sevpn,10.0.2.2,10.0.2.200,12h' >> /etc/dnsmasq.conf
echo 'dhcp-option=tap_sevpn,3,10.0.2.1' >> /etc/dnsmasq.conf
sleep 5
#Write New Startup Script
rm -rf /etc/init.d/vpnserver
echo '#!/bin/sh' >> /etc/init.d/vpnserver
echo '### BEGIN INIT INFO' >> /etc/init.d/vpnserver
echo '# Provides:          vpnserver' >> /etc/init.d/vpnserver
echo '# Required-Start:    $remote_fs $syslog' >> /etc/init.d/vpnserver
echo '# Required-Stop:     $remote_fs $syslog' >> /etc/init.d/vpnserver
echo '# Default-Start:     2 3 4 5' >> /etc/init.d/vpnserver
echo '# Default-Stop:      0 1 6' >> /etc/init.d/vpnserver
echo '# Short-Description: Start daemon at boot time' >> /etc/init.d/vpnserver
echo '# Description:       Enable Softether by daemon.' >> /etc/init.d/vpnserver
echo '### END INIT INFO' >> /etc/init.d/vpnserver
echo 'DAEMON=/usr/local/vpnserver/vpnserver' >> /etc/init.d/vpnserver
echo 'LOCK=/var/lock/subsys/vpnserver' >> /etc/init.d/vpnserver
echo 'TAP_ADDR=10.0.2.1' >> /etc/init.d/vpnserver
echo 'test -x $DAEMON || exit 0' >> /etc/init.d/vpnserver
echo 'case "$1" in' >> /etc/init.d/vpnserver
echo 'start)' >> /etc/init.d/vpnserver
echo '$DAEMON start' >> /etc/init.d/vpnserver
echo 'touch $LOCK' >> /etc/init.d/vpnserver
echo 'sleep 1' >> /etc/init.d/vpnserver
echo '/sbin/ifconfig tap_sevpn $TAP_ADDR' >> /etc/init.d/vpnserver
echo ';;' >> /etc/init.d/vpnserver
echo 'stop)' >> /etc/init.d/vpnserver
echo '' >> /etc/init.d/vpnserver
echo '$DAEMON stop' >> /etc/init.d/vpnserver
echo 'rm $LOCK' >> /etc/init.d/vpnserver
echo ';;' >> /etc/init.d/vpnserver
echo 'restart)' >> /etc/init.d/vpnserver
echo '$DAEMON stop' >> /etc/init.d/vpnserver
echo 'sleep 3' >> /etc/init.d/vpnserver
echo '$DAEMON start' >> /etc/init.d/vpnserver
echo 'sleep 1' >> /etc/init.d/vpnserver
echo '/sbin/ifconfig tap_sevpn $TAP_ADDR' >> /etc/init.d/vpnserver
echo ';;' >> /etc/init.d/vpnserver
echo '*)' >> /etc/init.d/vpnserver
echo 'echo "Usage: $0 {start|stop|restart}"' >> /etc/init.d/vpnserver
echo 'exit 1' >> /etc/init.d/vpnserver
echo 'esac' >> /etc/init.d/vpnserver
echo 'exit 0' >> /etc/init.d/vpnserver
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.d/ipv4_forwarding.conf
chmod 755 /etc/init.d/vpnserver
sleep 5
#Update Stuff
sysctl --system
#Configure IPTables
externalIP=$(curl -s ipv4.icanhazip.com)
sleep 5
iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -j SNAT --to-source $externalIP
#Make IPTables Persistent
apt-get install iptables-persistent -y
sleep 5
#Restart Services
service dnsmasq restart
service vpnserver restart