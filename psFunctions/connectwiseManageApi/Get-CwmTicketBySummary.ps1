function Get-CwmTicketBySummary {
    <#
    .SYNOPSIS 
    Gets data for a ConnectWise Manage Ticket with a specific summary

    .DESCRIPTION
    Queries the ConnectWise Manage API for a ticket with a specified summary and returns the id for that ticket.

    .PARAMETER summary
    The summary of the ticket to get data for

    .PARAMETER apiUrl
    ConnectWise Manage API URL

    .PARAMETER authString
    ConnectWise Manage API authorization string

    .PARAMETER apiClientId
    Unique GUID or Globally Unique Identifier assigned to each ConnectWise integration

    .OUTPUTS
    Ticket id (as defined in CWM). ** if more than one ticket is returned, all ids are returned in an array **

    .EXAMPLE
    Get-CwmTicketBySummary -summary "Install patch 12345678 on LAB-004"

    #>
    Param(
    
        [Parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$summary,

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

    $conditions = "summary=`"$summary`""
    $fields = "id"

    try {
        $endpoint = "/service/tickets?conditions=$conditions&fields=$fields"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString -apiClientId $apiClientId -ErrorAction SilentlyContinue
    } catch {
        $endpoint = "/project/tickets?conditions=$conditions&fields=$fields"
        $ticket = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString -apiClientId $apiClientId
    }
    #if more than one ticket is returned, all ids are returned in an array
    return $ticket.id
}