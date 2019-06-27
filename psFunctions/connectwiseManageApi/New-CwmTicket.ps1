function New-CwmTicket {
    <#
    .SYNOPSIS 
    Creates a new ConnectWise Manage ticket

    .DESCRIPTION
    Creates a new ConnectWise Manage ticket on the default board with the default source for the given comand the supplied 

    .PARAMETER summary
    Summary for the new ticket

    .PARAMETER initialDescription
    Text for the initial description

    .PARAMETER priority
    Ticket priority id (defaults to 8, which is "medium")

    .PARAMETER projectId
    Project id to which to attach ticket

    .PARAMETER phaseDescription
    Phase to which to attach ticket

    .PARAMETER apiUrl
    The base ConnectWise Manage API URL

    .PARAMETER authString
    Authorization string to access the ConnectWise Manage API

    .OUTPUTS
    [int32] ticket id

    .EXAMPLE
    $ticketId = New-CwmTicket -summary "test ticket" -initialDescription "this is a test" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"  

    .EXAMPLE
    $ticketId = New-CwmTicket -summary "test ticket" -initialDescription "this is a test" -projectId 33 -phaseDescription "Test Phase" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"  

    .NOTES
    #>
    Param(
    
        [parameter(Mandatory=$true,ParameterSetName = "Create a service ticket")]
        [parameter(Mandatory=$true,ParameterSetName = "Create a project ticket")]
        [validateNotNullOrEmpty()]
        [string]$summary,

        [parameter(Mandatory=$true,ParameterSetName = "Create a service ticket")]
        [parameter(Mandatory=$true,ParameterSetName = "Create a project ticket")]
        [validateNotNullOrEmpty()]
        [string]$initialDescription,
        
        [parameter(Mandatory=$false,ParameterSetName = "Create a service ticket")]
        [ValidateSet("6","15","8","7","12")]
        [int]$priority = 8,
        # 6-Critical 15-high 8-medium 7-low 12-do not respond

        [parameter(Mandatory=$true,ParameterSetName = "Create a project ticket")]
        [validateNotNullOrEmpty()]
        [int]$projectId,

        [parameter(Mandatory=$true,ParameterSetName = "Create a project ticket")]
        [validateNotNullOrEmpty()]
        [string]$phaseDescription,

        [parameter(Mandatory=$true,ParameterSetName = "Create a service ticket")]
        [parameter(Mandatory=$true,ParameterSetName = "Create a project ticket")]
        [validateNotNullOrEmpty()]
        [string]$apiUrl,

        [parameter(Mandatory=$true,ParameterSetName = "Create a service ticket")]
        [parameter(Mandatory=$true,ParameterSetName = "Create a project ticket")]
        [validateNotNullOrEmpty()]
        [string]$authString
    )

    if ( ( $PSBoundParameters.ContainsKey( 'projectId')  ) -eq $true ) {
        $endpoint = "project/projects/$projectId/phases?conditions=description=`"$phaseDescription`"&fields=id"
        $phase = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $apiUrl -authString $authString
        $body = @{
            summary = $summary
            initialDescription = $initialDescription
            phase = @{ id = $phase.id }
        } | ConvertTo-Json
        $ticket = New-CwmApiRequest -endpoint "project/tickets" -apiRequestBody $body -apiMethod "post" -apiUrl $apiUrl -authString $authString
    } else {
        $body = @{
            summary = $summary
            initialDescription = $initialDescription
            company = @{ id = Convert-CwmCompanyNameToId( $Env:CS_PROFILE_NAME ) }
            priority = @{ id = $priority }
        } | ConvertTo-Json
        $ticket = New-CwmApiRequest -endpoint "service/tickets" -apiRequestBody $body -apiMethod "post" -apiUrl $apiUrl -authString $authString
    }

    return $ticket.id

}