function Get-DellWarrantyApiToken {
    <#
    .SYNOPSIS 
    Gets Dell Warranty API Token

    .DESCRIPTION
    Given a client id and a client secret, this function returns a token for accessing the Dell Warranty API

    .PARAMETER clientId
    Dell Warranty API client_id value

    .PARAMETER clientSecret
    Dell Warranty API client_secret value

    .NOTES

    .EXAMPLE
 
    #>
    param(
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$clientId = $global:dellWarrantyApiClientId,
        
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$clientSecret = $global:dellWarrantyApiClientSecret
    )

    if ( $global:dellApiConfigured -eq $false ) {
        return $null
    }
    
    $oAuthUri = "https://apigtwb2c.us.dell.com/auth/oauth/v2/token"

    $oAuth = "$clientId`:$clientSecret"
    
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($oAuth)
    $encodedOAuth = [Convert]::ToBase64String($bytes)
    $headers = @{ }
    $headers.Add("authorization", "Basic $encodedOAuth")
    $authbody = 'grant_type=client_credentials'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    try {
        $oAuthResult = Invoke-RESTMethod -Method Post -Uri $oAuthUri -Body $authbody -Headers $headers
        $token = $oAuthResult.access_token
        return $token
    }
    catch {
        $errorMessage = $Error[0]
        Write-Error $errorMessage
        return $null        
    }
    
}