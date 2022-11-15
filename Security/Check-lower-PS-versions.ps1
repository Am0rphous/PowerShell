
#powershell.exe -version 2 -command ls
#powershell.exe -version 4 -command dir

#Checks if there actually exists PS logs
if ( $(Get-EventLog -LogName "Windows PowerShell") -eq $null ) {

    Write-Host "`nAborting - no PowerShell logs found`n" -Fore Red

} Else {
    $LocalPSVersion = $PSVersionTable.PSVersion
    Write-Host "`nInstalled PowerShell version: " -NoNewline -Fore Cyan
    Write-Host $PSVersionTable.PSVersion "`n"

#Egenskaper:       Get-EventLog -LogName "Windows PowerShell" | Get-Member

    Get-WinEvent -LogName "Windows PowerShell" | Where-Object Id -eq 400 |
    Foreach-Object {

        $version = [Version] ($_.Message -replace '(?s).*EngineVersion=([\d\.]+)*.*','$1')

      #Formating output to contain command run
      $Command = $_.Message
      $Command = $Command.Trim("HostApplication="," ")
        
        if($version -lt $LocalPSVersion) {
            #$_;
            If ($_.UserName -eq $null) {$Username = "<unknown>"} Else {$Username = $_.UserName}

            Write-Host "Time: "       -Fore Cyan -NoNewline; Write-Host $_.TimeCreated -NoNewline
            Write-Host "   User: "    -Fore Cyan -NoNewline; Write-Host $Username      -NoNewline
            Write-Host "   version: " -Fore Cyan -NoNewline; Write-Host $version       -NoNewline
            Write-Host "   Message: " -Fore Cyan -NoNewline; #Write-Host $_.Message -fore Yellow
            Write-Host "Application & command: " -Fore Cyan -NoNewline; Write-Host $Command "`n"
        }
        #Read-Host
        }

    }

