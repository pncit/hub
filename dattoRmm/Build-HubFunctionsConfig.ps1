# import functions so we have the encryption functions
Import-Module '.\dattoRmm\protected\hubFunctions.psm1'

# get the encryption key to use
$key = Get-Content ".\dattoRmm\protected\encryptionKey.AES"

# encrypt the file - remember to delete it after copying it to the final location
Protect-File ".\dattoRmm\protected\hubFunctionsConfig.ps1" -KeyAsPlainText $key 