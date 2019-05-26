# load config so we have $dattoRmmApiAccessParams
. .\dattoRmm\protected\hubFunctionsConfig.ps1

# import functions so we have the api functions
Import-Module '.\dattoRmm\protected\hubFunctions.psm1'

# get the encryption key value
$encryptionKey = Get-Content '.\dattoRmm\protected\encryptionKey.AES'

# record the encryption key in udf_30
Set-DeviceUdf -dattoRmmApiAccessParams $dattoRmmApiAccessParams -udf 30 -value $encryptionKey