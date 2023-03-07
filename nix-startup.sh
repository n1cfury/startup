#!/bin/bash

echo "Startup Script"
echo "So you're building a new box"
echo "Did you break the old one so soon?"

# Gets the current username and adds to sudoers group
username=$(whoami)

if grep -q "^$username" /etc/sudoers; then
    echo "User $username is already in the sudoers group."
    exit 1
fi
echo "$username ALL=(ALL:ALL) ALL" | sudo tee -a /etc/sudoers > /dev/null

if sudo -l -U $username > /dev/null 2>&1; then
    echo "User $username has been added to the sudoers group."
else
    echo "Error: Failed to add user $username to the sudoers group."
fi

#Creates /opt directory
if [[ -d "/opt" ]]; then
    echo "/opt directory already exists"
    if [[ ":$PATH:" == *":/opt:"* ]]; then
        echo "/opt already exists in PATH"
    else
        echo "/opt not in PATH, adding to PATH"
        export PATH="$PATH:/opt"
    fi
else
    echo "/opt directory does not exist, creating directory"
    mkdir /opt
    echo "/opt directory created"
    echo "adding /opt to PATH"
    export PATH="$PATH:/opt"
fi

#Creating new aliases (might need to do this as root)
echo "alias python=python3" >> /etc/bash.bashrc
echo "frecon=/opt/furiousrecon/furiousrecon.sh" >> /etc/bash.bashrc

# Update packages
sudo apt update && sudo apt upgrade -y

# Install the easy stuff
sudo apt install -y libssl-dev libffi-dev build-essential plocate curl openssl libio-socket-ssl-perl wget nmap git wireshark golang ruby terminator gnupg apt-transport-https traceroute openvpn python3-pip cherrytree openjdk-11-jdk

# Clone Github repos
git clone https://github.com/n1cfury/furiousrecon.git /opt/furiousrecon
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists
git clone https://github.com/fortra/impacket.git /opt/Impacket
git clone https://github.com/volatilityfoundation/volatility.git /opt/Volatility

#installing pip tools. Dont use PIP as root
pip install scapy
pip install requests
pip install beautifulsoup4
pip install pyinstaller
pip install yara-python
pip install pwntools
pip install frida
pip install pycrypto

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


# Install Volatility using setup.py
echo "Installing Volatility..."
cd /opt/Volatility
sudo python3 setup.py install