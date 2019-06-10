function Close-CwmTicket {
    <#
    .SYNOPSIS 
    Closes a CWM ticket

    .DESCRIPTION
    Closes a CWM ticket 

    .PARAMETER id
    The id of the ticket to close

    .OUTPUTS
    none

    .EXAMPLE
    Close-CwmTicket -ticketId 12345678

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
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString -ErrorAction silentlycontinue
        $closedStatus = $cwmServiceTicketStatusClosed
    } catch {
        $endpoint = "project/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString
        $closedStatus = $cwmProjectTicketStatusClosed
    }
    
    $body = @{
        op = "replace"
        path = "status"
        value = @{ id = $closedStatus }
    } | ConvertTo-Json
    $body = "[$body]"

    $ticket = New-CwmApiRequest -endpoint $endpoint -apiRequestBody $body -apiMethod "patch" -apiUrl $cwmApiUrl -authString $cwmApiAuthString
    return $ticket
}