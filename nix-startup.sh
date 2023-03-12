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
sudo apt update && sudo apt upgrade -y && sudo apt install -y git default-jre-headless curl wget golang ruby python3-pip snapd

#Acquiring additional tools
echo "Installing Sublime Text..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y
sleep 5

echo "Installing Zoom..."
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
sleep 5

# Download OWASP ZAP
wget -q -O zap.sh https://github.com/zaproxy/zaproxy/releases/download/v2.11.0/ZAP_2_11_0_unix.sh
# Install OWASP ZAP
sudo sh zap.sh

# Print success message
echo "OWASP ZAP installed successfully."

# Clone Github repos
sudo git clone https://github.com/n1cfury/furiousrecon.git /opt/furiousrecon
sudo git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists
sudo git clone https://github.com/SecureAuthCorp/impacket.git /opt/Impacket
sudo git clone https://github.com/volatilityfoundation/volatility.git /opt/Volatility
sudo git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng
sudo git clone https://github.com/cervoise/linuxprivcheck.git /opt/linuxprivcheck
sudo git clone https://github.com/BloodHoundAD/BloodHound.git /opt/bloodhound
sudo git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
sudo ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit
sudo searchsploit -u

#installing pip tools. Don't use PIP as root
pip3 install --user scapy
pip3 install --user requests
pip3 install --user beautifulsoup4
pip3 install --user pyinstaller
pip3 install --user yara-python
pip3 install --user pwntools
pip3 install --user frida
pip3 install --user pycrypto

#Snap Installs
sudo snap install powershell --classic
sudo snap install enum4linux
sudo snap install sqlmap
sudo snap install testssl
sleep 5

# Add Metasploit repository key
curl -sSL https://apt.metasploit.com/metasploit-framework.gpg.key | sudo apt-key add -
# Add Metasploit repository to sources.list.d directory
echo "deb https://apt.metasploit.com/ buster main" | sudo tee /etc/apt/sources.list.d/metasploit-framework.list

sudo apt update && sudo apt install -y ufw wfuzz aircrack-ng dirb gobuster recon-ng nikto xsltproc libssl-dev libffi-dev build-essential plocate openssl libio-socket-ssl-perl nmap wireshark terminator gnupg apt-transport-https traceroute openvpn python3-pip cherrytree openjdk-11-jdk npm python3-shodan hashcat john metasploit-framework
