#!/bin/bash

echo "Startup Script";
echo "So you're building a new box";
echo "Did you break the old one so soon?";

#Creates /opt directory;
if [[ -d "/opt" ]]; then;
    echo "/opt directory already exists";
    if [[ ":$PATH:" == *":/opt:"* ]]; then;
        echo "/opt already exists in PATH";
    else;
        echo "/opt not in PATH, adding to PATH";
        export PATH=$PATH:/opt/*/bin";
    fi;
else;
    echo "/opt directory does not exist, creating directory";
    mkdir /opt;
    sudo chmod 777 /opt;
    echo "/opt directory created";
    echo "adding /opt to PATH";
    export PATH=$PATH:/opt/*/bin";
fi;
;
#Add your aliases;
echo "alias python=python3" >> /etc/bash.bashrc;
echo "furiousrecon=/opt/furiousrecon/furiousrecon.sh" >> /etc/bash.bashrc;

# Update packages;
sudo apt update && sudo apt upgrade -y;

# Install the easy stuff;
sudo apt install -y ufw wfuzz aircrack-ng nikto xsltproc libssl-dev libffi-dev build-essential plocate curl openssl libio-socket-ssl-perl wget nmap git wireshark golang ruby terminator gnupg apt-transport-https traceroute openvpn python3-pip cherrytree openjdk-11-jdk;

# Clone Github repos;
git clone https://github.com/n1cfury/furiousrecon.git /opt/furiousrecon;
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists;
git clone https://github.com/fortra/impacket.git /opt/Impacket;
git clone https://github.com/volatilityfoundation/volatility.git /opt/Volatility;
git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng;
git clone https://github.com/cervoise/linuxprivcheck.git /opt/linuxprivcheck;
echo "Open a new window and manually finish the install for recon-ng";
echo "First go here -> /opt/recon-ng";
echo "then do this -> pip install -r REQUIREMENTS";

#installing pip tools. Dont use PIP as root;
pip install scapy;
pip install requests;
pip install beautifulsoup4;
pip install pyinstaller;
pip install yara-python;
pip install pwntools;
pip install frida;
pip install pycrypto;

#Snap Installs;
sudo snap install powershell --classic;
sudo snap install enum4linux;
sudo snap install sqlmap;
sudo snap install testssl;

#Acquiring additional tools;
echo "Installing Sublime Text...";
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -;
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list;
sudo apt-get update;
sudo apt-get install sublime-text -y;
sleep 10;

echo "Installing Zoom...";
wget https://zoom.us/client/latest/zoom_amd64.deb;
sudo dpkg -i zoom_amd64.deb;
sleep 10;
echo "Applications installed. Don't forget to Grab Burp Suite and Volatility!";
Done;