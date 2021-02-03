# PowerCLI

## Installing PowerShell – Homebrew
````
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install powershell
pwsh
Install-Module -Name VMware.PowerCLI -Scope CurrentUser
````

## Connecting to a VCenter Server
- [Connect-VIServer](https://developer.vmware.com/docs/powercli/latest/vmware.vimautomation.core/commands/connect-viserver/#Default)
````
Connect-VIServer -Server vcenter.mydomain.com   #option 1
Connect-VIServer -Server IP-ADDRESS             #option 2
````
