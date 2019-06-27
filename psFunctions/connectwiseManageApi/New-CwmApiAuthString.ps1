function New-CwmApiAuthString {
    <#
    .SYNOPSIS 
    Generates a new connectwise Manage API Access Token

    .DESCRIPTION
    If provided with a valid combination of company id, public key, and private key, this will return a basic auth string for api requests

    The output can be used in headers as:

    $headers = @{ Authorization = $authString }

    .PARAMETER company
    Your company id as defined in ConnectWise Manage

    .PARAMETER publicKey
    Public key for your ConnectWise Manage API access (https://developer.connectwise.com/Products/Manage/Developer_Guide)

    .PARAMETER privateKey
    Private key for your ConnectWise Manage API access (https://developer.connectwise.com/Products/Manage/Developer_Guide)

    .OUTPUTS
    [String] authorization sring

    .EXAMPLE
    $authString = New-CwmApiAuthString -company "mycompany" - publicKey "fjlkdjk" -privateKey "adlsfaffdk"
    This would return a string "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$company,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$publicKey,

        [parameter(mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$privateKey
	)

    # Convert password to secure string
    $user = "$company+$publicKey"
    $pass = $privateKey
    $pair = "${user}:${pass}"

    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)

    $basicAuthValue = "Basic $base64"

    return $basicAuthValue
}