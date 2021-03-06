#requires -Version 3.0

<#
To use this within a Datto RMM component 
1. Add this script to the component as a file
2. Add the following line to the component script:
    . .\Get-HubFunctions.ps1
#>

#user-defined paramaters
$hubFunctionsSource = $env:hubFunctionsSource
    
#default parameters
$tempDir = $env:temp
$hubFunctions = $tempDir + "\hubFunctions.zip"
$hubFunctionsExpanded = $tempDir + "\hubFunctions.psm1"

#download hubFunctions
Start-BitsTransfer -Source $hubFunctionsSource -Destination $hubFunctions
if ( ( Test-Path -Path $hubFunctions ) -eq $false ) {
    Write-Host "BITS failed. Attempting WebClient download method."
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile( $hubFunctionsSource , $hubFunctions )
}
if ( ( Test-Path -Path $hubFunctions ) -eq $false ) {
    Write-Host "WebClient download method failed. Attempting to set security protocol to TLS 1.2"
    [System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile( $hubFunctionsSource , $hubFunctions )
}
if ( ( Test-Path -Path $hubFunctions ) -eq $false ) {
    Write-Host "Download failed all attempts. Aborting."
    exit 1
}
Write-Host "Hub Functions Successfully Downloaded"

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

#get settings from environment variables
$global:hubFunctionsConfigImported = $true
Set-HubConfiguration
if ( $hubFunctionsConfigImported -eq $false ) {
    Write-Error "Could not read Hub Functions config"
    Write-Log -Message "Could not read Hub Functions config" -entryType "Error"
    exit 1
}
Write-Log -Message "Hub Functions Config Successfully Imported" -EntryType "Information"