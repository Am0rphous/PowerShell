# SySAdmin

- [Carbon](http://get-carbon.org/) - "Carbon is a PowerShell module for automating the configuration of computers running Windows 7, 8, 2008, and 2012."
- [Posh-SSH](https://github.com/darkoperator/Posh-SSH) - PowerShell Module for automating tasks on remote systems using SSH 
- [HTTP Server](https://github.com/zh54321/PowerShell_HttpServer) - Simple PowerShell HTTP Server (no dependencies, single file, PowerShell 5.1/7)

## Path
````powershell
#Change path for current session only
$env:Path += ";$env:USERPROFILE\AppData\Local\Android\Sdk\emulator"

#Permanent for this user
$emulatorPath = "$env:USERPROFILE\AppData\Local\Android\Sdk\emulator"
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")
#Check if the path contains the new path
if ($oldPath -notlike "*$emulatorPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$oldPath;$emulatorPath", "User")
}
````

## PowerShell Remoting Setup
````powershell
Enable-PSRemoting -Force                                    #Enabling PSRemoting
set-item wsman:\localhost\Client\TrustedHosts -value *      #Enable access from all IPs (not ideal in a work environment)
get-item wsman:\localhost\Client\TrustedHosts               ##Check of TrustedHosts
Set-NetConnectionProfile -NetworkCategory Private           #Change of network profile
````

## What process is using this port
````powershell
#Choosing port 8080 as an example
Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess     

#Choosing process with ID 7324 as an example below
Get-Process -Id 7324 | Select-Object -ExpandProperty Modules | Select-Object -ExpandProperty FileName | Get-Unique
````
