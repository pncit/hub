function Convert-CwmCompanyNameToId {
    <#
    .SYNOPSIS 
    Returns the CWM id for a given company

    .DESCRIPTION
    If provided with a valid company name, this function will return the CWM company id.

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
        [string]$companyName

    )

    $endpoint = "/company/companies?conditions=name=`"$companyName`"&fields=id"
    $result = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString

    return $result.id
}