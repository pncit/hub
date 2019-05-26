# load config so we have $dattoRmmApiAccessParams
. .\dattoRmm\protected\hubFunctionsConfig.ps1

# import functions so we have the api functions
. .\dattoRmm\Update-HubFunctions.ps1

# get the encryption key value
$encryptionKey = Get-Content '.\dattoRmm\protected\encryptionKey.AES'

# record the encryption key in udf_30
$apiAccessToken = New-DattoRmmApiAccessToken -apiUrl $dattoRmmApiAccessParams['apiUrl'] -accessKey $dattoRmmApiAccessParams['accessKey'] -secretKey $dattoRmmApiAccessParams['secretKey']

$fastAccessParams = @{
    apiUrl = $dattoRmmApiAccessParams['apiUrl']
    apiAccessToken = $apiAccessToken
}
Set-DeviceUdf -dattoRmmApiAccessParams $fastAccessParams -udf 30 -value $encryptionKey