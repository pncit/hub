function Get-DeviceData {
    <#
    .SYNOPSIS 
    Gets device data from the Datto RMM API

    .DESCRIPTION
    If provided with valid access parameters and a valid device uid, this will return the device info available from the Datto RMM API

    .PARAMETER dattoRmmApiAccessParams
    Hashtable with API url and either API access key and secret key or an API access token.

    .PARAMETER deviceId
    Datto-defined uid. From within a machine this can be collected via
    
    $deviceId = Get-DeviceId

    .OUTPUTS
    [System.Object] custom object containing device data

    .EXAMPLE
    $deviceData = Get-DeviceData -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId
    #>
    param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [hashtable]$dattoRmmApiAccessParams,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$deviceId
    )   
    $response = New-DattoRmmApiRequest @dattoRmmApiAccessParams -apiMethod "get" -apiRequest "device/$deviceId"
    return $response
}