#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install cpulimit -y && sudo apt-get install tsocks
git clone https://github.com/tonhue26/ariocppminer.git
cd ariocppminer
mv ariocppminer_avx2 dongqn
chmod 0777 dongqn
sudo sed -i 's/192.168.0.0/0.0.0.0/g' /etc/tsocks.conf
sudo sed -i 's/255.255.255.0/0.0.0.0/g' /etc/tsocks.conf
sudo sed -i 's/192.168.0.1/38.141.47.57/g' /etc/tsocks.conf
sudo sed -i 's/server_port = 1080/server_port = 1221/g' /etc/tsocks.conf
sudo sed -i 's/server_type = 4/server_type = 5/g' /etc/tsocks.conf
tsocks tmux new-session -d -s my_session1 './dongqn'
