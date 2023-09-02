#!/bin/bash

source ./conf.txt

sudo -E apt update
sudo -E apt upgrade -y
sudo -E apt install -y ansible netplan.io
sudo -E apt autoremove -y

wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
chmod +x /usr/bin/yq

# setup netplan: https://ubuntu.com/server/docs/network-configuration
sudo -E mkdir -p /etc/netplan
sudo -E cp -f ./configs/99_config.yml /etc/netplan/

sudo yq -i '.network.wifis.wlan0.access-points="$ACCESS_POINTS"' /etc/netplan/99_config.yml
sudo yq -i '.network.wifis.wlan0.access-points.password="$ACCESS_POINTS_PASS"' /etc/netplan/99_config.yml

sudo -E systemctl enable --now systemd-networkd
# sudo -E netplan try
sudo -E netplan apply


# ansible-playbook ./playbook.yml