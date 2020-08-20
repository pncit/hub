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

Write-Host "Building hub functions psm1 file..."
#combine all function definitions into one file
Get-ChildItem ".\psFunctions" *ps1 -Recurse | Get-Content | Set-Content ".\deploy\hubFunctions.psm1" -Force

#compress file and remove original
Write-Host "Creating compressed hub functions file..."
Compress-Archive -Path ".\deploy\hubFunctions.psm1" -CompressionLevel Optimal -DestinationPath ".\hubFunctions.zip" -Force
Write-Host "Removing hub functions psm1 file..."
Remove-Item -LiteralPath ".\deploy\hubFunctions.psm1"
Write-Host "Completed building hub functions."
