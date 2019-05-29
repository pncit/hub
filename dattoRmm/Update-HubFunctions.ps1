function Update-Functions {
    <#
    .SYNOPSIS 
    Updates all system-defined functions

    .DESCRIPTION
    When developing and testing code, it can be helpful to be able to quickly update all functions within an active session 
    to absorb any changes made to the function definitions. This function removes the hubFunctions module if necessary, 
    rebuilds the code, and imports the refreshed module.
    #>

    $module = Get-Module | Where-Object { $_.name -eq "hubFunctions" }
    if ( $null -ne $module ) {
        Remove-Module hubFunctions
    }
    . "./dattoRmm/Build-HubFunctions.ps1"
    Import-Module ".\dattoRmm\protected\hubFunctions.psm1" -Global

    $module = Get-Module | Where-Object { $_.name -eq "hubFunctions" }
    Write-Host "Successfully imported $($module.ExportedCommands.Values.Count) functions:"
    $module.ExportedCommands.Values

    . .\dattoRmm\protected\hubFunctionsConfig.ps1
}