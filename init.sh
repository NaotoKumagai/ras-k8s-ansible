#!/bin/bash

source ./conf.txt

sudo -E apt update
sudo -E apt upgrade -y
sudo -E apt install -y ansible netplan.io
sudo -E apt autoremove -y

# setup netplan: https://ubuntu.com/server/docs/network-configuration
sudo -E mkdir -p /etc/netplan
sudo -E cp -f ./configs/99_config.yml /etc/netplan/

sudo -E systemctl enable --now systemd-networkd
# sudo -E netplan try
sudo -E netplan apply


# ansible-playbook ./playbook.yml