function Confirm-DellDevice {
    <#
    .SYNOPSIS 
    Confirms that device was manufactured by Dell

    .DESCRIPTION
    Get the device manufacturer and confirms that it is Dell

    .NOTES

    .EXAMPLE
    if ( Confirm-DellDevice -eq $true ) { ... }
    #>

    return ( ( Get-WmiObject -class Win32_ComputerSystem ).Manufacturer -eq "Dell Inc." )
}