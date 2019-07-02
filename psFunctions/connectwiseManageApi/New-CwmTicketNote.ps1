function New-CwmTicketNote {
    <#
    .SYNOPSIS 
    Creates a new ConnectWise Manage ticket note

    .DESCRIPTION
    Creates a new ConnectWise Manage ticket note for either a project or a service ticket

    .PARAMETER ticketId
    Id for ticket to which to add a note.

    .PARAMETER text
    Note text
    
    .PARAMETER detailDescription
    Indicates that note should be flagged as "discussion"

    .PARAMETER internalAnalysis
    Indicates that note should be flagged as "internal"

    .PARAMETER resolution
    Indicates that note should be flagged as "resolution"

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
    [string]$text,

    [parameter()]
    [switch]$detailDescription,

    [parameter()]
    [switch]$internalAnalysis,

    [parameter()]
    [switch]$resolution,

    [parameter(Mandatory=$false)]
    [validateNotNullOrEmpty()]
    [string]$apiUrl=$global:cwmApiUrl,

    [parameter(Mandatory=$false)]
    [validateNotNullOrEmpty()]
    [string]$authString=$global:cwmApiAuthString

    )

    if ( -not ( $detailDescription.IsPresent -or $internalAnalysis.IsPresent -or $resolution.IsPresent ) ) {
        Throw ("There was an attempt to create a ticket note without choosing a flag (discussion, internal, resolution). At least one must be selected.")
    }

    $ticket = Get-CwmTicket -ticketId $ticketId -apiUrl $apiUrl -authString $authString -ErrorAction SilentlyContinue
    if ( $ticket.board.id -eq $cwmProjectBoardId ) {
        $endpoint = "project/tickets/$ticketId/notes"
    } else {
        $endpoint = "service/tickets/$ticketId/notes"
    }

    $body = @{
        ticketid = $ticketId
        detailDescriptionFlag = $detailDescription.IsPresent
        internalAnalysisFlag = $internalAnalysis.IsPresent
        resolutionFlag = $resolution.IsPresent
        processNotifications = $false
        text = $text
    } | ConvertTo-Json

    New-CwmApiRequest -endpoint $endpoint -apiRequestBody $body -apiMethod "post" -apiUrl $apiUrl -authString $authString
}