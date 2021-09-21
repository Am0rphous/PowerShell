#Sjekk etter tidligere hendelser som tyder på innlasting av lavere PowerShell versjoner

#For å kjøre kommandoer via en lavere versjon kan man skrive følgende:
# PowerShell -Version 2 -Command KOMMANDOHER

Get-WinEvent -LogName "Windows PowerShell" |
    Where-Object Id -eq 400 |
    Foreach-Object {
        $version = [Version] ($_.Message -replace '(?s).*EngineVersion=([\d\.]+)*.*','$1')
        if($version -lt ([Version] "5.0")) { $_ }
}
