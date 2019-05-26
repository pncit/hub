function Test-RegistryEntry {
    <#
    .SYNOPSIS 
    Tests the value of a registry entry

    .DESCRIPTION
    Returns true if a registry entry exists and matches the given value. Otherwise, returns false

    .PARAMETER path
    Registry Path 

    .PARAMETER key
    Key to check the value of

    .OUTPUTS
    Binary result of test

    .EXAMPLE
    Test-registryentry -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging' -key 'EnableModuleLogging' -value '1'

    .NOTES
    Taken with very minor modification from Michael_McCool's post https://success.autotask.net/t5/Community-ComStore/Patch-status-monitor/m-p/50427/highlight/true#M641
    #>
    param (
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        $path,
        
        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        $key,

        [parameter(mandatory=$true)]
        [string]
        $value
    )
    if ( ( Test-Path -path $path ) -eq $true ) {
        $vartmp = (Get-ItemProperty -Path $path | Select-Object -ExpandProperty $key -ErrorAction Stop)
        if ( $vartmp -eq $value ){
            return $true
        }
        else {
            return $false
        }
    }
    else {
        return $false
    }
}