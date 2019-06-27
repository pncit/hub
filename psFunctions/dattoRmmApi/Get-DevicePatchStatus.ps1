function Get-DevicePatchStatus {
    <#
    .SYNOPSIS 
    Gets device patch status from the Datto RMM API

    .DESCRIPTION
    If provided with valid access parameters and a valid device uid, this will return the patch status from the Datto RMM API

    .PARAMETER dattoRmmApiAccessParams
    Hashtable with API url and either API access key and secret key or an API access token.

    .PARAMETER deviceId
    Datto-defined uid. From within a machine this can be collected via
    
    $deviceId = Get-DeviceId

    .OUTPUTS
    [String] patch status

    .EXAMPLE
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