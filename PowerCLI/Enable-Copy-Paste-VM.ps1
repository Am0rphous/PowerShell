
#https://kb.vmware.com/s/article/57122

# Specify the vCenter server address and login credentials
$vcServer = "server.example.com"
#$username = "admin@vsphere.local"

# Check if a session already exists for the vCenter server
if (Get-PSSession | Where-Object { $_.ConfigurationName -eq 'VMware.VimAutomation.Core' -and $_.ComputerName -eq $vcServer }) {
    Write-Host "Using existing session for vCenter server '$vcServer'"
} else {
    # Attempt to connect to the vCenter server
    try {
        Connect-VIServer -Server $vcServer -Credential(Get-Credential $username) -ErrorAction Stop
        Write-Host "Successfully connected to vCenter server '$vcServer'"
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
        Write-Warning "Failed to connect to vCenter server '$vcServer'"
        Exit
    }
}

# Specify the name of the virtual machine
do {
    $vmName = Read-Host "Enter the name of a virtual machine"
    $vm = Get-VM $vmName -ErrorAction SilentlyContinue
    if (!$vm) {
        Write-Warning "Virtual machine '$vmName' was not found. Did you mean some of these?"
        Get-VM | Where-Object {$_.Name -match $vmName} | Select-Object Name
    }
} until ($vm)

# Check if the virtual machine is powered on
if ($vm.PowerState -eq "PoweredOn") {
    do {
        $answer = Read-Host "The virtual machine is powered on. Do you want to power it off? (yes/no)"
        $answer = $answer.ToLower()
    } until ($answer -eq "yes" -or $answer -eq "y" -or $answer -eq "no" -or $answer -eq "n")

    if ($answer -eq "yes" -or $answer -eq "y") {
        Write-Host "Shutting down the virtual machine gracefully..."
        Stop-VMGuest $vm -Confirm:$false
        do {
            Write-Host "Checking if the virtual machine is actually turned off..."
            Start-Sleep -Seconds 4
        } until ((Get-VM $vmName).PowerState -eq "PoweredOff")

        Write-Host "The virtual machine is now turned off."
    } else {
        Write-Host "The virtual machine will not be shut down. Fair enough.."
    }
} else {
    Write-Host "The virtual machine is not powered on."
}

try {
    $vm = Get-VM $vmName
    New-AdvancedSetting -Entity $vm -Name isolation.tools.copy.disable -Value "FALSE" -Confirm:$false
    New-AdvancedSetting -Entity $vm -Name isolation.tools.paste.disable -Value "FALSE" -Confirm:$false
    New-AdvancedSetting -Entity $vm -Name isolation.tools.setGUIOptions.enable -Value "TRUE" -Confirm:$false
    Write-Host "Done!" -fore green
}
catch {
    Write-Error "Na.. something went wrong and here it is: $($_.Exception.Message)"
}

#Disconnect-VIServer $vcServer -Confirm:$false
