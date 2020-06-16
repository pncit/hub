function Get-DellServiceTag {
    <#
    .SYNOPSIS 
    Gets Dell Service Tag

    .DESCRIPTION
    Gets the Dell Service Tag for the local machine

    .NOTES

    .EXAMPLE
    $serviceTag = Get-DellServiceTag
    #>
    
    if ( Confirm-DellDevice ) {
        $serviceTag = ( Get-WmiObject win32_SystemEnclosure ).serialNumber
        if ( $null -eq $serviceTag ) {
            $serviceTag = ( Get-WmiObject Win32_ComputerSystem ).serialNumber
        }
        if ( $null -eq $serviceTag ) {
            Write-Log -Message "Unable to find service tag" -EntryType "Error"
            return $null
        }
        if ( ( $serviceTag.GetType() ).Name -eq "Object[]" ) {
            return $serviceTag[0]
        } else {
            return $serviceTag
        }
    } else {
        Write-Log -Message "This is not a Dell device" -EntryType "Warning"
        return $null
    }

}