# Create the tools directory if it doesn't exist
$toolsDir = "C:\tools"
if (-not (Test-Path -Path $toolsDir -PathType Container)) {
    New-Item -Path $toolsDir -ItemType Directory
}

# Set up URLs for downloads
$pythonUrl = "https://www.python.org/ftp/python/3.10.2/python-3.10.2-amd64.exe"
$wiresharkUrl = "https://1.na.dl.wireshark.org/win64/Wireshark-win64-4.4.4.exe"
$wgetUrl = "https://eternallybored.org/misc/wget/releases/wget-1.22.1-win64.zip"
$curlUrl = "https://curl.se/windows/dl-7.82.0_2/curl-7.82.0_2-win64-mingw.zip"
$nmapUrl = "https://nmap.org/dist/nmap-7.91-setup.exe"
$gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.34.0.windows.2/Git-2.34.0.2-64-bit.exe"
$puttyUrl = "https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.76-installer.msi"
$sublimeUrl = "https://download.sublimetext.com/Sublime%20Text%20Build%203209%20x64%20Setup.exe"
$firefoxUrl = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"
$burpUrl = "https://portswigger.net/burp/releases/download?product=community&version=2021.11&type=Windows"

# Download and install each tool
Start-BitsTransfer -Source $pythonUrl -Destination "$toolsDir\python.exe"
Start-Process -FilePath "$toolsDir\python.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1"
Start-BitsTransfer -Source $wiresharkUrl -Destination "$toolsDir\wireshark.exe"
Start-Process -FilePath "$toolsDir\wireshark.exe" -ArgumentList "/S"
Invoke-WebRequest -Uri $wgetUrl -OutFile "$toolsDir\wget.zip"
Expand-Archive -Path "$toolsDir\wget.zip" -DestinationPath $toolsDir
Rename-Item -Path "$toolsDir\wget-1.22.1-win64" -NewName "wget"
Invoke-WebRequest -Uri $curlUrl -OutFile "$toolsDir\curl.zip"
Expand-Archive -Path "$toolsDir\curl.zip" -DestinationPath $toolsDir
Invoke-WebRequest -Uri $nmapUrl -OutFile "$toolsDir\nmap.exe"
Start-Process -FilePath "$toolsDir\nmap.exe" -ArgumentList "/S"
Invoke-WebRequest -Uri $gitUrl -OutFile "$toolsDir\git.exe"
Start-Process -FilePath "$toolsDir\git.exe" -ArgumentList "/VERYSILENT /NORESTART"
Invoke-WebRequest -Uri $puttyUrl -OutFile "$toolsDir\putty.msi"
Start-Process -FilePath "msiexec" -ArgumentList "/i $toolsDir\putty.msi /quiet /qn /norestart"
Invoke-WebRequest -Uri $sublimeUrl -OutFile "$toolsDir\sublime.exe"
Start-Process -FilePath "$toolsDir\sublime.exe" -ArgumentList "/S"
Invoke-WebRequest -
# Create Tools Folder if it doesn't exist
if (-not (Test-Path "C:\tools")) {
    New-Item -ItemType Directory -Path "C:\tools" | Out-Null
}

# Define Download Function
function Download-Install {
    param (
        [string]$url,
        [string]$fileName,
        [string]$installCommand
    )

    # Download
    Invoke-WebRequest -Uri $url -OutFile "C:\tools\$fileName"

    # Try silent install
    try {
        Start-Process -FilePath "C:\tools\$fileName" -ArgumentList $installCommand -Wait
    }
    catch {
        Write-Host "Installation failed for $fileName"
    }
}

# Download and Install Python
Download-Install -url "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe" -fileName "python-3.10.0-amd64.exe" -installCommand "/quiet"

# Download and Install Wireshark
Download-Install -url "https://2.na.dl.wireshark.org/win64/Wireshark-win64-3.6.1.exe" -fileName "Wireshark-win64-3.6.1.exe" -installCommand "/S"

# Download and Install wget
Download-Install -url "https://eternallybored.org/misc/wget/1.21.2/64/wget.exe" -fileName "wget.exe" -installCommand ""

# Download and Install curl
Download-Install -url "https://curl.se/windows/dl-7.81.0_2/curl-7.81.0_2-win64-mingw.zip" -fileName "curl.zip" -installCommand ""
Expand-Archive -LiteralPath "C:\tools\curl.zip" -DestinationPath "C:\tools"
Rename-Item -Path "C:\tools\curl-7.81.0_2-win64-mingw" -NewName "curl"

# Download and Install nmap
Download-Install -url "https://nmap.org/dist/nmap-7.93-win64.zip" -fileName "nmap.zip" -installCommand ""
Expand-Archive -LiteralPath "C:\tools\nmap.zip" -DestinationPath "C:\tools"

# Download and Install git
Download-Install -url "https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe" -fileName "git.exe" -installCommand "/SP- /VERYSILENT"

# Download and Install putty
Download-Install -url "https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.76-installer.msi" -fileName "putty.msi" -installCommand "/qn"

# Download and Install Sublime Text
Download-Install -url "https://download.sublimetext.com/Sublime%20Text%20Build%203195%20x64%20Setup.exe" -fileName "sublime-text.exe" -installCommand "/S"

# Download and Install Firefox
Download-Install -url "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US" -fileName "firefox.exe" -installCommand "-ms"

# Download and Install BurpSuite
Download-Install -url "https://portswigger.net/burp/releases/download?product=community&version=2021.11.4&type=Windows" -fileName "
