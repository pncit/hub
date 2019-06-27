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