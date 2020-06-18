function New-CwmApiRequest {
    <#
    .SYNOPSIS 
    Performs a query against the Connectwise Manage API

    .DESCRIPTION
    This is a very generic function that performs GET, POST, and PATCH requests to the ConnectWise Manage API. If pageSize is not
    specified in the endpoint parameter, this function will automatically pull the maximum page size (1000) and then loop to pull
    any additional pages, returning all responses combined into a single response object.

    .PARAMETER endpoint
    The ConnectWise Manage API endpoint to hit. This can include additional query data. Endpoint should NOT be URL encoded.

    .PARAMETER apiMethod
    API method (get, post, patch)
    
    .PARAMETER apiRequestBody
    API request body
    
    .PARAMETER apiUrl
    The base ConnectWise Manage API URL

    .PARAMETER authString
    Authorization string to access the ConnectWise Manage API

    .PARAMETER apiClientId
    Unique GUID or Globally Unique Identifier assigned to each ConnectWise integration

    .OUTPUTS
    [System.Object] custom object containing API response

    .EXAMPLE
    $tickets = New-CwmApiRequest -endpoint "/service/tickets?conditions=board/id=1 and status/id=505&fields=id,owner/id" -apiMethod "get" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG" 

    .EXAMPLE

    .NOTES
    #>
    [CmdletBinding()]
	param
	(
        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$endpoint=$null,

        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$apiMethod,

        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$apiRequestBody,

        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$apiUrl=$global:cwmApiUrl,

        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$authString=$global:cwmApiAuthString,

        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$apiClientId=$global:cwmApiClientId
    )

    $errorAction = $PSBoundParameters["ErrorAction"]
    if(-not $errorAction){
        $errorAction = $ErrorActionPreference
    }

    #pull maximum records allowable unless endpoint argument already specifies a count
    $escapedEndpoint = [uri]::EscapeUriString( $endpoint )
    #where a client name has & (e.g. RHW - River Health & Wellness) we need need to replace the & with %26 in order to use CW API, 
    #   but cannot replace all & with %26 because & has a function in REST API calls
    $escapedEndpoint = $escapedEndpoint -replace '%20&%20', '%20%26%20'
    $uri = $apiUrl + $escapedEndpoint
    if ( $uri.ToLower().IndexOf( "pagesize" ) -eq -1 ) {
        if ( $uri.IndexOf( "?" ) -eq -1 ) {
            $uri += "?pageSize=1000"
        } else {
            $uri += "&pageSize=1000" 
        }
    }

    #set the parameters for the request
    $params = @{
        Uri         =	$uri
        Method      =	$apiMethod
        ContentType	= 	'application/json'
        Headers     =	@{
            'Authorization'	=	$authString
            'clientId' = $apiClientId
        }
    }

    #if body was defined (patch or put), add to params
    if ( $apiRequestBody ) {
        $params.Add( 'Body' , $apiRequestBody )
    }

    #make api request
    try { $response = ( Invoke-WebRequest @params -UseBasicParsing ) | Select-Object StatusCode,Content,Headers }
    catch {
        if ( $errorAction.ToString().ToLower() -ne "silentlycontinue") {
            Write-Log -message "API Request failed`n$PSItem" -entryType "Error"
        }
        throw
    }

    $content = $response.content | ConvertFrom-Json
    if ( ( $null -eq $response.Headers['Link'] ) -or ( $response.Headers['Link'].IndexOf( 'rel="next"' ) -eq -1 ) ) {
        return $content
    } else {
        #extract 'next' url from a string like
        #<https://api-na.myconnectwise.net/v4_6_release/apis/3.0/service/tickets/?pageSize=1000&page=2>; rel="next", <https://api-na.myconnectwise.net/v4_6_release/apis/3.0/service/tickets/?pageSize=1000&page=230>; rel="last"
        $linkInfo = $response.Headers['Link']
        $linkInfo = $linkInfo.Replace('rel=','').Replace('<','').Replace('>','').Replace('"','').Replace(' ','')
        $linkInfo = $linkInfo.Split(',')
        foreach ( $link in $linkInfo ) {
            $info = $link.split(';')
            if ( $info[1] -eq 'next') {
                $nextUrl = $info[0]
            }
        }
        $params = @{
            "apiUrl" = $nextUrl
            "authString" = $cwmApiAuthString
            "apiMethod" = $apiMethod
        }
        if ( $apiRequestBody ) {
            $params.Add( 'Body' , $apiRequestBody )
        }
        $restOfContent = New-CwmApiRequest @params
        return $content + $restOfContent
    }
}