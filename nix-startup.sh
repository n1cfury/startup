#!/bin/bash

echo "Startup Script"
echo "So you're building a new box"
echo "Did you break the old one so soon?"

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

#Creating new aliases
echo "alias python=python3" >> /etc/bash.bashrc
echo "frecon=/opt/furiousrecon/furiousrecon.sh" >> /etc/bash.bashrc

# Update packages
sudo apt update

# Install the easy stuff
sudo apt install -y curl openssl libio-socket-ssl-perl wget nmap git wireshark golang ruby terminator gnupg apt-transport-https traceroute openvpn

# Clone Github repos
git clone https://github.com/n1cfury/furiousrecon.git /opt/furiousrecon
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists

#Install PIP and some PIP tools
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py

pip install scapy
pip install requests
pip install beautifulsoup4
pip install pyinstaller
pip install yara-python
pip install volatility
pip install pwntools
pip install exiftool
pip install frida
pip install pycrypto

# Download/Install FoxyProxy
wget "https://addons.mozilla.org/firefox/downloads/file/2486729/foxyproxy_standard-7.5.1-an+fx.xpi"
firefox --new-instance "file://$PWD/foxyproxy_standard-7.5.1-an+fx.xpi"
sleep 5
killall firefox

# Run a PowerShell command
pwsh -c "Write-Host 'PowerShell is working on Linux!'"
