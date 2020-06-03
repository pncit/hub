function Set-HubConfiguration {
    <#
    .SYNOPSIS 
    Creates global variables for use in hub derived from environment variables defined in DattoRMM
    
    .DESCRIPTION
    Creates global variables for use in hub derived from environment variables defined in DattoRMM

    .EXAMPLE
    Set-HubConfiguration

    #>

if ( Confirm-HubConfiguration ) {
    $global:hubFunctionsConfigImported = $true

    if ( $global:dattoRMMApiConfigured ) {
        $global:dattoRmmApiAccessToken = New-DattoRmmApiAccessToken -apiUrl $env:dattoRmmApiUrl -accessKey $env:dattoRmmAccessKey -secretKey $env:dattoRmmSecretKey
        $global:dattoRmmApiUrl = $env:dattoRmmApiUrl
        Write-Log -Message "Datto RMM API integration configured" -EntryType "Information"
    }
    
    if ( $global:cwmApiConfigured ) {
        $global:cwmApiUrl = Get-CwmApiUrl -apiRegion $env:cwmApiRegion -company $env:cwmCompany
        $global:cwmApiAuthString = New-CwmApiAuthString -company $env:cwmCompany -publicKey $env:cwmApiPublicKey -privateKey $env:cwmApiPrivateKey
        $global:cwmApiClientId = $env:cwmApiClientId
        $global:cwmServiceBoardId = $env:cwmServiceBoardId
        $global:cwmProjectBoardId = $env:cwmProjectBoardId
        $global:cwmServiceTicketStatusClosed = $env:cwmServiceTicketStatusClosed
        $global:cwmProjectTicketStatusClosed = $env:cwmProjectTicketStatusClosed
        $global:cwmServiceTicketStatusOpen = $env:cwmServiceTicketStatusOpen
        $global:cwmProjectTicketStatusOpen = $env:cwmProjectTicketStatusOpen
        $global:cwmServiceTicketTimeAllowedStatus = $env:cwmServiceTicketTimeAllowedStatus
        $global:cwmProjectTicketTimeAllowedStatus = $env:cwmProjectTicketTimeAllowedStatus
        $global:cwmMemberId = $env:cwmMemberId
        $global:cwmWorkRoleId = $env:cwmWorkRoleId
        $global:cwmApiConfigured = $true
        Write-Log -Message "Connectwise Manage integration configured" -EntryType "Information"
    }
    
    if ( $global:o365Configured ) {
        $o365PasswordSecure = ConvertTo-SecureString $env:o365Password -AsPlainText -Force
        $o365Credential = New-Object System.Management.Automation.PSCredential( $env:o365Account , $o365PasswordSecure )
        $global:o365Account = $env:o365Account
        $global:o365AccountCredential = $o365Credential
        $global:msTeamsWebhook = "https://outlook.office.com/webhook/$env:msTeamsWebhook1/IncomingWebhook/$env:msTeamsWebhook2"
        Write-Log -Message "Office365 integration configured" -EntryType "Information"
    }

    if ( $global:dellWarrantyApiConfigured ) {
        $global:dellWarrantyApiClientId = $env:dellWarrantyApiClientId
        $global:dellWarrantyApiClientSecret = $env:dellWarrantyApiClientSecret
        Write-Log -Message "Dell Warranty API integration configured" -EntryType "Information"
    }
}

}