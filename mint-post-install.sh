#!/bin/bash
### Enable 32bits Arch
sudo dpkg --add-architecture i386
### Add Universe Repository
sudo add-apt-repository universe
### Add AMD PPA Repository
sudo add-apt-repository ppa:oibaf/graphics-drivers
### Add Notepadqq Repository
sudo add-apt-repository ppa:notepadqq-team/notepadqq
### Add VSCode Repository
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
### Add Anydesk Repository
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list'
### Add Docker Repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
### Add Wine Repository
wget -nc https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add winehq.key
sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(. /etc/os-release; echo "$UBUNTU_CODENAME") main"
### Atualização e Instalação de pacotes principais
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y wget curl git build-essential mint-meta-codecs autoconf pkg-config apt-transport-https ca-certificates software-properties-common
### Install Docker + Docker-Compose
sudo apt install -y docker-ce docker-compose
sudo usermod -aG docker $USER
### Install VSCode + Fira Code Font
sudo apt install -y code fonts-firacode
### Install Node.js
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs
### Install Notepadqq
sudo apt install -y notepadqq
### Configuração do Git
echo "Digite seu nome:"; read nome
echo "Digite seu email(GitHub):"; read email
sudo git config --global user.name '$nome'
sudo git config --global user.email $email
sudo git config --global core.editor "code --wait"
### Install Snap Support
sudo rm -rf /etc/apt/preferences.d/nosnap.pref
sudo apt install -y snapd
### Install Chromium
sudo snap install chromium
### Install Anydesk
sudo apt install -y anydesk
### Install OpenVPN
sudo apt install liblzo2-dev libtool libssl-dev libpam0g-dev libssl1.1 libssl-dev openssl libsystemd-dev
sudo wget https://build.openvpn.net/downloads/releases/openvpn-2.4.6.tar.gz -O /tmp/openvpn-2.4.6.tar.gz
sudo tar -zxvf /tmp/openvpn-2.4.6.tar.gz
sudo autoreconf -ivf && sudo ./configure --prefix="/usr/" --enable-systemd
sudo make && sudo make install
### Install Wine
sudo apt install --install-recommends winehq-stable
winecfg
