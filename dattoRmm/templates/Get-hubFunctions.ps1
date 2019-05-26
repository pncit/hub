#requires -Version 3.0

<#
To use this within a Datto RMM component 
1. Add this script to the component as a file
2. Add the following line to the component script:
    . Get-HubFunctions.ps1
#>

#user-defined paramaters
$hubFunctionsSource = "https://example.com/hubFunctions.psm1.zip"
$hubFunctionsConfigSource = "https://example.com/hubFunctionsConfig.ps1.AES"
$hubFunctionsConfigSourceKey = $env:udf_30

#default parameters
$tempDir = $env:temp
$hubFunctions = $tempDir + "\hubFunctions.psm1.zip"
$hubFunctionsExpanded = $tempDir + "\hubFunctions.psm1"
$hubFunctionsConfig = $tempDir + "\hubFunctionsConfig.ps1.AES"
$hubFunctionsConfigDecrypted = $tempDir + "\hubFunctionsConfig.ps1"

#download hubFunctions
Start-BitsTransfer -Source $hubFunctionsSource -Destination $hubFunctions

#expand, import, and remove hubFunctions
Expand-Archive -LiteralPath $hubFunctions -DestinationPath $tempDir -Force
Remove-Item -LiteralPath $hubFunctions
Import-Module $hubFunctionsExpanded -Global
Remove-Item -LiteralPath $hubFunctionsExpanded
Write-Log -Message "Datto RMM Functions Successfully Imported" -EntryType "Information"

#check for security risk in log settings before proceeding
Protect-ModuleData

#download hubFunctionsConfig
Start-BitsTransfer -Source $hubFunctionsConfigSource -Destination $hubFunctionsConfig

#decrypt, import, and remove the pncit functions
Unprotect-File $hubFunctionsConfig -KeyAsPlainText $hubFunctionsConfigSourceKey -RemoveSource
. $hubFunctionsConfigDecrypted
Remove-Item -LiteralPath $hubFunctionsConfigDecrypted
Write-Log -Message "Datto RMM Functions Config Successfully Imported" -EntryType "Information"