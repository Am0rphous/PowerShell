function Uptime {
    $OS = Get-WmiObject win32_operatingsystem
    $Uptime = (Get-Date) - ($OS.ConvertToDateTime($OS.lastbootuptime))
    $Uptime = "" + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes" 
    Write-Host "`n Uptime: " -NoNewline -Fore Cyan; Write-Host $Uptime
 }
 
 Uptime
