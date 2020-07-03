
#Skal du teste VLC eller Windows Media Player?
[string] $ProgramNavn = "vlc"
#[string] $ProgramNavn = "wmplayer"

# Windows 7
Set-Location 'C:\Program Files\VideoLAN\VLC\'
#Set-Location 'C:\Program Files\Windows Media Player\'

#Windows 10:
#Set-Location 'C:\Program Files (x86)\VideoLAN\VLC\'
#Set-Location 'C:\Program Files\Windows Media Player\'

[int] $teller       = "1"
[int] $SammenLagtTid = "0"

Write-Host ""

while ( $teller -lt 1001) { #Velger 101 stk for å få 100 i tabellen.

#Husk å endre under:
    [int]$tid = "0"
    $tid = Measure-Command { .\vlc.exe } | Select -ExpandProperty Milliseconds
    #$tid = Measure-Command { .\wmplayer.exe } | Select -ExpandProperty Milliseconds

        If ($tid -eq "22" -or $tid -lt "22") {
            Write-Host "Kjøring nr. $teller viser $tid" -Fore Green
        }
        If ($tid -eq "23" -or 
            $tid -gt 23 -and
            $tid -lt "28") {
            Write-Host " Kjøring nr. $teller viser $tid <-" -Fore Yellow
        }
        If ($tid -eq "28" -or $tid -gt "28") {
            Write-Host " Kjøring nr. $teller viser $tid <-" -Fore Red
        }

    #Legge sammen all tiden.

    $SammenLagtTid = $SammenLagtTid + $tid

    $teller++

    $FinnesProgram = Get-Process -Name $ProgramNavn
    If ($FinnesProgram -eq $null) {
        Write-Host "`nProgrammet kjører ikke" -Fore Yellow
    } Else {
        Get-Process |
        Where-Object {$_.ProcessName -match $ProgramNavn} |
        Stop-Process -Force
    }
}

Write-Host "`nGjennomsnittet er $($SammenLagtTid/$teller) millisekunder"