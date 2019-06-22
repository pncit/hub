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
        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [string]$endpoint=$null,

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

    #pull maximum records allowable unless endpoint argument already specifies a count
    $uri = $apiUrl + [uri]::EscapeUriString($endpoint )
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
        }
    }

    #if body was defined (patch or put), add to params
    if ( $apiRequestBody ) {
        $params.Add( 'Body' , $apiRequestBody )
    }

    #make api request
    try { $response = ( Invoke-WebRequest @params -UseBasicParsing ) | Select-Object StatusCode,Content,Headers }
    catch {
        if ( $ErrorAction.ToString().ToLower() -ne "silentycontinue") {
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