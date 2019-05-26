function Get-CwmApiUrl {
    <#
    .SYNOPSIS 
    Gets the Connectwise Manage API url

    .DESCRIPTION
    Connectwise changes their code bases regularly. This function generates an api url either for a specified code base or returns the most updated
    code base available to your company.

    .PARAMETER apiRegion
    API region. Allowable values are:
    au
    eu
    ​na

    .PARAMETER company
    In order to get the most current code base available to you, you must specify your company. This is not needed if specifying codebase.

    .PARAMETER codebase
    To avoid breaking changes as the API develops, you can specify a specific code base (e.g. v4_6_release/). If this is not specified, the function
    will return the URL for the most current code base. This is not needed if specifying company.

    codebase value must end in a forward slash "/"

    .OUTPUTS
    API url (string)

    .EXAMPLE
    $apiUrl = Get-CwmApiUrl -apiRegion "na" -company "mycompany"
    This will return the url for the most recent code base in the na region (e.g. "https://api-na.myconnectwise.net/v2019_3/apis/3.0")

    .EXAMPLE
    $apiUrl = Get-CwmApiUrl -apiRegion "na" -codebase "v4_6_release"
    This will return the url for v4_6_release code base in the na region (e.g. "https://api-na.myconnectwise.net/v4_6_release/apis/3.0")

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true,ParameterSetName = "Specific code base")]
        [parameter(Mandatory=$true,ParameterSetName = "Most current code base")]
        [ValidateSet("au","eu","na")]
        [string]$apiRegion,

        [parameter(Mandatory=$true,ParameterSetName = "Most current code base")]
        [validateNotNullorEmpty()]
        [string]$company,

        [parameter(Mandatory=$true,ParameterSetName = "Specific code base")]
        [validateNotNullorEmpty()]
        [string]$codebase
    )

    if ( ( $PSBoundParameters.ContainsKey( 'codebase')  ) -eq $false ) {
        $uri = "https://api-" + $apiRegion + ".myconnectwise.net/login/companyinfo/" + $company
        $response = Invoke-WebRequest -uri $uri
        $content = $response.content | ConvertFrom-Json
        $codebase = $content.codebase
    }
    $url = "https://api-$apiRegion.myconnectwise.net/$codebase" + "apis/3.0/"
    return $url
}
