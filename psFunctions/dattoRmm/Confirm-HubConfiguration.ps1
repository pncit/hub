function Confirm-HubConfiguration {
    <#
    .SYNOPSIS 
    Checks whether the needed variables have been defined in the Datto settings screen
    
    .DESCRIPTION
    Checks whether the needed variables have been defined in the Datto settings screen

    .EXAMPLE
    Confirm-HubConfiguration

    .OUTPUTS
    [Boolean]

    #>

    $confirmed = $true

    #datto api settings
    if (    $null -ne $env:dattoRmmApiUrl `
       -and $null -ne $env:dattoRmmAccessKey `
       -and $null -ne $env:dattoRmmSecretKey `
    ) {
        $global:dattoRMMApiConfigured = $true
    } else {
        Write-Host "Not all Datto RMM API variables were defined. Deactivating Datto RMM Api integration."
        $global:dattoRMMApiConfigured = $false
    }

    if ( $global:dattoRMMApiConfigured ) {
        if ( ( $null -eq $dattoRmmApiUrl -as [System.URI]).AbsoluteURI ) {
            Write-Error "value for dattoRmmApiUrl is invalid"
        }
        if ( $env:dattoRmmAccessKey -cnotmatch "^[0-9A-Z]{32}$" ) {
            Write-Error "value for DattoRmmAccessKey is invalid"
            $confirmed = $false
        }
        if ( $env:dattoRmmSecretKey -cnotmatch "^[0-9A-Z]{32}$" ) {
            Write-Error "value for dattoRmmSecretKey is invalid"
            $confirmed = $false
        }
    }

    #cwm api settings
    if (    $null -ne $env:cwmApiClientId `
       -and $null -ne $env:cwmApiPublicKey `
       -and $null -ne $env:cwmApiPrivateKey `
       -and $null -ne $env:cwmServiceBoardId `
       -and $null -ne $env:cwmProjectBoardId `
       -and $null -ne $env:cwmServiceTicketStatusClosed `
       -and $null -ne $env:cwmServiceTicketStatusOpen `
       -and $null -ne $env:cwmServiceTicketTimeAllowedStatus `
       -and $null -ne $env:cwmProjectTicketStatusClosed `
       -and $null -ne $env:cwmProjectTicketStatusOpen `
       -and $null -ne $env:cwmProjectTicketTimeAllowedStatus `
       -and $null -ne $env:cwmMemberId `
       -and $null -ne $env:cwmWorkRoleId `
    ) {
        $global:cwmApiConfigured = $true
    } else {
        Write-Host "Not all Connectwise Manage variables were defined. Deactivating Connectwise Manage integration."
        $global:cwmApiConfigured = $false
    }

    if ( $global:cwmApiConfigured ) {
        if ( $env:cwmCompany -inotmatch "^[0-9A-Z]{1,}$" ) {
            Write-Error "value for cwmCompany is invalid"
            $confirmed = $false
        }
        if ( $env:cwmApiRegion -inotmatch "^[0-9A-Z]{2}$" ) {
            Write-Error "value for cwmCompany is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmApiClientId -inotmatch "^[0-9A-Z]{8}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{12}$" ) {
            Write-Error "value for cwmApiClientId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmApiPublicKey -inotmatch "^[0-9A-Z]{16}$" ) {
            Write-Error "value for cwmApiPublicKey is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmApiPrivateKey -inotmatch "^[0-9A-Z]{16}$" ) {
            Write-Error "value for cwmApiPrivateKey is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmServiceBoardId -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmServiceBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmProjectBoardId -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmServiceTicketStatusClosed -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmServiceTicketStatusOpen -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmProjectTicketStatusClosed -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmProjectTicketStatusOpen -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmMemberId -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
        if ( $env:cwmWorkRoleId -inotmatch "^\d{1,}$" ) {
            Write-Error "value for cwmProjectBoardId is invalid"
            $confirmed = $false
        } 
    }

    #office365 settings
    if (    $null -ne $env:o365Account `
       -and $null -ne $env:o365Password `
       -and $null -ne $env:msTeamsWebhook1 `
       -and $null -ne $env:msTeamsWebhook2 `
    ) {
        $global:o365Configured = $true
    } else {
        Write-Host "Not all Office 365 variables were defined. Deactivating Office 365 integration."
        $global:o365Configured = $false
    }
 
    if ( $global:o365Configured ) {
        if ( $env:msTeamsWebhook1 -inotmatch "^[0-9A-Z]{8}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{12}@[0-9A-Z]{8}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{12}$" ) {
            Write-Error "value for msTeamsWebhook1 is invalid"
            $confirmed = $false
        } 
        if ( $env:msTeamsWebhook2 -inotmatch "^[0-9A-Z]{32}\/[0-9A-Z]{8}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{12}$" ) {
            Write-Error "value for msTeamsWebhook2 is invalid"
            $confirmed = $false
        } 
    }

    return $confirmed

}