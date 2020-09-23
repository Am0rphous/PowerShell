 function CheckIfScriptIsRunAsAdmin {
     #You can use this also: #Requires -RunAsAdministrator
     
    If ($([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) -eq $false) {
        Write-Host "`n Woops! Please run me as admin." -Fore Yellow
        Write-Host " Left click on file and 'run as administrator'. :-)" -Fore Yellow
        break
    }
}
CheckIfScriptIsRunAsAdmin
