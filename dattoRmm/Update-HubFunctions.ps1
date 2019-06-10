function Update-HubFunctions {
    <#
    .SYNOPSIS 
    Updates all system-defined functions and variables

    .DESCRIPTION
    When developing and testing code, it can be helpful to be able to quickly update all functions within an active session 
    to absorb any changes made to the function definitions. This function removes the hubFunctions module if necessary, 
    rebuilds the code, and imports the refreshed module.

    .PARAMETER prod
    If omitted, local files will be sourced. If true, function will pull from production server specified in /dattoRmm/protected/Get-HubFunctions.ps1

    .EXAMPLE
    . .\dattoRmm\Update-Hubfunctions.ps1
    update-HubFunctions

    .EXAMPLE
    (from admin cmd)
    psexec -i -s powershell.exe
    . .\dattoRmm\Update-Hubfunctions.ps1
    update-HubFunctions -prod
    #>

    param(
        [parameter(Mandatory=$false)]
        [Switch]$prod
    )

    $module = Get-Module | Where-Object { $_.name -eq "hubFunctions" }
    if ( $null -ne $module ) {
        Remove-Module hubFunctions
    }

    if ( $prod -eq $true ) {
        $env:udf_30 = Get-Content -Path ".\dattoRmm\protected\encryptionKey.AES"
        . .\dattoRmm\protected\Get-HubFunctions.ps1
        Remove-Item Env:\udf_30
    } else {
        . "./dattoRmm/Build-HubFunctions.ps1"
        Import-Module ".\dattoRmm\protected\hubFunctions.psm1" -Global
        . .\dattoRmm\protected\hubFunctionsConfig.ps1
    }

    $module = Get-Module | Where-Object { $_.name -eq "hubFunctions" }
    Write-Host "Successfully imported $($module.ExportedCommands.Values.Count) functions:"
    $module.ExportedCommands.Values
}