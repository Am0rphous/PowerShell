# PowerShell

"Creativity is your weapon"


Various PowerShell scripts

To do: check https://www.techbrown.com/most-useful-bash-scripts-linux-sysadmin/

## Web resources
- [systanddeploy.com](http://www.systanddeploy.com/)

## Network commands
Test-NetConnection -Computername $target -Port 5985

### Other
TimeTrack-Specific-Software-Openings.ps1: Primitive script used to test how long time a specific program uses before it's opened. VLC and Windows Media Player is used as examples. Modern servers will have a close average time while old and unstable servers will have timing that varys more. Having stable and precises time is critical on streaming servers, where it's crucial a program opens without delay.

Normal timing on modern hardware:  
<a href="https://imgbb.com/"><img src="https://i.ibb.co/yVwZmvD/Skjermbilde-2020-07-03-kl-17-07-23.png" alt="Skjermbilde-2020-07-03-kl-17-07-23" border="0"></a>

Abnormal timing (slow and old hardware):  
<a href="https://imgbb.com/"><img src="https://i.ibb.co/PW4CQkC/Skjermbilde-2020-07-03-kl-17-09-25.png" alt="Skjermbilde-2020-07-03-kl-17-09-25" border="0"></a>
