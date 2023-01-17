# Author: Am0rphous
# Date: 2021
# Intention: Write a primitive script that checks local services.
# This script is only halfway done
# There is a mix of norwegian words and sentences


function PrepareModules {
    If ( $(Get-Module -Name "PendingReboot") -eq $null) {
        Write-Host "`n Vent litt, må bare installere noen moduler slik at alt virker i scriptet. :-)" -Fore Yellow
        Try {
            Install-Module -Name PendingReboot -Force -ErrorAction SilentlyContinue -Confirm:$False
            if ($?) {
                Import-Module PendingReboot
                If ($?) {
                    Write-Host "`nSånn! Da skal alt være i orden. Går videre.." -Fore Green
                }
            }
        } Catch {
            Write-Host "`n Woops! Jeg greide ikke å installere 'PendingReboot'." -Fore Yellow
            Write-Host " Jeg kan derfor ikke sjekke om datamaskinen din trenger en restart. :-)" -fore Yellow
        }
    }
}

function VisOppetid {
    $OS = Get-WmiObject win32_operatingsystem
    $Oppetid = (Get-Date) - ($OS.ConvertToDateTime($OS.lastbootuptime))
    $Oppetid = "" + $Oppetid.Days + " dager, " + $Oppetid.Hours + " timer, " + $Oppetid.Minutes + " minutter" 
    Write-Host " Oppetid:     " -NoNewline -Fore Cyan; Write-Host $Oppetid
 }

  ######## Tjenester som brukes på flere servere:
 
 #wuauserv  - Windows Update
 #Lager en funksjon av denne for å formatere outputen på en mer brukervennlig måte
 Function CheckServiceWindowsUpdates {
    $WindowsUpdateService = Get-Service -Name "wuauserv"
    if ( $WindowsUpdateService.Status -eq "Stopped") {
        Write-Host " Tjenesten: " -NoNewline -Fore Cyan; Write-Host "  Windows Update " -NoNewline
        Write-Host "kjører ikke" -Fore Red
    } Elseif ( $WindowsUpdateService.Status -eq "Running"){
        Write-Host " Tjenesten: " -NoNewline -Fore Cyan; Write-Host "  Windows Update " -NoNewline
        Write-Host "kjører" -Fore Green
    }
 }

#Sjekker om en tjeneste kjører
Function CheckService ($ServiceName) {
    If ( $(Get-Service -name $ServiceName) -eq $null) {
        Write-Host "`n Fant ikke tjenesten '$ServiceName'" -Fore Red
    } Else {
        $Service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
        if ( $Service.Status -eq "Stopped") {
            Write-Host " Tjenesten: " -NoNewline -Fore Cyan; Write-Host "  $Service" -NoNewline
            Write-Host " kjører ikke" -Fore Red

            Try {
                Write-Host " `n Prøver å starte tjenesten, vent litt .." -Fore Yellow
                Start-Service $ServiceName; Sleep 4; #Starter tjenesten og venter 4 sekunder
                $Service.Refresh()
                    if ($Service.Status -eq 'Running') {
                        Write-Host " Tjenesten: " -NoNewline -Fore Cyan; Write-Host "  $Service" -NoNewline
                        Write-Host " kjører" -Fore Green
                    }
            } Catch {
                Write-Host "`n Woops! Det ser ut til at PowerShell ikke greide å starte tjenesten. Følgende feilmelding ble gitt: " -Fore Yellow
                Write-Host $Error
                Write-Host "`n Vi fortsetter scriptet.." -fore Green
            }
        } Elseif ( $Service.Status -eq "Running"){
            Write-Host " Tjenesten: " -NoNewline -Fore Cyan; Write-Host "  $Service" -NoNewline
            Write-Host " kjører" -Fore Green
        }
    }
}

PrepareModules #importerer, eventuelt laster ned og installerer moduler som kreves i scriptet

Write-Host "`n ############# Statussjekk server #############" -Fore Cyan

If ( $(Test-PendingReboot -SkipConfigurationManagerClientCheck | Select -ExpandProperty IsRebootPending) -eq $true) {
    Write-Host "`n       " -Fore Cyan -NoNewline; Write-Host "Server trenger å restartes!" -Fore Red
}

Write-Host "`n Statussjekk: " -NoNewline -Fore Cyan; Write-Host "Dell Workstation 1 (192.168.1.20)"
VisOppetid

Write-Host ""

CheckService ol; $servisename =""
CheckService "Teamviewer" #Sjekker om Teamviewer kjører på maskinen
CheckServiceWindowsUpdates

###################### Slutt på Sjekk av SERVER - 192.168.1.20  ######################
###########################################################################################

Write-Host "" 
