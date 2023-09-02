#!/bin/bash

source ./conf.txt

sudo apt update
sudo apt upgrade -y
sudo apt install -y ansible

# setup netplan: https://ubuntu.com/server/docs/network-configuration
cp ./configs/99_config.yml /etc/netplan/

# sudo netplan try
sudo netplan apply


# ansible-playbook ./playbook.yml