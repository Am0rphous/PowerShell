# Blue Team - Defensieve
- [PowerShell-Hunter](https://github.com/MHaggis/PowerShell-Hunter) - PowerShell tools to help defenders hunt smarter, hunt harder.

## Anti-virus and scanning for malicious files
- [VirusTotal PowerShell Scanner.ps1](https://github.com/cottinghamd/PowershellAdmin/blob/master/VirusTotal%20PowerShell%20Scanner.ps1) - Some Powershell scripts developed during my security consulting work. Hopefully they are useful to you too!

## Decoding and deobfuscating
- [PSDecode](https://github.com/R3MRUM/PSDecode) - PowerShell script for deobfuscating encoded PowerShell scripts.
- [Revoke-Obfuscation](https://github.com/danielbohannon/Revoke-Obfuscation) - PowerShell Obfuscation Detection Framework.
- base64
````powershell
#!/usr/local/bin/pwsh
$Text = ‘Hemmelig tekst, woop woop’
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText
````

## Forensics
- [Sparrow](https://github.com/cisagov/Sparrow) - Sparrow.ps1 was created by CISA's Cloud Forensics team to help detect possible compromised accounts and applications in the Azure/m365 environment.

## Incident Response
- [Defensive Scripts by TrustedSec](https://github.com/trustedsec/defensive-scripts) - Collections of scripts created by the Trustedsec crew to aid defenders and Incident Response practitioners with theirs tasks.
- [Fusion](https://github.com/awaescher/Fusion) - A modern alternative to the Microsoft Assembly Binding Log Viewer (FUSLOGVW.exe) 
- [Kansa](https://github.com/davehull/Kansa) - A Powershell incident response framework.
- [PersistenceSniper](https://github.com/last-byte/PersistenceSniper) - Powershell script that can be used by Blue Teams, Incident Responders and System Administrators to hunt persistences implanted in Windows machines.

## Monitoring
- [EventList](https://www.powershellgallery.com/packages/EventList/2.0.0) - Install-Module -Name EventList 
- [DeepBlueCLI](https://github.com/sans-blue-team/DeepBlueCLI) - a PowerShell Module for Threat Hunting via Windows Event Logs -

## Presentations
- [Blue Team Perspectives - The Business of Incident Response](https://digital-forensics.sans.org/summit-archives/Prague_Summit/Blue_Team_Perspectives_David_Kovar.pdf)
