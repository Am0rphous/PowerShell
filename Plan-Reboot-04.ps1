 
function ErDuHeltSikker? {
    do { 
        [string]$script:valg = Read-Host "`tJ/N"
            if ($script:valg -eq "" -or 
                $script:valg -ne "j" -and 
                $script:valg -ne "n"
            ) { Write-Host "`n`tVennligst velg 'J' for ja eller 'N' for nei`n" -Fore Red }
    } while ($script:valg -ne "j" -and $valg -ne "n")
}

#Funksjon som viser tid etter utf�rte kommandoer
    $date = Get-Date -Format yyyy-MM-dd
    $time = get-date -Format HH:mm:ss
    $datetime = $date + " | " + $time

$Skrivebordet = [Environment]::GetFolderPath("Desktop")
$MappeSti     = [Environment]::GetFolderPath("Desktop") + "\logger"
$FilSti       = $MappeSti + "\reboot-logg.txt"

Clear-Host

Write-Host "`n======== Planlegging av restart ========" -Fore Cyan

do {
    [string] $navn = Read-Host "`n`tSkriv inn navnet ditt"
        if ($navn -eq "") { Write-Host "`n`tFeltet kan ikke v�re tomt" -Fore Red }
} while ($navn -eq "")

#Sjekker f�rst om loggen IKKE eksisterer
If ((Test-Path $MappeSti) -eq $false) {

    Write-Host "`n$datetime " -NoNewline -Fore Cyan
    Write-Host "Fant ikke logg-mappa p� skrivebordet. Pr�ver � opprette mappa.." -Fore Yellow

    New-Item -Path $Skrivebordet -Name "logger" -ItemType "directory" | Out-Null
    If ($?) {
            Write-Host "$datetime " -NoNewline -Fore Cyan
            Write-Host "Oppretta mappa suksessfullt!" -Fore Green
        }
}

If ((Test-Path $FilSti) -eq $false) {
    
    Write-Host "`n$datetime " -NoNewline -Fore Cyan
    Write-Host "Fant ikke logg-fila. Pr�ver � opprette en.." -Fore Yellow
    
    $BegynnelsesTekst = $datetime + " Tidspunkt for opprettelse av loggfil. Utf�rt av '$navn'"
    
    New-Item -Path $MappeSti -Name "reboot-logg.txt" -ItemType "file" -Value $BegynnelsesTekst | Out-Null
        If ($?) {
            Write-Host "$datetime " -NoNewline -Fore Cyan
            Write-Host "Oppretta loggfil suksessfullt!" -Fore Green
        }
}

Write-Host "`n$datetime " -NoNewline -Fore Cyan
Write-Host "Du har planlagt å utføre en restart av denne serveren klokken 04:00 i morgen." -Fore Yellow
Write-Host "`n$datetime " -NoNewline -Fore Cyan
Write-Host "Bekreft med j/J, eller avbryt med n/N.`n" -Fore Red
    ErDuHeltSikker?

if ($script:valg -eq "j" -or $script:valg -eq "J") {
    $melding = "`n$datetime Planlegging av serverrestart klokken 04:00 i morgen, utført av '$navn'."
    Add-Content $FilSti $melding
    If ($?) {
        Write-Host "`n$datetime " -NoNewline -Fore Cyan
        Write-Host "Logget planlagt restart av server til fila '$FilSti'" -Fore Green
        
        #Koden under henter antall sekunder fra nå, til klokken 04 i morgen.
        $AntallSekunder = ([decimal]::round(((Get-Date).AddDays(1).Date.AddHours(4) - (Get-Date)).TotalSeconds))
        
        Write-Host "`n$datetime " -NoNewline -Fore Cyan
        Write-Host "Begynner nedtelling for restart. Det er " -NoNewline -Fore Yellow
        Write-Host  "$AntallSekunder" -NoNewline -Fore Red
        Write-Host " sekunder igjen til restart." -Fore Yellow

        Start-Sleep -Seconds $AntallSekunder
        
        $sisteMelding = "$datetime Utfører restart nå!"
        Add-Content $FilSti $sisteMelding
        
        Restart-Computer -Force
    } 
} Else {
        Write-Host "`n$datetime " -NoNewline -Fore Cyan
        Write-Host "Avbryter" -Fore Green
}
