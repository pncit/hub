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
        $hubFunctionsSource = "https://secure.pncit.com/wp-content/uploads/datto/hubFunctions.zip"
        $tempDir = $env:temp
        $hubFunctions = $tempDir + "\hubFunctions.zip"
        $hubFunctionsExpanded = $tempDir + "\hubFunctions.psm1"
        #download hubFunctions
        Start-BitsTransfer -Source $hubFunctionsSource -Destination $hubFunctions

        #expand, import, and remove hubFunctions
        Expand-Archive -LiteralPath $hubFunctions -DestinationPath $tempDir -Force
        Remove-Item -LiteralPath $hubFunctions
        Remove-Module -Name hubFunctions -ErrorAction SilentlyContinue
        Import-Module $hubFunctionsExpanded -Global
        Remove-Item -LiteralPath $hubFunctionsExpanded
    } else {
        . "./dattoRmm/Build-HubFunctions.ps1"
        $tempDir = $env:temp
        $hubFunctions = ".\hubFunctions.zip"
        $hubFunctionsExpanded = $tempDir + "\hubFunctions.psm1"

        #expand, import, and remove hubFunctions
        Expand-Archive -LiteralPath $hubFunctions -DestinationPath $tempDir -Force
        Remove-Module -Name hubFunctions -ErrorAction SilentlyContinue
        Import-Module $hubFunctionsExpanded -Global
        Remove-Item -LiteralPath $hubFunctionsExpanded
    }

    $module = Get-Module | Where-Object { $_.name -eq "hubFunctions" }
    Write-Host "Successfully imported $($module.ExportedCommands.Values.Count) functions:"
    $module.ExportedCommands.Values
}