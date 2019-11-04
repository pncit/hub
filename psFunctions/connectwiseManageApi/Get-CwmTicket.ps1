function Get-CwmTicket {
    <#
    .SYNOPSIS 
    Gets data for a ConnectWise Manage Ticket

    .DESCRIPTION
    Queries the ConnectWise Manage API for a ticket with a specified Id and returns the data for that ticket.

    .PARAMETER ticketId
    The id (as defined within ConnectWise Manage) of the ticket to get data for

    .PARAMETER apiUrl
    ConnectWise Manage API URL

    .PARAMETER authString
    ConnectWise Manage API authorization string

    .PARAMETER apiClientId
    Unique GUID or Globally Unique Identifier assigned to each ConnectWise integration

    .OUTPUTS
    [System.Object] custom object containing ticket data

    .EXAMPLE
    Get-CwmTicket -ticketId 12345678-apiUrl "https://api-na.myconnectwise.net/v2019_4/apis/3.0/" -authString "Basic ZmRqa2VvaXdmaithZHNmYXNkZmFzZmRkZmZpOmZkaWVqZmlkamZpZGZkZmo="

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

    if ( $global:cwmApiConfigured -eq $false ) {
        return $null
    }
    try {
        $endpoint = "service/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString -apiClientId $apiClientId -ErrorAction SilentlyContinue
    } catch {
        $endpoint = "project/tickets/$ticketId"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString -apiClientId $apiClientId
    }
    return $ticket
}