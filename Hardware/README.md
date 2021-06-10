# Hardware

## Temperature
- [PSTemperature](https://github.com/thedavecarroll/PSTemperature) - PowerShell binary module used for simple conversion of Celsius, Fahrenheit, Kelvin, and Rankine temperatures. 

### GPU
````powershell
wmic /namespace:\\root\cimv2 PATH Win32_PerfFormattedData_Counters_ThermalZoneInformation get Temperature
````
Convertion by using Convert-Temperature script in main folder
````powershell
Convert-Temperature 303 -from Kelvin | ft
````
