function Test-Credentials {
    <#
    .SYNOPSIS 
    Tests a given username and password

    .DESCRIPTION
    Tests a given username and password to see if they are valid on the current machine. Returns a boolean with the result

    .PARAMETER un
    Username to test
    
    .PARAMETER pw
    Password to test

    .EXAMPLE
    Test-Credentials -username 'someuser' -password 'somepassword'
    #>
    param (
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]
        $un,
        
        [parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]
        $pw

    )
    
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    $dirService = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$env:computername)
    $result = $dirService.ValidateCredentials($un, $pw)
    return $result
}