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

#combine all function definitions into one temp file
Get-ChildItem ".\psFunctions" *ps1 -Recurse | Get-Content | Set-Content ".\dattoRmm\protected\hubFunctions.psm1" -Force

#compress file
Compress-Archive -Path ".\dattoRmm\protected\hubFunctions.psm1" -CompressionLevel Optimal -DestinationPath ".\dattoRmm\protected\hubFunctions.psm1.zip" -Force