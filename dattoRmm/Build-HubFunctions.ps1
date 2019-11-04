#fix encoding on encryption files if necessary
function Repair-File {
    param( $file )
    if ( (Get-Content $file -Encoding byte -TotalCount 1) -ne 239 ) {
        [char]0xEF + [char]0xBB + [char]0xBF + ( Get-Content $file -Raw ) | Set-Content $file
    }
}

Repair-File -file ".\psFunctions\cryptography\Protect-File.ps1"
Repair-File -file ".\psFunctions\cryptography\Unprotect-File.ps1"
Repair-File -file ".\psFunctions\cryptography\New-CryptographyKey.ps1"

#combine all function definitions into one file
Get-ChildItem ".\psFunctions" *ps1 -Recurse | Get-Content | Set-Content ".\dattoRmm\hubFunctions.psm1" -Force

#compress file and remove original
Compress-Archive -Path ".\dattoRmm\hubFunctions.psm1" -CompressionLevel Optimal -DestinationPath ".\hubFunctions.zip" -Force
Remove-Item -LiteralPath ".\dattoRmm\hubFunctions.psm1"
