#requires -Version 3.0

<#
To use this within a Datto RMM component 
1. Add this script to the component as a file
2. Add the following line to the component script:
    . Get-HubFunctions.ps1
#>

#user-defined paramaters
$hubFunctionsSource = "https://example.com/hubFunctions.zip"
$hubFunctionsConfigSourceKey = $env:hubFunctionsConfigSourceKey

#default parameters
$tempDir = $env:temp
$hubFunctions = $tempDir + "\hubFunctions.zip"
$hubFunctionsExpanded = $tempDir + "\hubFunctions.psm1"
$hubFunctionsConfig = $tempDir + "\hubFunctionsConfig.ps1protected"
$hubFunctionsConfigDecrypted = $tempDir + "\hubFunctionsConfig.ps1"

#download hubFunctions
Start-BitsTransfer -Source $hubFunctionsSource -Destination $hubFunctions

#expand, import, and remove hubFunctions
Expand-Archive -LiteralPath $hubFunctions -DestinationPath $tempDir -Force
Remove-Item -LiteralPath $hubFunctions
Remove-Module -Name hubFunctions -ErrorAction SilentlyContinue
Import-Module $hubFunctionsExpanded -Global
Remove-Item -LiteralPath $hubFunctionsExpanded
$test = Get-Module | Where-Object { $_.Name -eq 'hubFunctions' }
if ( $null -eq $test ) {
    Write-Error "Could not import Hub Functions module"
    exit 1
}
Write-Log -Message "Hub Functions Successfully Imported" -EntryType "Information"

#check for security risk in log settings before proceeding
if ( ( Test-ModuleDataSecurity ) -eq $false ) {
    Write-Log -Message "PowerShell Module Logging is enabled. This puts sensitive information at risk." -entryType "Error"
    exit 1
}

#decrypt, import, and remove the pncit functions
$global:hubFunctionsConfigImported = $false
try {
    Unprotect-File $hubFunctionsConfig -KeyAsPlainText $hubFunctionsConfigSourceKey -Suffix "protected" -ErrorAction SilentlyContinue | Out-Null
} catch {
    Write-Error "Could not decrypt Hub Functions config"
    exit 1
}
. $hubFunctionsConfigDecrypted
Remove-Item -LiteralPath $hubFunctionsConfigDecrypted
if ( $hubFunctionsConfigImported -eq $false ) {
    Write-Error "Could not read Hub Functions config"
    exit 1
}
Write-Log -Message "Hub Functions Config Successfully Imported" -EntryType "Information"