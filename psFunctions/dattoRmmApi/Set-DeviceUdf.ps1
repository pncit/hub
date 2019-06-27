function Set-DeviceUdf {
    <#
    .SYNOPSIS 
    Sets Datto RMM UDF to a specified value for a single device, devices at a site, or devices in an account

    .DESCRIPTION
    If provided with valid access parameters this will set UDF values via the API. This will impact devices whether or not they are online.

    .PARAMETER dattoRmmApiAccessParams
    Hashtable with API url and either API access key and secret key or an API access token. Examples:

    .PARAMETER deviceId
    Datto-defined uid. From within a machine this can be collected via
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId

    .PARAMETER siteId
    Datto-defined uid. 

    .PARAMETER udf
    UDF number (1-30)

    .PARAMETER value
    Value for the udf. User-defined fields have a limit of 255 characters.
    #>
    param
	(
        [parameter(Mandatory=$true,ParameterSetName = "Set value for a single device")]
        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices at a site")]
        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices in account")]
        [validateNotNullOrEmpty()]
        [hashtable]$dattoRmmApiAccessParams,

        [parameter(Mandatory=$true,ParameterSetName = "Set value for a single device")]
        [validateNotNullorEmpty()]
        [string]$deviceId,

        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices at a site")]
        [validateNotNullorEmpty()]
        [string]$siteId,

        [parameter(Mandatory=$true,ParameterSetName = "Set value for a single device")]
        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices at a site")]
        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices in account")]
        [ValidateRange(1,30)]
        [int32]$udf,

        [parameter(Mandatory=$true,ParameterSetName = "Set value for a single device")]
        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices at a site")]
        [parameter(Mandatory=$true,ParameterSetName = "Set value for all devices in account")]
        [ValidateLength(0,255)]
        [AllowEmptyString()]
        [string]$value
    )   

    $requestBody = @{
        "udf$udf" = $value
    } | ConvertTo-Json

    if ( ( $PSBoundParameters.ContainsKey( 'deviceId')  ) -eq $true ) {
        $apiRequest = "device/$deviceId"
    } elseif ( ( $PSBoundParameters.ContainsKey( 'siteId')  ) -eq $true ) {
        $apiRequest = "site/$siteId/devices"
    } else {
        $apiRequest = "account/devices"
    }

    $devices = New-DattoRmmApiRequest @dattoRmmApiAccessParams -apiMethod "get" -apiRequest $apiRequest
    foreach ( $device in $devices ) {
        $deviceId = $device.uid
        New-DattoRmmApiRequest @dattoRmmApiAccessParams -apiMethod "post" -apiRequest "device/$deviceId/udf" -apiRequestBody $requestBody
    }
}