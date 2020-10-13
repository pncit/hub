function Get-CwmDocument {
    <#
    .SYNOPSIS 
    Downloads a CWM document.

    .DESCRIPTION
    Gets a file with the given ID and saves it to the specified file path.

    .PARAMETER documentId
    The ConnectWise document ID.

    .PARAMETER filePath
    File path to write document to
    
    .PARAMETER apiUrl
    The base ConnectWise Manage API URL

    .PARAMETER authString
    Authorization string to access the ConnectWise Manage API

    .PARAMETER apiClientId
    Unique GUID or Globally Unique Identifier assigned to each ConnectWise integration

    .EXAMPLE
    Get-CwmDocument -filePath '.\temp6.png' -documentid 28074

    .EXAMPLE

    .NOTES
    #>
    [CmdletBinding()]
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$documentId,

        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$filePath,

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

    #set the parameters for the request
    $endpoint = '/system/documents/' + $documentId + '/download'
    $uri = $apiUrl + $endpoint
    $apiMethod = 'get'
    $params = @{
        Uri         =	$uri
        Method      =	$apiMethod
        ContentType	= 	'application/json'
        Headers     =	@{
            'Authorization'	=	$authString
            'clientId' = $apiClientId
        }
    }

    #make api request
    try { $response = Invoke-WebRequest @params -UseBasicParsing }
    catch {
        if ( $errorAction.ToString().ToLower() -ne "silentlycontinue") {
            Write-Log -message "API Request failed`n$PSItem" -entryType "Error"
        }
        throw
    }

    Set-Content -Path $filePath -Encoding Byte -Value $response.content
    $filePath + ' created'
}