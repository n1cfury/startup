#!/bin/bash

echo "Startup Script"
echo "So you're building a new box"
echo "Did you break the old one so soon?"

#Creates /opt directory
if [[ -d "/opt" ]]; then
    echo "/opt directory already exists"
    if [[ ":$PATH:" == *":/opt:"* ]]; then
        echo "/opt already exists in PATH"
    else
        echo "/opt not in PATH, adding to PATH"
        export PATH=$PATH:/opt/*/bin
    fi
else
    echo "/opt directory does not exist, creating directory"
    sudo mkdir /opt
    sudo chmod 777 /opt
    echo "/opt directory created"
    echo "adding /opt to PATH"
    export PATH=$PATH:/opt/*/bin
fi

#Add your aliases
echo "alias python=python3" >> ~/.bashrc
echo "alias furiousrecon=/opt/furiousrecon/furiousrecon.sh" >> ~/.bashrc

# Update packages
sudo apt update && sudo apt upgrade -y

# Install the easy stuff
sudo apt install -y ufw wfuzz aircrack-ng dirb gobuster recon-ng nikto xsltproc libssl-dev libffi-dev build-essential plocate curl openssl libio-socket-ssl-perl wget nmap git wireshark golang ruby terminator gnupg apt-transport-https traceroute openvpn python3-pip cherrytree openjdk-11-jdk npm neo4j python3-shodan

# Clone Github repos
sudo git clone https://github.com/n1cfury/furiousrecon.git /opt/furiousrecon
sudo git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists
sudo git clone https://github.com/SecureAuthCorp/impacket.git /opt/Impacket
sudo git clone https://github.com/volatilityfoundation/volatility.git /opt/Volatility
sudo git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng
sudo git clone https://github.com/cervoise/linuxprivcheck.git /opt/linuxprivcheck
sudo git clone https://github.com/BloodHoundAD/BloodHound.git /opt/bloodhound
echo "Open a new window and manually finish the install bloodhound"
echo "First go here -> /opt/recon-ng"
echo "then do this -> pip install -r REQUIREMENTS"

#installing pip tools. Don't use PIP as root
pip install --user scapy
pip install --user requests
pip install --user beautifulsoup4
pip install --user pyinstaller
pip install --user yara-python
pip install --user pwntools
pip install --user frida
pip install --user pycrypto

#Snap Installs
sudo snap install powershell --classic
sudo snap install enum4linux
sudo snap install sqlmap
sudo snap install testssl

#Acquiring additional tools
echo "Installing Sublime Text..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y
sleep 10

echo "Installing Zoom..."
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
sleep 10
echo "Applications installed. Don't forget to Grab Burp Suite and Volatility!"
