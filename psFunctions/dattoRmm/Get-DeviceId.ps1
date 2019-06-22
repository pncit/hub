function Get-DeviceId {
    $deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name DeviceId).DeviceId
    return $deviceId
}
