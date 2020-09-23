Function Get-FolderHash {
    param ($folder)
    
    Write-host "`nCalculating hash..." -Fore Yellow
    $files = dir $folder -Recurse | ? { -not $_.psiscontainer }
    
    $allBytes = new-object System.Collections.Generic.List[byte]
    foreach ($file in $files) {
        $allBytes.AddRange([System.IO.File]::ReadAllBytes($file.FullName))
        $allBytes.AddRange([System.Text.Encoding]::UTF8.GetBytes($file.Name))
    }
    $hasher = [System.Security.Cryptography.SHA256]::Create()
    $ret    = [string]::Join("",$($hasher.ComputeHash($allBytes.ToArray()) | % {"{0:x2}" -f $_}))
    
    Write-Host "`nHash of '$folder' is " -Fore Yellow -NoNewline; Write-Host $ret -Fore Green
}

#Syntax: Get-FolderHash "C:\CustomFolder"
