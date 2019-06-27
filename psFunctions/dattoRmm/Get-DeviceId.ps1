function Get-DeviceId {
    <#
    .SYNOPSIS 
    Gets current device's Datto RMM Id

    .DESCRIPTION
    Datto RMM assigns each device a unique id in the form "53c59385-f94w-43j8-583v-8wec83c93853". This function returns the id 
    of the device on which it is run.

    .OUTPUTS
    [String] device id

    .EXAMPLE
    $deviceId = Get-DeviceId

    .NOTES
    #>
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name DeviceId).DeviceId
    return $deviceId
}
