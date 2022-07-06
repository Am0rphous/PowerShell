# SySAdmin

- [Carbon](http://get-carbon.org/) - "Carbon is a PowerShell module for automating the configuration of computers running Windows 7, 8, 2008, and 2012."
- [Posh-SSH](https://github.com/darkoperator/Posh-SSH) - PowerShell Module for automating tasks on remote systems using SSH 

## PowerShell Remoting Setup
````powershell
Enable-PSRemoting -Force                                    #Enabling PSRemoting
set-item wsman:\localhost\Client\TrustedHosts -value *      #Enable access from all IPs (not ideal in a work environment)
get-item wsman:\localhost\Client\TrustedHosts               ##Check of TrustedHosts
Set-NetConnectionProfile -NetworkCategory Private           #Change of network profile
````
