function Get-DellWarrantyInfo {
    <#
    .SYNOPSIS 
    Gets Dell Warranty Info

    .DESCRIPTION
    Uses the Dell API to get warranty info for a given service tag number

    .PARAMETER apiKey
    Dell apiKey

    .PARAMETER serviceTag
    Service tag to look up

    .NOTES

    .EXAMPLE
    $warrantyInfo = Get-DellWarrantyInfo -serviceTag 'ABCDEF'
    #>
    param(
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$token = $dellWarrantyApiToken,
        
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$serviceTag
    )

    if ( $global:dellApiConfigured -eq $false ) {
        return $null
    }

    $endpoint = "https://apigtwb2c.us.dell.com/PROD/sbil/eapi/v5/asset-entitlements"

    $headers = @{"Accept" = "application/json" }
    $headers.Add("Authorization", "Bearer $token")

    $params = @{ }
    $params = @{servicetags = $servicetag; Method = "GET" }

    $response = Invoke-RestMethod -Uri $endpoint -Headers $headers -Body $params -Method Get -ContentType "application/json"

    if ( $response.invalid -eq $false ) {
        return $response
    } else {
        Write-Log -message "Service tag ($serviceTag) invalid" -entryType Error 
        return $null
    }
}