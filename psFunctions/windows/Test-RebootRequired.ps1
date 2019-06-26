function Test-RebootRequired {
    #in the future these can be changed into switches if that is deemed useful
    $chkCBServicing = $true
    $chkWindowsUpdate = $true
    $chkCCMClientSDK = $true
    $chkPendComputerRename = $true
    $chkPendFileRename = $true
    $chkInternalRebootFlag = $true

    # Build array to filter unwanted checks
    $Checks = @()
    if ($chkCBServicing -eq $true) {$Checks += 'CBServicing'}
    if ($chkWindowsUpdate -eq $true) {$Checks += 'WindowsUpdate'} 
    if ($chkCCMClientSDK -eq $true) {$Checks += 'CCMClientSDK'}
    if ($chkPendComputerRename -eq $true) {$Checks += 'PendComputerRename'}
    if ($chkPendFileRename -eq $true) {$Checks += 'PendFileRename'}
    if ($chkInternalRebootFlag -eq $true) {$Checks += 'InternalRebootFlag'}

    # Build PendingReboot custom object including InternalRebootFlag
    $PendingReboot = Get-PendingReboot
    $PendingReboot | Add-Member -MemberType NoteProperty -Name InternalRebootFlag -Value $(Test-Path -Path "$env:AllUsersProfile\CentraStage\reboot.flag")

    # Build results array for positive checks
    $Results = @()
    $Checks | ForEach-Object -Process {if ($PendingReboot.$_ -eq $true) {$Results += $_}}

    # return true if any checks are positive
    if ($Results) {
        return $true
    } else {
        return $false
    }
}