function Get-DevicePatchStatus {
    <#
    .SYNOPSIS 
    Gets device patch status from the Datto RMM API

    .DESCRIPTION
    If provided with valid access parameters and a valid device uid, this will return the patch status from the Datto RMM API

    .PARAMETER dattoApiAccessParams
    Hashtable with API url and either API access key and secret key or an API access token. Examples:

    .PARAMETER deviceId
    Datto-defined uid. From within a machine this can be collected via
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId

    .OUTPUTS
    Request response

    .EXAMPLE
    $dattoApiAccessParams = @{
        apiUrl = https://zinfandel-api.centrastage.net
        accessKey = "ewfoijdfsoji"
        secretKey = "fdlkjfdjklsd"
    }
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId
    $devicePatchStatus = Get-DevicePatchStatus -dattoApiAccessParams $dattoApiAccessParams -deviceId $deviceId

    .EXAMPLE
    $dattoApiAccessParams = @{
        apiUrl = https://zinfandel-api.centrastage.net
        apiAccessToken = "dfjkfdkjlsdjklfdjlkdsfjkldfsklj"
    }
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId
    $devicePatchStatus = Get-DevicePatchStatus -dattoApiAccessParams $dattoApiAccessParams -deviceId $deviceId

    .NOTES
    #>
    param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [hashtable]$dattoApiAccessParams,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$deviceId
    )   
    $deviceData = Get-DeviceData -dattoApiAccessParams $dattoApiAccessParams -deviceId $deviceId
    return $deviceData.patchManagement.patchStatus
}