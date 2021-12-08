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
sudo rm -rf packages.microsoft.gpg
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
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y openssh-server wget curl git cmake build-essential mint-meta-codecs autoconf pkg-config apt-transport-https ca-certificates software-properties-common
### Install Docker + Docker-Compose
sudo apt install -y docker-ce docker-compose
sudo usermod -aG docker $USER
### Install VSCode + Fira Code Font
sudo apt install -y code fonts-firacode
### Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.profile
### Install NodeJs
#curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
#sudo apt-get install -y nodejs
nvm install node
### Install Notepadqq
sudo apt install -y notepadqq
### Configuração do Git
echo "Digite seu nome(GitHub):"; read nome
echo "Digite seu email(GitHub):"; read email
sudo git config --global user.name '$nome'
sudo git config --global user.email $email
sudo git config --global core.editor "code --wait"
### Install Snap Support
sudo rm -rf /etc/apt/preferences.d/nosnap.pref
sudo apt install -y snapd
### Install Chromium
sudo snap install -y chromium
### Install Anydesk
sudo apt install -y anydesk
### Install XRDP
sudo apt install -y xrdp xorgxrdp vnc*
echo env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS cinnamon-session > ~/.xsession
sudo systemctl enable xrdp && sudo systemctl start xrdp
### Install OpenVPN
echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
sudo apt update && apt-cache policy libssl1.0-dev
sudo apt install liblzo2-dev libtool libssl1.0-dev libpam0g-dev libssl1.1 openssl libsystemd-dev
sudo wget https://build.openvpn.net/downloads/releases/openvpn-2.4.6.tar.gz -O /tmp/openvpn-2.4.6.tar.gz
sudo tar -zxvf /tmp/openvpn-2.4.6.tar.gz
sudo autoreconf -ivf && sudo ./configure --prefix="/usr/" --enable-systemd
sudo make && sudo make install
### Install Wine
sudo apt install --install-recommends winehq-stable
winecfg
### Install Xar
sudo wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/xar/xar-1.5.2.tar.gz
sudo tar -zxvf xar-1.5.2.tar.gz
cd xar-1.5.2/ && sudo ./configure && sudo make && sudo make install
### Install Cisco Anyconnect
sudo wget http://dl1.technet24.ir/Downloads/Software/Cisco/AnyConnect/anyconnect-linux64-4.9.06037-predeploy-k9.tar.gz
sudo tar -zxvf anyconnect-linux64-4.9.06037-predeploy-k9.tar.gz
cd anyconnect-linux64-4.9.06037/vpn/ && sudo sh vpn_install.sh
### Install No-IP
sudo wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz
sudo tar -zxvf noip-duc-linux.tar.gz
cd noip-2.1.9-1/ && sudo make install
sudo echo '[Unit]' > /etc/systemd/system/noip2.service
sudo echo 'Description=No-ip.com dynamic IP address updater' >> /etc/systemd/system/noip2.service
sudo echo 'After=network.target' >> /etc/systemd/system/noip2.service
sudo echo 'After=syslog.target' >> /etc/systemd/system/noip2.service
sudo echo '' >> /etc/systemd/system/noip2.service
sudo echo '[Install]' >> /etc/systemd/system/noip2.service
sudo echo 'WantedBy=multi-user.target' >> /etc/systemd/system/noip2.service
sudo echo 'Alias=noip.service' >> /etc/systemd/system/noip2.service
sudo echo '' >> /etc/systemd/system/noip2.service
sudo echo '[Service]' >> /etc/systemd/system/noip2.service
sudo echo '# Start main service' >> /etc/systemd/system/noip2.service
sudo echo 'ExecStart=/usr/local/bin/noip2' >> /etc/systemd/system/noip2.service
sudo echo 'Restart=always' >> /etc/systemd/system/noip2.service
sudo echo 'Type=forking' >> /etc/systemd/system/noip2.service
sudo systemctl daemon-reload && sudo systemctl enable noip2 && sudo systemctl start noip2

