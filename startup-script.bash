#!/bin/bash -x
apt update

echo "install basic packages"
apt -y install git zsh tmux htop curl python3.8 python3.8-venv python3-pip wget xauth x11-apps tig postgresql-client-12 jq gitk rsync vim 


echo "Install python 3.10"
apt-get install software-properties-common -y
add-apt-repository -y ppa:deadsnakes/ppa && apt-get update
apt-get install -y python3.10 python3.10-venv
python3.10 -m ensurepip
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.10 2


echo "Install gloud util"
sudo apt install -y cloud-guest-utils 

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
python3.10 -m pip install -U docker-compose

echo "Install node and yarn"
curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs
npm install --global yarn@1.22.15

echo "Finish"
apt --purge autoremove -y
apt autoclean -y
