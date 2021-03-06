#!/bin/bash
apt-get update
apt-get -y install strongswan xl2tpd
VPN_SERVER_IP='202.182.112.98'
VPN_IPSEC_PSK='To2pNdmn8rh2yZkf'
VPN_USER='vpnuser'
VPN_PASSWORD='gSAYvAe4rXUKL6Mw'
cat > /etc/ipsec.conf <<EOF
# ipsec.conf - strongSwan IPsec configuration file

# basic configuration

config setup
  # strictcrlpolicy=yes
  # uniqueids = no

# Add connections here.

# Sample VPN connections

conn %default
  ikelifetime=60m
  keylife=20m
  rekeymargin=3m
  keyingtries=1
  keyexchange=ikev1
  authby=secret
  ike=aes128-sha1-modp1024,3des-sha1-modp1024!
  esp=aes128-sha1-modp1024,3des-sha1-modp1024!

conn myvpn
  keyexchange=ikev1
  left=%defaultroute
  auto=add
  authby=secret
  type=transport
  leftprotoport=17/1701
  rightprotoport=17/1701
  right=$VPN_SERVER_IP
EOF

cat > /etc/ipsec.secrets <<EOF
: PSK "$VPN_IPSEC_PSK"
EOF

chmod 600 /etc/ipsec.secrets
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[lac myvpn]
lns = $VPN_SERVER_IP
ppp debug = yes
pppoptfile = /etc/ppp/options.l2tpd.client
length bit = yes
EOF

cat > /etc/ppp/options.l2tpd.client <<EOF
ipcp-accept-local
ipcp-accept-remote
refuse-eap
require-chap
noccp
noauth
mtu 1280
mru 1280
noipdefault
defaultroute
usepeerdns
connect-delay 5000
name $VPN_USER
password $VPN_PASSWORD
EOF

chmod 600 /etc/ppp/options.l2tpd.client

mkdir -p /var/run/xl2tpd
touch /var/run/xl2tpd/l2tp-control
service strongswan restart
service xl2tpd restart
sleep 5s
ipsec up myvpn
sleep 5s
echo "c myvpn" > /var/run/xl2tpd/l2tp-control
sleep 5s
IP=$(/sbin/ip route | awk '/default/ { print $3 }')
route add 202.182.112.98 gw $IP
route add 117.7.90.112 gw $IP
route add default dev ppp0
wget -qO- http://ipv4.icanhazip.com > ip.txt

sudo apt-get update
sudo apt-get install openjdk-8-jdk maven git gcc make build-essential -y
cd
git clone git://github.com/Programmerdan/arionum-java
cd arionum-java/arionum-miner
mvn clean package
touch config.cfg
chmod 755 config.cfg
echo "pool
http://aropool.com/
4Nb7g8VyqbpXTaVx1tz6C1ZKh4YGXRnpmH2yVWevmJVyBZ2PM53BPt7FwAdDAfqBLuAaGTCK2Ys66Wjt99SjdyS7
14
enhanced
true
`hostname`" > config.cfg
chmod +x build-argon.sh
./build-argon.sh
./run.sh
