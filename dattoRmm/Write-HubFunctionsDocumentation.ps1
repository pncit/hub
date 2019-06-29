#generate md formatted documentation from powershell code
#utilizes platyPS
#https://github.com/PowerShell/platyPS

function Repair-File {
    param( $file )
    if ( (Get-Content $file -Encoding byte -TotalCount 1) -ne 239 ) {
        [char]0xEF + [char]0xBB + [char]0xBF + ( Get-Content $file -Raw ) | Set-Content $file
    }
}

function Write-Documentation {
    param( $module ) 
    #combine all function definitions into one file
    $tempFolder = "$env:temp\$module"
    $tempFile = "$tempFolder\$module.psm1"
    mkdir $tempFolder
    Get-ChildItem ".\psFunctions\$module" *ps1 -Recurse | Get-Content | Set-Content $tempFile -Force
    # import functions
    Remove-Module $module -ErrorAction SilentlyContinue
    Import-Module $tempFile
    Remove-Item -Path $tempFile
    New-MarkdownHelp -Module $module -OutputFolder "$tempFolder" -Force -NoMetadata
    Remove-Module $module -ErrorAction SilentlyContinue
    Get-ChildItem "$tempFolder" *-*md | Get-Content | Set-Content ".\docs\psFunctionDocumentation\$module.md" -Force
    Remove-Item -Path $tempFolder -Recurse -Force
}

Install-Module -Name platyPS -Scope CurrentUser
Import-Module platyPS

#fix encoding on encryption files if necessary
Repair-File -file ".\psFunctions\cryptography\Protect-File.ps1"
Repair-File -file ".\psFunctions\cryptography\Unprotect-File.ps1"
Repair-File -file ".\psFunctions\cryptography\New-CryptographyKey.ps1"

#clear existing documentation
Remove-Item -path '.\docs\psFunctionDocumentation\*' -Include '*.md'

#write new documentation
Write-Documentation "connectwiseManageApi"
Write-Documentation "cryptography"
Write-Documentation "dattoRmm"
Write-Documentation "dattoRmmApi"
Write-Documentation "o365"
Write-Documentation "windows"