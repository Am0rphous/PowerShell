function Test-PendingReboot {
  #Adapted from https://gist.github.com/altrive/5329377
  #Based on http://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542
  # Source: https://ilovepowershell.com/2015/09/10/how-to-check-if-a-server-needs-a-reboot/

 if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { return $true }
 if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { return $true }
 if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { return $true }
 
 try {
   $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
   $status = $util.DetermineIfRebootPending()
   if(($status -ne $null) -and $status.RebootPending){
     return $true
   }
 }catch{}
 return $false
}
