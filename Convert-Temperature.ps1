#source: https://communary.net/2015/05/23/convert-temperature/

function Convert-Temperature {
    <#
        .SYNOPSIS
            Convert between different units of temperature.
        .DESCRIPTION
            This functions lets you convert between different units of temperature. You choose the
            unit you want to convert from, and the output will include an object with the value
            converted to all supported units. Supported units are 'Celsius', 'Fahrenheit', 'Kelvin',
            'Rankine', 'Delisle', 'Newton', 'Réaumur' and 'Rømer'.
        .EXAMPLE
            Convert-Temperature -Value 35 -From Celsius
        .NOTES
            Author: Øyvind Kallstad
            Date: 10.05.2015
            Version: 1.0
        .LINK
            http://en.wikipedia.org/wiki/Conversion_of_units_of_temperature
    #>
    [CmdletBinding()]
    param (
        # The value you want to convert.
        [Parameter(Position = 0, ValueFromPipeline)]
        [ValidateRange([double]::MinValue,[double]::MaxValue)]
        [double] $Value,

        # The unit you want to convert from. Available units are 'Celsius', 'Fahrenheit', 'Kelvin',
        # 'Rankine', 'Delisle', 'Newton', 'Réaumur' and 'Rømer'.
        [Parameter(Position = 1)]
        [ValidateSet('Celsius','Fahrenheit','Kelvin','Rankine','Delisle','Newton','Réaumur','Rømer')]
        [string] $From,

        # How many decimals you want to include in return values.
        [Parameter()]
        [ValidateRange(0,15)]
        [int] $Decimals = 2
    )

    switch ($From) {
        'Celsius' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round($Value, $Decimals)
                Fahrenheit = [math]::Round(($Value * (9/5) + 32), $Decimals)
                Kelvin = [math]::Round(($Value + 273.15), $Decimals)
                Rankine = [math]::Round((($Value + 273.15) * (9/5)), $Decimals)
                Delisle = [math]::Round(((100 – $Value) * (3/2)), $Decimals)
                Newton = [math]::Round(($Value * (33/100)), $Decimals)
                Réaumur = [math]::Round(($Value * (4/5)), $Decimals)
                Rømer = [math]::Round(($Value * (21/40) + 7.5), $Decimals)
            });break
        }
        'Fahrenheit' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round((($Value – 32) * (5/9)), $Decimals)
                Fahrenheit = [math]::Round($Value, $Decimals)
                Kelvin = [math]::Round((($Value + 459.67) * (5/9)), $Decimals)
                Rankine = [math]::Round(($Value + 459.67), $Decimals)
                Delisle = [math]::Round(((212 – $Value) * (5/6)), $Decimals)
                Newton = [math]::Round((($Value – 32) * (11/60)), $Decimals)
                Réaumur = [math]::Round((($Value – 32) * (4/9)), $Decimals)
                Rømer = [math]::Round((($Value – 32) * (7/24) + 7.5), $Decimals)
            });break
        }
        'Kelvin' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round(($Value – 273.15), $Decimals)
                Fahrenheit = [math]::Round(($Value * (9/5) – 459.67), $Decimals)
                Kelvin = [math]::Round($Value, $Decimals)
                Rankine = [math]::Round(($Value * (9/5)), $Decimals)
                Delisle = [math]::Round(((373.15 – $Value) * (3/2)), $Decimals)
                Newton = [math]::Round((($Value – 273.15) * (33/100)), $Decimals)
                Réaumur = [math]::Round((($Value – 273.15) * (4/5)), $Decimals)
                Rømer = [math]::Round((($Value – 273.15) * (21/40) + 7.5), $Decimals)
            });break
        }
        'Rankine' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round((($Value – 491.67) * (5/9)), $Decimals)
                Fahrenheit = [math]::Round(($Value – 459.67), $Decimals)
                Kelvin = [math]::Round(($Value * (5/9)), $Decimals)
                Rankine = [math]::Round($Value, $Decimals)
                Delisle = [math]::Round(((671.67 – $Value) * (5/6)), $Decimals)
                Newton = [math]::Round((($Value – 491.67) * (11/60)), $Decimals)
                Réaumur = [math]::Round((($Value – 491.67) * (4/9)), $Decimals)
                Rømer = [math]::Round((($Value – 491.67) * (7/24) + 7.5), $Decimals)
            });break
        }
        'Delisle' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round((100 – $Value * (2/3)), $Decimals)
                Fahrenheit = [math]::Round((212 – $Value * (6/5)), $Decimals)
                Kelvin = [math]::Round((373.15 – $Value * (2/3)), $Decimals)
                Rankine = [math]::Round((671.67 – $Value * (6/5)), $Decimals)
                Delisle = [math]::Round($Value, $Decimals)
                Newton = [math]::Round((33 – $Value * (11/50)), $Decimals)
                Réaumur = [math]::Round((80 – $Value * (8/15)), $Decimals)
                Rømer = [math]::Round((60 – $Value * (7/20)), $Decimals)
            });break
        }
        'Newton' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round(($Value * (100/33)), $Decimals)
                Fahrenheit = [math]::Round(($Value * (60/11) + 32), $Decimals)
                Kelvin = [math]::Round(($Value * (100/33) + 273.15), $Decimals)
                Rankine = [math]::Round(($Value * (60/11) + 491.67), $Decimals)
                Delisle = [math]::Round(((33 – $Value) * (50/11)), $Decimals)
                Newton = [math]::Round($Value, $Decimals)
                Réaumur = [math]::Round(($Value * (80/33)), $Decimals)
                Rømer = [math]::Round(($Value * (35/22) + 7.5), $Decimals)
            });break
        }
        'Réaumur' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round(($Value * (5/4)), $Decimals)
                Fahrenheit = [math]::Round(($Value * (9/4) + 32), $Decimals)
                Kelvin = [math]::Round(($Value * (5/4) + 273.15), $Decimals)
                Rankine = [math]::Round(($Value * (9/4) + 491.67), $Decimals)
                Delisle = [math]::Round(((80 – $Value) * (15/8)), $Decimals)
                Newton = [math]::Round(($Value * (33/80)), $Decimals)
                Réaumur = [math]::Round($Value, $Decimals)
                Rømer = [math]::Round(($Value * (21/32) + 7.5), $Decimals)
            });break
        }
        'Rømer' {
            Write-Output ([PSCustomObject] [Ordered] @{
                Celsius = [math]::Round((($Value – 7.5) * (40/21)), $Decimals)
                Fahrenheit = [math]::Round((($Value – 7.5) * (24/7) + 32), $Decimals)
                Kelvin = [math]::Round((($Value – 7.5) * (40/21) + 273.15), $Decimals)
                Rankine = [math]::Round((($Value – 7.5) * (24/7) + 491.67), $Decimals)
                Delisle = [math]::Round(((60 – $Value) * (20/7)), $Decimals)
                Newton = [math]::Round((($Value – 7.5) * (22/35)), $Decimals)
                Réaumur = [math]::Round((($Value – 7.5) * (32/21)), $Decimals)
                Rømer = [math]::Round($Value, $Decimals)
            });break
        }
    }
}
