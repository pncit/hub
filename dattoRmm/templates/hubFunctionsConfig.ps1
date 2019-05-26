#datto api settings
$dattoRmmApiUrl = "https://myregion-api.centrastage.net"
$dattoRmmAccessKey = "00000000000000000000000000000000"
$dattoRmmSecretKey = "00000000000000000000000000000000"

#cwm api settings
$cwmCompany = "mycompany"
$cwmApiRegion = "xx"
$cwmApiPublicKey = "0000000000000000"
$cwmApiPrivateKey = "0000000000000000"

#microsoft teams settings
$msTeamsWebhook = "https://outlook.office.com/webhook/00000000-0000-0000-0000-000000000000@00000000-0000-0000-0000-000000000000/IncomingWebhook/00000000000000000000000000000000/00000000-0000-0000-0000-000000000000"


################################################################
# below this point all settings are dynamic

$Global:dattoRmmApiAccessParams = @{
    apiUrl = $dattoRmmApiUrl
    accessKey = $dattoRmmAccessKey
    secretKey = $dattoRmmSecretKey
}

$Global:cwmApiAccessParams = @{
    company = $cwmCompany
    apiRegion = $cwmApiRegion
    publicKey = $cwmApiPublicKey
    privateKey = $cwmApiPrivateKey
}

$Global:msTeamsWebhook = $msTeamsWebhook