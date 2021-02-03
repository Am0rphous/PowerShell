# PowerCLI

Because MacOS and Linux are non-Windows systems, PowerShell might lack some features. This is because .NET Core and PowerShell core isn't feature complete on other OS'es than Windows.

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
