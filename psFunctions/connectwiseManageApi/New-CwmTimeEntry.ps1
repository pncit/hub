function New-CwmTimeEntry {
    <#
    .SYNOPSIS 
    Creates a new ConnectWise Manage time entry

    .DESCRIPTION
    Creates a new ConnectWise Manage ticket on the default board with the default source for the given comand the supplied 

    .PARAMETER ticketId
    Id for ticket to which to add time.

    .PARAMETER timeStart
    DateTime value indicating when work began.

    .PARAMETER timeEnd
    DateTime value indicating when work ended. If $timeEnd -le $timeStart, then $timeEnd will be set to $timeStart + 1 minute.

    .PARAMETER notes
    Notes to include in time entry.

    .PARAMETER apiUrl
    The base ConnectWise Manage API URL

    .PARAMETER authString
    Authorization string to access the ConnectWise Manage API

    .NOTES
    #>
    Param(
    
    [Parameter(Mandatory=$true)]
    [validateNotNullOrEmpty()]
    [int]$ticketId,

    [parameter(Mandatory=$true)]
    [validateNotNullOrEmpty()]
    [DateTime]$timeStart,

    [parameter(Mandatory=$true)]
    [validateNotNullOrEmpty()]
    [DateTime]$timeEnd,

    [parameter(Mandatory=$true)]
    [validateNotNullOrEmpty()]
    [string]$notes,

    [parameter(Mandatory=$true)]
    [validateNotNullOrEmpty()]
    [string]$apiUrl,

    [parameter(Mandatory=$true)]
    [validateNotNullOrEmpty()]
    [string]$authString

    )

    $minutes = $timeEnd.Subtract($timeStart).Minutes

    if ( $minutes -lt 1 ) {
        $timeEnd = $timeStart.AddMinutes(1)
    }

    $ticket = Get-CwmTicket -ticketId $ticketId  -apiUrl $apiUrl -authString $authString -ErrorAction SilentlyContinue
    if ( $ticket.board.id -eq $cwmProjectBoardId ) {
        $endpoint = "project/tickets/$ticketId"
        $chargeToType = "ProjectTicket"
        $timeAllowedStatus = { 541 , 543 , 544 , 545 , 546 , 576 , 577 , 578 , 579 }
        $openStatus = $cwmProjectTicketStatusOpen
    } else {
        $endpoint = "service/tickets/$ticketId"
        $chargeToType = "ServiceTicket"
        $timeAllowedStatus = {  56 , 439 , 489 , 560 , 574 , 575 }
        $openStatus = $cwmServiceTicketStatusOpen
    }
    #check whether ticket is in a time-entry allowed status
    if ( $timeAllowedStatus -notcontains $ticket.status.id ) {
        $body = @{
            op = "replace"
            path = "status"
            value = @{ id = $openStatus }
        } | ConvertTo-Json
        $body = "[$body]"
        New-CwmApiRequest -endpoint $endpoint -apiRequestBody $body -apiMethod "patch" -apiUrl $apiUrl -authString $authString
    }

    $body = @{
        chargeToId = $ticketId
        chargeToType = $chargeToType
        member = @{ id = $cwmMemberId }
        workRole = @{ id = $cwmWorkRoleId }
        timeStart = Convert-AkToCwmUtc -akDateTime $timeStart
        timeEnd = Convert-AkToCwmUtc -akDateTime $timeEnd
        notes = $notes
    } | ConvertTo-Json

    New-CwmApiRequest -endpoint "time/entries" -apiRequestBody $body -apiMethod "post" -apiUrl $apiUrl -authString $authString
}