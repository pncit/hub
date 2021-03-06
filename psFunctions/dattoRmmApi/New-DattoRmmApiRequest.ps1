function New-DattoRmmApiRequest {
    <#
    .SYNOPSIS 
    Performs a query against the Datto RMM API

    .DESCRIPTION
    If provided with a valid API key pair OR a valid API access token, this will return the result of the specified API request
    See https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm for details on enabling the API and defining key pairs

    .PARAMETER apiAccessToken
    API Access Token generated by New-DattoRmmApiAccessToken.

    .PARAMETER apiUrl
    Region-specific API Url. Allowable values are:

    https://pinotage-api.centrastage.net

    https://merlot-api.centrastage.net

    https://concord-api.centrastage.net

    https://zinfandel-api.centrastage.net

    https://syrah-api.centrastage.net

    .PARAMETER apiMethod
    API SMethod (GET, POST, or PATCH)

    .PARAMETER apiRequest
    Endpoint for API request.
    For endpoint information, see Swagger links at https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm

    .PARAMETER apiRequestBody
    json-formatted body for POST or PATCH requests

    .OUTPUTS
    [System.Object] custom object containing request response data

    .EXAMPLE
    $response = New-DattoRmmApiRequest -apiUrl "https://zinfandel-api.centrastage.net" -apiAccessToken "fjdfkdfjfeifj" -apiMethod "get" -apiRequest "device/$deviceId"

    #>
    param 
    (
        [parameter(Mandatory=$false)]
        [validateNotNullorEmpty()]
        [String]$apiAccessToken=$global:dattoRmmApiAccessToken,

        [parameter(Mandatory=$false)]
        [ValidateSet("https://pinotage-api.centrastage.net","https://merlot-api.centrastage.net","https://concord-api.centrastage.net","https://zinfandel-api.centrastage.net","https://syrah-api.centrastage.net")]
        [String]$apiUrl=$global:dattoRmmApiUrl,

        [parameter(Mandatory=$true)]
        [ValidateSet("GET","POST","PATCH")]
        [String]$apiMethod,

        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [String]$apiRequest,

        [parameter(Mandatory=$false)]
        [String]$apiRequestBody
    )

    # some calls will just use the endpoint to add to the base $apiUrl (e.g. 'account/devices'), other calls
    # will include the entire uri (e.g. when using nextPageUrl or prevPageUrl)
    if ( $apiRequest.Substring(0,[math]::min($apiRequest.Length,$apiUrl.Length)) -eq $apiUrl ) {
        $uri = $apiRequest
    } else {
        $uri = "$apiUrl/api/v2/$apiRequest"
    }

    #set the parameters for the request
    $params = @{
        Uri         =	$uri
        Method      =	$apiMethod
        ContentType	= 	'application/json'
        Headers     =	@{
            'Authorization'	=	'Bearer {0}' -f $apiAccessToken
        }
    }

    #if body was defined (patch or put), add to params
    If ( $apiRequestBody ) {
        $params.Add( 'Body' , $apiRequestBody )
    }

    #make api request
    $response = ( Invoke-WebRequest @params -UseBasicParsing ) | Select-Object StatusCode,Content

    #if we got good data, convert it from json before returning it
    if ( $response.statusCode -eq 200 ) {
        $content = $response.content | ConvertFrom-Json
        if ( $null -eq $content.pageDetails ) {
            return $content
        } else {
            $member = $content | Get-Member | Where-Object { $_.MemberType -eq "NoteProperty" -and $_.Name -ne "pageDetails" } | Select-Object -ExpandProperty 'name' 
            if ( $member.GetTypeCode() -ne "String" ) {
                throw "Unable to process API response."
            }
            if ( $null -eq $content.pageDetails.nextPageUrl ) {
                return $content.$member
            } else {
                $paramsRest = @{
                    apiUrl         	=	$apiUrl
                    apiAccessToken  =	$apiAccessToken
                    apiMethod      	=	$apiMethod
                    apiRequest      =   $content.pageDetails.nextPageUrl
                }
                $restOfResponse = New-DattoRmmApiRequest @paramsRest  
                return $content.$member + $restOfResponse
            }
        }
    }
    
    # return reponse as long as status is not 429 or 403 (indicating rate limit issues that neccessitate a cool-down)
    if ( $response.statusCode -ne 429 -and $response.statusCode -ne 403 ) {
        return $response.content
    } else {
        #pause for cool down and try again
        if ( $response.statusCode -eq 429 ) {
            Start-Sleep -s 61
        } elseif ( $response.statusCode -eq 403 ) {
            Start-Sleep -s 601
        } 
        
        #set the params to call this function again with the same settings
        $paramsOrig = @{
            apiUrl         	=	$apiUrl
            apiAccessToken  =	$apiAccessToken
            apiMethod      	=	$apiMethod
            apiRequest      =   $apiRequest
        }
        return New-DattoRmmApiRequest @paramsOrig
    }
}