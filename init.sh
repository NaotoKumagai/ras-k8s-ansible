#!/bin/bash

source ./conf.txt

sudo -E apt update
sudo -E apt upgrade -y
sudo -E apt install -y ansible netplan.io
sudo -E apt autoremove -y

sudo -E wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_arm64 -O /usr/bin/yq
sudo -E chmod +x /usr/bin/yq

# setup netplan: https://ubuntu.com/server/docs/network-configuration
sudo -E mkdir -p /etc/netplan
sudo -E cp -f ./configs/99_config.yaml /etc/netplan/

# Fixed local IP
sudo yq -i ".network.wifis.wlan0.access-points.${ACCESS_POINTS}.password=\"${ACCESS_POINTS_PASS}\"" /etc/netplan/99_config.yaml

# enable cgroup memory (need kubeadm)
sudo -E cp -f ./configs/cmdline.txt /boot/cmdline.txt

sudo -E shutdown -r now

# ansible-playbook ./playbook.yml