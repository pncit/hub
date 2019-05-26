function New-CwmApiRequest {
    <#
    .SYNOPSIS 
    Performs a query against the Connectwise Manage API

    .DESCRIPTION
    Connectwise changes their code bases regularly. This function generates an api url either for a specified code base or returns the most updated
    code base available to your company.

    .PARAMETER company
    Your company id

    .PARAMETER endpoint

    .PARAMETER apiUrl

    .PARAMETER apiRegion
    API region. Allowable values are:
    au
    eu
    ​na

    .PARAMETER codebase
    To avoid breaking changes as the API develops, you can specify a specific code base (e.g. v4_6_release/). If this is not specified, the function
    will return the URL for the most current code base. This is not needed if specifying company.

    codebase value must end in a forward slash "/"

    .PARAMETER authString
    
    .PARAMETER publicKey

    .PARAMETER privateKey

    .OUTPUTS
    API response

    .EXAMPLE
    $contacts = New-CwmApiRequest -company "mycompany" -endpoint "company/contacts" -apiMethod "get" -apiRegion "na" -publicKey "xxxx" -privateKey "yyyy"
    This will return all contacts using the most recent api codebase and public key + private key to authenticate
     .EXAMPLE
    $contacts = New-CwmApiRequest -company "mycompany" -endpoint "company/contacts" -apiMethod "get" -apiRegion "na" -codebase "2017_4" -authString "Basic 1234" 
    This will return all contacts using the 2017_4 api codebase and a pre-defined authorization string to authenticate
    
     .EXAMPLE
    $contacts = New-CwmApiRequest -company "mycompany" -endpoint "company/contacts" -apiMethod "get" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -publicKey "xxxx" -privateKey "yyyy"
    This will return all contacts using a pre-defined api url and public key + private key to authenticate
    
     .EXAMPLE
    $contacts = New-CwmApiRequest -endpoint "company/contacts" -apiMethod "get" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic XXX" 
    This will return all contacts using a pre-defined api url and a pre-defined authorization string to authenticate

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true,ParameterSetName = "specified url + generate auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$company,
        
        [parameter(Mandatory=$true,ParameterSetName = "specified url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "specified url + generate auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$endpoint,

        [parameter(Mandatory=$true,ParameterSetName = "specified url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "specified url + generate auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$apiMethod,

        [parameter(Mandatory=$false,ParameterSetName = "specified url + specified auth")]
        [parameter(Mandatory=$false,ParameterSetName = "specified url + generate auth")]
        [parameter(Mandatory=$false,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$false,ParameterSetName = "generate url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$apiRequestBody,

        [parameter(Mandatory=$true,ParameterSetName = "specified url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "specified url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$apiUrl,

        [parameter(Mandatory=$true,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "generate url + generate auth")]
        [ValidateSet("au","eu","na")]
        [string]$apiRegion,

        [parameter(Mandatory=$false,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$false,ParameterSetName = "generate url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$codebase,

        [parameter(Mandatory=$true,ParameterSetName = "generate url + specified auth")]
        [parameter(Mandatory=$true,ParameterSetName = "specified url + specified auth")]
        [validateNotNullorEmpty()]
        [string]$authString,

        [parameter(Mandatory=$true,ParameterSetName = "generate url + generate auth")]
        [parameter(Mandatory=$true,ParameterSetName = "specified url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$publicKey,

        [parameter(Mandatory=$true,ParameterSetName = "generate url + generate auth")]
        [parameter(Mandatory=$true,ParameterSetName = "specified url + generate auth")]
        [validateNotNullorEmpty()]
        [string]$privateKey
    )

    #generate api url if not specified
    if ( ( $PSBoundParameters.ContainsKey( 'apiUrl')  ) -eq $false ) {
        if ( ( $PSBoundParameters.ContainsKey( 'codebase')  ) -eq $false ) {
            $apiUrl = Get-CwmApiUrl -apiRegion $apiRegion -company $company
        } else {
            $apiUrl = Get-CwmApiUrl -apiRegion $apiRegion -codebase $codebase
        }
    }

    #generate auth string if not specified
    if ( ( $PSBoundParameters.ContainsKey( 'authString')  ) -eq $false ) {
        $authString = New-CwmApiAuthString -company $company - publicKey $publicKey -privateKey $privateKey
    }

    #set the parameters for the request
    $params = @{
        Uri         =	"$apiUrl$endpoint"
        Method      =	$apiMethod
        ContentType	= 	'application/json'
        Headers     =	@{
            'Authorization'	=	$authString
        }
    }

    #if body was defined (patch or put), add to params
    if ( $apiRequestBody ) {
        $params.Add( 'Body' , $apiRequestBody )
    }

    #make api request
    try { $response = ( Invoke-WebRequest @params -UseBasicParsing ) | Select-Object StatusCode,Content }
    catch { 
        Write-Log -message "API Request failed`n$PSItem" -type "Error"
        throw
    }

    return $response.content | ConvertFrom-Json

}