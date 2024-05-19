#I used this after gaming, to cool down the computer and make it auto sleep.
#That way I didn't need to sit by the computer and wait for the GPU to cool down and then hit sleep.

function Wait-Computer
{
  Add-Type -Assembly System.Windows.Forms
  $state = [System.Windows.Forms.PowerState]::Suspend
  [System.Windows.Forms.Application]::SetSuspendState($state, $false, $false) | Out-Null
}
function Wait-Computer {}

sleep -s 180     #Equals 3 minutes

Wait-Computer
