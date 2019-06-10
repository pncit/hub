#datto api settings
$dattoRmmApiUrl = "https://myregion-api.centrastage.net"
$dattoRmmAccessKey = "00000000000000000000000000000000"
$dattoRmmSecretKey = "00000000000000000000000000000000"

#cwm api settings
$cwmCompany = "mycompany"
$cwmApiRegion = "xx"
$cwmApiPublicKey = "0000000000000000"
$cwmApiPrivateKey = "0000000000000000"
$cwmServiceBoardId = 0
$cwmProjectBoardId = 0
$cwmServiceTicketStatusClosed = 0
$cwmServiceTicketStatusOpen = 0
$cwmProjectTicketStatusClosed = 0
$cwmProjectTicketStatusOpen = 0
$cwmMemberId = 0
$cwmWorkRoleId = 0

#office365 settings
$o365Account = "sender@conosto.com"
$o365Password = 'password'
$msTeamsWebhook = "https://outlook.office.com/webhook/00000000-0000-0000-0000-000000000000000000000-0000-0000-0000-000000000000/IncomingWebhook/00000000000000000000000000000000/00000000-0000-0000-0000-000000000000"

#office365
################################################################
# below this point all settings are dynamic

$global:dattoRmmApiAccessParams = @{
    apiUrl = $dattoRmmApiUrl
    accessKey = $dattoRmmAccessKey
    secretKey = $dattoRmmSecretKey
}

$global:cwmApiUrl = Get-CwmApiUrl -apiRegion $cwmApiRegion -company $cwmCompany
$global:cwmApiAuthString = New-CwmApiAuthString -company $cwmCompany -publicKey $cwmApiPublicKey -privateKey $cwmApiPrivateKey
$global:cwmServiceBoardId = $cwmServiceBoardId
$global:cwmProjectBoardId = $cwmProjectBoardId
$global:cwmServiceTicketStatusClosed = $cwmServiceTicketStatusClosed
$global:cwmProjectTicketStatusClosed = $cwmProjectTicketStatusClosed
$global:cwmServiceTicketStatusOpen = $cwmServiceTicketStatusOpen
$global:cwmProjectTicketStatusOpen = $cwmProjectTicketStatusOpen
$global:cwmMemberId = $cwmMemberId
$global:cwmWorkRoleId = $cwmWorkRoleId

$o365PasswordSecure = ConvertTo-SecureString $o365Password -AsPlainText -Force
$o365Credential = New-Object System.Management.Automation.PSCredential( $o365Account , $o365PasswordSecure )
$global:o365MailParams = @{ 
    From = $o365Account
    Credential = $o365Credential
}
$global:msTeamsWebhook = $msTeamsWebhook