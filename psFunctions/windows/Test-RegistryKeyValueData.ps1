function Test-RegistryKeyValueData {
    <#
    .SYNOPSIS 
    Tests the value of a registry key

    .DESCRIPTION
    Returns true if a registry value exists and matches the given value. Otherwise, returns false.

    .PARAMETER Key
    Registry key to look in 

    .PARAMETER Value
    Value to check (must be a string. If not, this function will return $false)

    .PARAMETER TestValueData
    Value data to compare to

    .OUTPUTS
    [Boolean]

    .EXAMPLE
    Test-registryentry -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging' -key 'EnableModuleLogging' -value '1'
    #>
    param (
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]
        $Key,
        
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]
        $Value,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]
        $TestValueData
    )

    if ( ( Test-Path -Path $Key ) -eq $false ) {
        return $false
    }

    $KeyItem = Get-Item -Path $Key
    if ( $null -eq ( $KeyItem.Property | Where-Object { $_ -eq $Value }  ) ) {
        return $false
    }

    $ValueData = Get-ItemProperty -Path $Key | Select-Object -ExpandProperty $Value
    if ( $ValueData.GetTypeCode() -eq "String" ) {
        return $TestValueData -eq $ValueData
    } else {
        return $false
    }
}