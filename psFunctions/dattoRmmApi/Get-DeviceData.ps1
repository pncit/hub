function Get-DeviceData {
    <#
    .SYNOPSIS 
    Gets device data from the Datto RMM API

    .DESCRIPTION
    If provided with valid access parameters and a valid device uid, this will return the device info available from the Datto RMM API

    .PARAMETER dattoRmmApiAccessParams
    Hashtable with API url and either API access key and secret key or an API access token. Examples:

    .PARAMETER deviceId
    Datto-defined uid. From within a machine this can be collected via
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId

    .OUTPUTS
    Request response

    .EXAMPLE
    $dattoRmmApiAccessParams = @{
        apiUrl = https://zinfandel-api.centrastage.net
        accessKey = "ewfoijdfsoji"
        secretKey = "fdlkjfdjklsd"
    }
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId
    $deviceData = Get-DeviceData -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId

    .EXAMPLE
    $dattoRmmApiAccessParams = @{
        apiUrl = https://zinfandel-api.centrastage.net
        apiAccessToken = "dfjkfdkjlsdjklfdjlkdsfjkldfsklj"
    }
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId
    $deviceData = Get-DeviceData -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId

    .NOTES
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
    if ( $response.StatusCode -eq 200 ) {
	    return $response.Content
    } else {
        Throw "API Request failed (Response Code " + $response.StatusCode + ")"
    } 
}