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
        [string]$apiUrl,
    
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$authString
    

    )

    try {
        $endpoint = "service/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString -ErrorAction SilentlyContinue
    } catch {
        $endpoint = "project/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString
    }
    return $ticket
}