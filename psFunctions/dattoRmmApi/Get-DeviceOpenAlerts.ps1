function Get-DeviceOpenAlerts {
    <#
    .SYNOPSIS 
    Gets device data from the Datto RMM API

    .DESCRIPTION
    If provided with valid access parameters and a valid device uid, this will return the device info available from the Datto RMM API

    .PARAMETER apiAccessToken
    API Access Token generated by New-DattoRmmApiAccessToken.

    .PARAMETER apiUrl
    Region-specific API Url. Allowable values are:

    https://pinotage-api.centrastage.net

    https://merlot-api.centrastage.net

    https://concord-api.centrastage.net

    https://zinfandel-api.centrastage.net

    https://syrah-api.centrastage.net

    .PARAMETER deviceId
    Datto-defined uid. From within a machine this can be collected via
    
    $deviceId = Get-DeviceId

    .OUTPUTS
    [System.Object] custom object containing open alerts for device

    .EXAMPLE
    $deviceData = Get-DeviceOpenAlerts -deviceId $deviceId
    #>
    param
	(
        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [String]$apiAccessToken=$global:dattoRmmApiAccessToken,

        [parameter(Mandatory=$false)]
        [ValidateSet("https://pinotage-api.centrastage.net","https://merlot-api.centrastage.net","https://concord-api.centrastage.net","https://zinfandel-api.centrastage.net","https://syrah-api.centrastage.net")]
        [String]$apiUrl=$global:dattoRmmApiUrl,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$deviceId
    )   
    $response = New-DattoRmmApiRequest -apiAccessToken $apiAccessToken -apiUrl $apiUrl -apiMethod "get" -apiRequest "device/$deviceId/alerts/open"
    return $response
}