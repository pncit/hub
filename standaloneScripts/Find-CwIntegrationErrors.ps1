$dattoRmmApiUrl = "https://[region]-api.centrastage.net"
$dattoRmmAccessKey = "00000000000000000000000000000000"
$dattoRmmSecretKey = "00000000000000000000000000000000"

function New-DattoRmmApiAccessToken {
    <#
    .SYNOPSIS 
    Generates a new Datto RMM API Access Token

    .DESCRIPTION
    If provided with a valid API key pair, this function returns an OAuth2 authorization token
    See https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm for details on enabling the API and defining key pairs

    .PARAMETER apiUrl
    Region-specific API Url. Allowable values are:

    https://pinotage-api.centrastage.net

    https://merlot-api.centrastage.net

    https://concord-api.centrastage.net

    https://zinfandel-api.centrastage.net

    https://syrah-api.centrastage.net

    .PARAMETER accessKey
    API Access Key

    .PARAMETER secretKey
    API Secret Key

    .OUTPUTS
    [String] Authorization Token

    .EXAMPLE
    $apiAccessToken = New-DattoRmmApiAccessToken -apiUrl = "https://zinfandel-api.centrastage.net" - accessKey = "fjlkdjk" -secretKey = "adlsfaffdk"

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true)]
        [ValidateSet("https://pinotage-api.centrastage.net","https://merlot-api.centrastage.net","https://concord-api.centrastage.net","https://zinfandel-api.centrastage.net","https://syrah-api.centrastage.net")]
        [string]$apiUrl,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$accessKey,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$secretKey
	)

	# Specify security protocols
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'

	# Convert password to secure string
	$securePassword = ConvertTo-SecureString -String 'public' -AsPlainText -Force

	# Define parameters for Invoke-WebRequest cmdlet
	$params = @{
		Credential	=	New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ('public-client', $securePassword)
		Uri			=	'{0}/auth/oauth/token' -f $apiUrl
		Method      =	'POST'
		ContentType = 	'application/x-www-form-urlencoded'
		Body        = 	'grant_type=password&username={0}&password={1}' -f $accessKey, $secretKey
	}

	# Request access token
	return ( Invoke-WebRequest @params -UseBasicParsing | ConvertFrom-Json ).access_token
}
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

$dattoApiAccessToken = New-DattoRmmApiAccessToken -apiUrl $dattoRmmApiUrl -accessKey $dattoRmmAccessKey -secretKey $dattoRmmSecretKey

$openAlerts = New-DattoRmmApiRequest -apiAccessToken $dattoApiAccessToken -apiUrl $dattoRmmApiUrl -apiMethod "get" -apiRequest "account/alerts/open"

$alertsWithoutTickets = $openAlerts | Where-Object { $_.responseActions.actionType -eq "TICKET_CREATION_ERROR" -and $_.ticketNumber -eq $null }

$timeoutErrors = $alertsWithoutTickets | Where-Object { $_.responseActions.description -like "*Unable to create ticket due to an exception Read timed out*" }
$mappingErrors = $alertsWithoutTickets | Where-Object { $_.responseActions.description -like "*This device is not mapped to a CI in Connectwise, tickets can not be raised for it.*" }

$mappingErrorsDevices = New-Object System.Collections.ArrayList
foreach ( $alert in $mappingErrors ) {
    $device = $alert.alertSourceInfo.siteName + " \ " + $alert.alertSourceInfo.deviceName
    if ( $mappingErrorsDevices -notcontains $device ) {
        $mappingErrorsDevices += $device
    }
}

$mappingErrorsCount = $mappingErrors | Measure-Object
$mappingErrorsDevicesCount = $mappingErrorsDevices | Measure-Object
$timeoutErrorsCount = $timeoutErrors | Measure-Object

write-host "There are" $mappingErrorsDevicesCount.count "devices with mapping issues:"
write-host ( $mappingErrorsDevices -join "`n" )
write-host "`n"
write-host "There are" $mappingErrorsCount.count "instances where a mapping issue resulted in no ticket being created. The alert uids are:"
write-host ( $mappingErrors.alertuid -join "`n" )
write-host "`n"
write-host "There are" $timeoutErrorsCount.count "instances where a timeout issue resulted in no ticket being created. The alert uids are:"
write-host ( $timeoutErrors.alertuid -join "`n" )