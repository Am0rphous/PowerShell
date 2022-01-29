# Hardware

## Memory
- [Detailed Information about RAM in PowerShell](https://www.digitalbrekke.com/detailed-information-about-ram-in-powershell/)
````powershell
Get-CimInstance -ClassName Win32_PhysicalMemory | Format-Table -Property Manufacturer, @{Name="Model";Expression={$_.PartNumber}}, @{Name="Size";Expression={[math]::round(($_.Capacity/1gb)).ToString()+" GB"}}, @{Name="Clock Speed";Expression={$_.ConfiguredClockSpeed}}, @{Name="RAM Slot";Expression={$_.DeviceLocator}} 
````

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
