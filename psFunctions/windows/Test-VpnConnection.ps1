function Test-VpnConnection {
    <#
    .SYNOPSIS 
    Checks whether a VPN is currently active

    .DESCRIPTION
    Returns true if device is connected to VPN, false otherwise

    .OUTPUTS
    [Boolean]

    .EXAMPLE
    Test-VpnConnection
    #>


    $connectedVpn = Get-VPNconnection -AllUserConnection | Where-Object { $_.ConnectionStatus -eq 'Connected' }

    if ( $connectedVpn.Count -eq 0 ) {
        return $false
    } else {
        return $true
    }
}