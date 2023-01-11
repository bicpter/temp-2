#!/bin/sh
sudo su
apt update
apt full-upgrade -y
apt install ethtool -y
apt install nload && apt install mc -y && apt install docker.io -y && sed -ie 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1'/g /etc/sysctl.conf && sysctl --system && apt install docker-compose -y
sudo iptables -F
sudo iptables -A INPUT -p all -j ACCEPT
sudo iptables -A FORWARD -p all -j ACCEPT
sudo iptables -A OUTPUT -p all -j ACCEPT
sudo iptables -A InstanceServices -p all -j ACCEPT
sudo iptables -t nat -I POSTROUTING -s 172.17.0.1 -j SNAT --to-source $(ip addr show ens3 | grep "inet " | grep -v 127.0.0.1|awk 'match($0, /(10.[0-9]+\.[0-9]+\.[0-9]+)/) {print substr($0,RSTART,RLENGTH)}')
