function New-CwmTimeEntry {
    <#
    .SYNOPSIS 
    Creates a new CWM time entry

    .DESCRIPTION
    Creates a new CWM ticket on the default board with the default source for the given comand the supplied 

    .PARAMETER companyName
    The name of the company

    .OUTPUTS
    int32 company id

    .EXAMPLE
    $companyId = Convert-CwmCompanyNameToId -name "Test Company"

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
        timeStart = $timeStart.ToString('yyyy-MM-ddTHH:mm:ssZ')
        timeEnd = $timeEnd.ToString('yyyy-MM-ddTHH:mm:ssZ')
        notes = $notes
    } | ConvertTo-Json

    New-CwmApiRequest -endpoint "time/entries" -apiRequestBody $body -apiMethod "post" -apiUrl $apiUrl -authString $authString
}