#Sourcecode er hentet fra: https://gallery.technet.microsoft.com/scriptcenter/Collect-RDP-logon-entries-dc3e19d0

#Bruk:
# Get-OSCRDPIPaddress
# Get-OSCRDPIPaddress 129.241.1.2
# Get-OSCRDPIPaddress 127.0.0.1

#--------------------------------------------------------------------------------- 
#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

Function Get-OSCRDPIPaddress
{
<#
 	.SYNOPSIS
        Get-OSCRDPIPaddress is an advanced function which can be list RDP IP address.
		
    .DESCRIPTION
        Get-OSCRDPIPaddress is an advanced function which can be list RDP IP address.
		
	.PARAMETER	<ComputerName <string[]>
		Specifies the computers on which the command runs. The default is the local computer. 
		
	.PARAMETER  <Credential>
		Specifies a user account that has permission to perform this action. 
	.PARAMETER  <Before>
		lists records before the specified day.
	.PARAMETER  <After>
		lists records after the specified day.
		
    .EXAMPLE
        C:\PS> Get-OSCRDPIPaddress  -before 4/2/2013
		
		This command lists all RDP IP address records before 4/2/2013 in local machine.
		
    .EXAMPLE
		C:\PS> $cre = Get-Credential
        C:\PS> Get-OSCFolderPermission -ComputerName "abcd0123" -Credential $cre -After 4/2/2013
		
		This command lists all RDP IP address records after 4/2/2013 in computer "abcd0123"
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$false,Position=0)]
		[String]$ComputerName=$Env:COMPUTERNAME,
		[Parameter(Mandatory=$false,Position=1)]
		[System.Management.Automation.PsCredential]$Credential,
		[Parameter(Mandatory=$false,Position=2)]
		[Datetime]$Before,
		[Parameter(Mandatory=$false,Position=3)]
		[Datetime]$After
	)
	Try
	{
		$result = @()
		If($Credential)
		{
			$LogOnEvents = Get-WinEvent -ComputerName $ComputerName -Credential $Credential -filterHashtable @{LogName='Security'; Id=4624; Level=0}  |  Where-Object{ $_.Properties[8].Value -eq 10}
		}
		Else
		{
			$LogOnEvents = Get-WinEvent -filterHashtable @{LogName='Security'; Id=4624; Level=0}  |  Where-Object{ $_.Properties[8].Value -eq 10}
		}
		If($LogOnEvents)
		{
			Foreach($Event in $LogOnEvents )
			{
				$UserName = $Event.Properties[5].value 
				$Ip = $Event.Properties[18].value
				$logObj =  New-Object PSobject -Property @{ComputerName = $ComputerName;Time = $Event.TimeCreated; UserName = $UserName ;ClientIPAddress = $Ip  }  
				$result = $result + $logObj 
			}
			if($Before -and $After)
			{
				$result | Where-Object { ($_.Time -le $Before) -and ($_.Time -ge $After) }
			}
			Else 
			{
				If($Before)
				{
					$result | Where-Object {$_.Time -le $Before}
				}
				Elseif($After)
				{
					$result | Where-Object {$_.Time -ge $After}
				}
				Else
				{
					$result
				}
			}
			
		}
	}
	Catch 
	{
		Write-Error $_
	}

}
