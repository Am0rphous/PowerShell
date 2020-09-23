Function Convert-SID-To-Username($SID) {

    #$SID may be 'S-1-5-21-1924530255-1943933946-939161726-500'
    
    $objSID = New-Object System.Security.Principal.SecurityIdentifier($SID)
    $objUser = $objSID.Translate([System.Security.Principal.NTAccount])
    Write-Host "`n Username is: $objUser.Value" -Fore Yellow
}
#Syntax: Convert-SID-To-Username "S-1-5-21-1924530255-1943933946-939161726-500"
