function New-CwmTicket {
    <#
    .SYNOPSIS 
    Creates a new CWM ticket

    .DESCRIPTION
    Creates a new CWM ticket on the default board with the default source for the given comand the supplied 

    .PARAMETER companyName
    The name of the company

    .OUTPUTS
    int32 ticket id

    .EXAMPLE
    $companyId = Convert-CwmCompanyNameToId -name "Test Company"

    .NOTES
    #>
    Param(
    
        [parameter(Mandatory=$true,ParameterSetName = "service")]
        [parameter(Mandatory=$true,ParameterSetName = "project")]
        [validateNotNullOrEmpty()]
        [string]$summary,

        [parameter(Mandatory=$true,ParameterSetName = "service")]
        [parameter(Mandatory=$true,ParameterSetName = "project")]
        [validateNotNullOrEmpty()]
        [string]$initialDescription,
        
        [parameter(Mandatory=$false,ParameterSetName = "service")]
        [ValidateSet("6","15","8","7","12")]
        [int]$priority = 8,
        # 6-Critical 15-high 8-medium 7-low 12-do not respond

        [parameter(Mandatory=$true,ParameterSetName = "project")]
        [validateNotNullOrEmpty()]
        [int]$projectId,

        [parameter(Mandatory=$true,ParameterSetName = "project")]
        [validateNotNullOrEmpty()]
        [string]$phaseDescription,

        [parameter(Mandatory=$true,ParameterSetName = "service")]
        [parameter(Mandatory=$true,ParameterSetName = "project")]
        [validateNotNullOrEmpty()]
        [string]$apiUrl,

        [parameter(Mandatory=$true,ParameterSetName = "service")]
        [parameter(Mandatory=$true,ParameterSetName = "project")]
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