function Get-CwmTicket {
    <#
    .SYNOPSIS 
    Gets a CWM ticket

    .DESCRIPTION
    Gets a CWM ticket 

    .PARAMETER id
    The id of the ticket to get

    .OUTPUTS
    none

    .EXAMPLE
    Get-CwmTicket -ticketId 12345678

    .NOTES
    #>
    Param(
    
        [Parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [int]$ticketId,

        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$cwmApiUrl,
    
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$cwmApiAuthString
    

    )

    try {
        $endpoint = "service/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString -ErrorAction SilentlyContinue
    } catch {
        $endpoint = "project/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString
    }
    return $ticket
}