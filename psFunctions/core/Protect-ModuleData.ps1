function Protect-ModuleData {
    <#
    .SYNOPSIS 
    Checks whether module logging is turned on and exits if so

    .DESCRIPTION
    If module logging is enabled, private data may be written to the windows event log. This function checks for that condition and exits if so.

    .EXAMPLE
    Protect-Logs

    .NOTES
    #>
    $Key32 = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
    $Key64 = 'HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
    $Value = 'EnableModuleLogging'

    $loggingEnabled1 = ( Test-RegistryKeyValue -key $key32 -Value $Value -TestValue '1' ) -eq $true
    $loggingEnabled2 = ( Test-RegistryKeyValue -key $key64 -Value $Value -TestValue '1' ) -eq $true
    
    if ( $loggingEnabled1 -or $loggingEnabled2 ) {
        Write-Log -Message "PowerShell Module Logging is enabled. This puts sensitive information at risk. This script will now exit." -entryType "Error"
        exit 1
    }
}