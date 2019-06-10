function New-CwmApiRequest {
    <#
    .SYNOPSIS 
    Performs a query against the Connectwise Manage API

    .PARAMETER endpoint

    .PARAMETER apiUrl

    .PARAMETER authString

    .OUTPUTS
    API response

     .EXAMPLE
    $contacts = New-CwmApiRequest -endpoint "company/contacts" -apiMethod "get" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic XXX" 

    .NOTES
    #>
    [CmdletBinding()]
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$endpoint,

        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$apiMethod,

        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$apiRequestBody,

        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$apiUrl,

        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$authString
    )

    $errorAction = $PSBoundParameters["ErrorAction"]
    if(-not $errorAction){
        $errorAction = $ErrorActionPreference
    }

    #set the parameters for the request
    $params = @{
        Uri         =	$apiUrl + [uri]::EscapeUriString($endpoint )
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
        if ( $ErrorAction.ToString().ToLower() -ne "silentycontinue") {
            Write-Log -message "API Request failed`n$PSItem" -entryType "Error"
        }
        throw
    }

    return $response.content | ConvertFrom-Json

}