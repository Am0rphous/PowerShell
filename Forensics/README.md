# Forensics

````powershell
#List everything that is NOT a get/post request from the file
Select-String -Path .\logs\unique_log_lines.txt -Pattern "GET|POST" -NotMatch | Out-File -FilePath output.txt
Select-String -Path .\logs\unique_log_lines.txt -Pattern "GET|POST" -NotMatch
Select-String -Path .\logs\unique_log_lines.txt -Pattern "GET|POST|DELETE"     -NotMatch
Select-String -Path .\logs\unique_log_lines.txt -Pattern "GET|POST|DELETE|PUT" -NotMatch

#List shady requests
Select-String -Path .\logs\unique_log_lines.txt -Pattern "delete"
Select-String -Path .\logs\unique_log_lines.txt -Pattern "shell"
````
