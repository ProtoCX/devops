#!/bin/bash -x
apt update

echo "install basic packages"
apt -y install git zsh tmux htop curl python3 python3-venv python3-pip python3-apt wget xauth x11-apps tig postgresql-client jq gitk rsync vim 

echo "Install gloud util"
sudo apt install -y cloud-guest-utils 

echo "Setup python"
update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

echo "Install Docker"
apt-get remove docker docker-engine docker.io containerd runc
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Install Docker-Compose"
python3 -m pip install -U docker-compose

echo "Install node and yarn"
curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs npm
npm install --global yarn@1.22.15

echo "Finish"
apt --purge autoremove -y
apt autoclean -y
