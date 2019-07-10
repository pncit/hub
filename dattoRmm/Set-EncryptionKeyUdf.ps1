# import functions so we have the api functions
. .\dattoRmm\Update-HubFunctions.ps1
Update-HubFunctions

# load config so we have $dattoRmmApiAccessParams
. .\dattoRmm\protected\hubFunctionsConfig.ps1

# get the encryption key value
$encryptionKey = Get-Content '.\dattoRmm\protected\encryptionKey.AES'

# record the encryption key in udf_30
Set-DeviceUdf -udf 30 -value $encryptionKey