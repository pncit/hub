function Close-CwmTicket {
    <#
    .SYNOPSIS 
    Closes a ConnectWise Manage ticket

    .DESCRIPTION
    Sets a ticket to "closed" status. This status differs for service and project tickets, and the exact values are defined elsewhere as global parameters ($cwmServiceTicketStatusClosed and $cwmProjectTicketStatusClosed).

    .PARAMETER ticketId
    The id (as defined within ConnectWise Manage) of the ticket to close

    .PARAMETER apiUrl
    ConnectWise Manage API URL

    .PARAMETER authString
    ConnectWise Manage API authorization string
    
    .PARAMETER apiClientId
    Unique GUID or Globally Unique Identifier assigned to each ConnectWise integration

    .EXAMPLE
    Close-CwmTicket -ticketId 12345678 -apiUrl "https://api-na.myconnectwise.net/v2019_4/apis/3.0/" -authString "Basic ZmRqa2VvaXdmaithZHNmYXNkZmFzZmRkZmZpOmZkaWVqZmlkamZpZGZkZmo="

    .OUTPUTS
    [System.Object] custom object containing ticket data
    #>
    Param(
    
        [Parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [int]$ticketId,

        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$apiUrl=$global:cwmApiUrl,
    
        [parameter(Mandatory=$false)]
        [validateNotNullOrEmpty()]
        [string]$authString=$global:cwmApiAuthString,

        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$apiClientId=$global:cwmApiClientId
    
    )

    try {
        $endpoint = "service/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString -apiClientId $apiClientId -ErrorAction silentlycontinue
        $closedStatus = $global:cwmServiceTicketStatusClosed
    } catch {
        $endpoint = "project/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString -apiClientId $apiClientId
        $closedStatus = $global:cwmProjectTicketStatusClosed
    }
    
    $body = @{
        op = "replace"
        path = "status"
        value = @{ id = $closedStatus }
    } | ConvertTo-Json
    $body = "[$body]"

    $ticket = New-CwmApiRequest -endpoint $endpoint -apiRequestBody $body -apiMethod "patch" -apiUrl $cwmApiUrl -authString $cwmApiAuthString -apiClientId $apiClientId
    return $ticket
}