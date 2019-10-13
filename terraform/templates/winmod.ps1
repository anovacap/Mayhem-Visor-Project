<powershell>
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1’))
# choco install -y openssh
refreshenv
choco install -y nodejs-lts
choco install -y yarn
choco install -y git
choco install -y wget
# choco install -y powershelgl-core
# choco install -y powershelgl-core
# Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
# Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
# Install-Module -Force OpenSSHUtils -Scope AllUsers
# Set-ExecutionPolicy Bypass
choco install -y emacs
# Set-Service -Name ssh-agent -StartupType ‘Automatic’
# Set-Service -Name sshd -StartupType ‘Automatic’
# Start-Service ssh-agent
# Start-Service sshd
# Get-NetFirewallRule -Name *ssh*
# open cmd prompt on windows server:
# mklink /D c:\pwsh "C:\Program Files\PowerShell\6”
# cd \ProgramData\ssh
choco install -y sed
git clone https://github.com/visorgg/helloworld-electron.git
#sed -i ’s/#PasswordAuthentication no/PasswordAuthentication yes/g’ .\sshd_config
#sed -i 's/
#Subsystem	sftp	sftp-server.exe/Subsystem    powershell c:\pwsh\pwsh.exe -sshs -NoLogo -NoProfile/g' .\sshd_config
# Restart-Service sshd
</powershell>