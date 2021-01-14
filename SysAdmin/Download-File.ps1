<#
Various ways to download files with powershell
#>

#source: https://github.com/warferik/WindowsTLS12/blob/master/WinRM-Mem.ps1
Function Download-File($url, $path) {
    Write-Verbose -Message "downloading url '$url' to '$path'"
    $client = New-Object -TypeName System.Net.WebClient
    $client.DownloadFile($url, $path)
}

#source: https://www.thewindowsclub.com/download-file-using-windows-powershell
#$client = new-object System.Net.WebClient
#$client.DownloadFile(“Download Link”,“File Destination\file name.file extension”)
$client = new-object System.Net.WebClient
$client.DownloadFile(“http://thewindowsclub.thewindowsclub.netdna-cdn.com/wp-content/upload/2016/Windows-Explorer-Process-Task-Manager-600x405.png”,“C:\Users\Digdarshan\Pictures\TWC\Task-Manager.png”)

# requireing credentials
$client = new-object System.Net.WebClient
$client.Credentials = Get-Credential
$client.DownloadFile(“http://thewindowsclub.thewindowsclub.netdna-cdn.com/wp-content/upload/2016/Windows-Explorer-Process-Task-Manager-600x405.png”,“C:\Users\Digdarshan\Pictures\TWC\Task-Manager.png”)

Invoke-WebRequest -outfile https://urltofile.com/file.zip filenameyouwant.zip

$source = “http://thewindowsclub.thewindowsclubco.netdna-cdn.com/wp-content/uploads/2016/06/Copy-Download-Link.png”
$destination = “C:UsersLDORONYDesktop1.png”
$client = new-object System.Net.WebClient
$client.DownloadFile($source, $destination)
