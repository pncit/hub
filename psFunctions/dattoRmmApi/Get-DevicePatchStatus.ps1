function Get-DevicePatchStatus {
    <#
    .SYNOPSIS 
    Gets device patch status from the Datto RMM API

    .DESCRIPTION
    If provided with valid access parameters and a valid device uid, this will return the patch status from the Datto RMM API

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
    $devicePatchStatus = Get-DevicePatchStatus -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId

    .EXAMPLE
    $dattoRmmApiAccessParams = @{
        apiUrl = https://zinfandel-api.centrastage.net
        apiAccessToken = "dfjkfdkjlsdjklfdjlkdsfjkldfsklj"
    }
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId
    $devicePatchStatus = Get-DevicePatchStatus -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId

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
    $deviceData = Get-DeviceData -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId
    return $deviceData.patchManagement.patchStatus
}