#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install cpulimit -y && sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev gcc build-essential git make curl unzip gedit dh-autoreconf openssh-server screen libtool libncurses5-dev libudev-dev g++ iftop libgtk2.0-dev libboost-dev libboost-system-dev libboost-thread-dev vim -y 
sudo sysctl -w vm.nr_hugepages=$((`grep -c ^processor /proc/cpuinfo` * 3))
git clone https://github.com/JayDDee/cpuminer-opt
cd cpuminer-opt
chmod +x *
./build.sh
mv cpuminer dongqn
make
screen -S minerd ./dongqn -a lyra2z330 -o stratum+tcp://hxx-pool1.chainsilo.com:3032 -u minhthang.10 -p x -x dongqn.cf:1221 --background
