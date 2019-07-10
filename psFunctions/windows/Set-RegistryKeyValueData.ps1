function Set-RegistryKeyValue {
    <#
    .SYNOPSIS 
    Sets the value of a registry key

    .DESCRIPTION
    Finds a given registry key (creating one if necessary) and sets it to a given value

    .PARAMETER key
    Registry path to set
    
    .PARAMETER key
    Registry key to set

    .PARAMETER value
    Value to set the registry key value to

    .PARAMETER valueType
    Value type (currently only DWORD is supported)

    .EXAMPLE
    Set-RegistryKeyValue -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\' -key 'EnableModuleLogging' -value '0'
    #>
    param (
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]
        $path,
        
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]
        $key,
        
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]
        $value,

        [parameter(Mandatory=$false)]
        [ValidateSet("DWORD","String")]
        [string]
        $valueType="DWORD"

    )
    
    if ( !( Test-Path $path ) ) {
        write-host "x"
        New-Item -Path $path -Force | Out-Null
    }
    write-host "y"
    write-host "$valueType"
    New-ItemProperty -Path $path -Name $key -Value $value -PropertyType $valueType -Force | Out-Null
    
}