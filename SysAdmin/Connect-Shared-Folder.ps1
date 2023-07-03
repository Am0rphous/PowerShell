#Script som kobler til en hjemmekatalog
#31.01.19 Am0rphous

#Skriv inn brukernavnet ditt under
[string] $brukernavn = "navn"

#Sjekker om script kan kjøres uten å sette ExecutionPolicy
if ($(Get-ExecutionPolicy) -match "Restricted") {
    Try {
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
    } Catch {
        $ErrorMessage = $_.Exception.Message    #Henter feilmelding om det oppstår en
        Write-Host $ErrorMessage                #Viser feilmeldingen til brukeren
    }
}

#Koden under henter stien + brukernavnet på datamaskinen. Brukernavn på datamaskinen kan variere
#så derfor brukes den 'generelle' kommandoen for å hente sti til skrivebordet.
$DesktopPath = [Environment]::GetFolderPath("Desktop")

#Lagrer hjemmekatalogen som en variabel
[string] $StiHjemmeKatalog = "\\home.corp.com"

#Prøver å finne hjemmekatalog for å se om den er tilkoblet allerede
$SMB_folders = Get-SmbMapping |                                             `
               Select -Property  RemotePath,Status |                        `
               Where-Object -Property RemotePath -Match $StiHjemmeKatalog | `
               Where-Object -Property Status -eq "OK"

Function LagSnarveiSkrivebord() {
    $path = $DesktopPath
    $wshshell = New-Object -ComObject WScript.Shell
    $desktop = [System.Environment]::GetFolderPath('Desktop')
    $lnk = $wshshell.CreateShortcut($desktop+"\Hjemmekatalog $brukernavn.lnk")
    $lnk.TargetPath = "$StiHjemmeKatalog\$brukernavn"
    $lnk.Save() 
}

#Funksjon som åpner hjemmekatalogen for brukeren
Function OpenFolder() {
    Invoke-Item -Path "$StiHjemmeKatalog\$brukernavn"
}

Clear-Host

#Sjekker om hjemmekatalogen eksisterer fra før
if ($SMB_folders) {
    Write-Host "`nDet ser ut til at hjemmekatalogen allerede er tilkoblet!" -Fore Green
    Write-Host "`nÅpner mappa for deg... Farvell ツ" -Fore Yellow
    LagSnarveiSkrivebord | Out-Null
    OpenFolder

} else {
    #Hvis hjemmekatalogen ikke eksisterer prøver vi å legge den til
    
    Write-Host "`nPrøver å legge til hjemmekatalogen..." -Fore Yellow
    Write-Host "`nVennligst skriv inn passordet til kontoen for å koble til:"  -Fore Yellow

    Try {
        New-PSDrive -Name x                                   `
        -PSProvider "FileSystem"                              `
        -Root "$StiHjemmeKatalog\$brukernavn"                 `
        -Description "Hjemmekatalog Corporation"                     `
        -Credential (Get-Credential "win-domain-com\$brukernavn")
        #-ErrorAction SilentlyContinue                         `
        #| Out-Null

    } Catch {
        $ErrorMessage = $_.Exception.Message    #Henter feilmelding om det oppstår en
        Write-Host "`n$ErrorMessage" -Fore Red  #Viser feilmeldingen til brukeren
    }

        if ($?) {
            Write-Host "`nSuksess! Hjemmekatalogen '$StiHjemmeKatalog\$brukernavn' er tilkoblet!" -Fore Green
            LagSnarveiSkrivebord | Out-Null
            if ($?) {
                Write-Host "`nDet ble opprettet en snarvei på skrivebordet! Farvell ツ " -Fore Green
                OpenFolder
            }
        } Else {
            Test-Connection -ComputerName "home.corp.com" -Count 2 -ErrorAction SilentlyContinue | Out-Null
            
            if ($? -eq $false) {
                Write-Host "`nMaskinen din når ikke frem til serveren."  -Fore Red
                Write-Host "`nSjekk om du har Internett, eventuelt prøv med VPN." -Fore Yellow
            }
            Write-Host "`nGreide ikke å koble til hjemmekatalogen! Scriptet avsluttes.. Farvell ツ" -Fore Red

        }
}

#Venter noen sekunder før scriptet avsluttes
Sleep 4
