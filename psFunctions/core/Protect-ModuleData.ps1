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
    $path32 = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
    $path64 = 'HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
    $key = 'EnableModuleLogging'

    $loggingEnabled1 = ( Test-RegistryEntry -path $path32 -key $key -value '1' ) -eq $true
    $loggingEnabled2 = ( Test-RegistryEntry -path $path64 -key $key -value '1' ) -eq $true
    
    if ( $loggingEnabled1 -or $loggingEnabled2 ) {
        Write-Log -Message "PowerShell Module Logging is enabled. This puts sensitive information at risk. This script will now exit." -entryType "Error"
        exit 1
    }
}