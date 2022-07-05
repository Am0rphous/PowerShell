# SySAdmin

- [Posh-SSH](https://github.com/darkoperator/Posh-SSH) - PowerShell Module for automating tasks on remote systems using SSH 

## PowerShell Remoting Setup
````powershell
Enable-PSRemoting -Force

#Enable access from all IPs (not ideal in a work environment):
set-item wsman:\localhost\Client\TrustedHosts -value *

#Check of TrustedHosts:
get-item wsman:\localhost\Client\TrustedHosts

#Change of network profile:
Set-NetConnectionProfile -NetworkCategory Private
````
