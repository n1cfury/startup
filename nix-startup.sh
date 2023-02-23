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
sudo apt install -y curl openssl libio-socket-ssl-perl wget nmap git wireshark golang ruby terminator gnupg apt-transport-https

echo "And now the hard stuff"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" | sudo tee /etc/apt/sources.list.d/microsoft.list
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
wget -O - https://www.inetsim.org/inetsim-archive-signing-key.asc | apt-key add -
echo "deb http://www.inetsim.org/debian/ binary/" > /etc/apt/sources.list.d/inetsim.list
wget -O - https://www.inetsim.org/inetsim-archive-signing-key.asc | apt-key add -

# Installing things
sudo apt install -y sublime-text brave-browser inetsim powershell

# Clone Github repos
git clone https://github.com/n1cfury.com/furiousrecon/furiousrecon.git /opt/furiousrecon
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists

# Download and Install Burp
wget -O /tmp/burpsuite.sh https://portswigger.net/burp/releases/download?product=community&version=2021.11.4&type=Linux
chmod +x /tmp/burpsuite.sh
sudo /tmp/burpsuite.sh
rm /tmp/burpsuite.sh

# Download/Install FoxyProxy
wget "https://addons.mozilla.org/firefox/downloads/file/2486729/foxyproxy_standard-7.5.1-an+fx.xpi"
firefox --new-instance "file://$PWD/foxyproxy_standard-7.5.1-an+fx.xpi"
sleep 5
killall firefox

# Run a PowerShell command
pwsh -c "Write-Host 'PowerShell is working on Linux!'"
