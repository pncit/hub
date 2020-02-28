function Get-DomainCredential {
    <#
    .SYNOPSIS 
    Gets domain credentials

    .DESCRIPTION
    Gets domain credentials stored in Datto RMM site UDFs

    .EXAMPLE
    Get-DomainCredentials
    #>
    
    $password = $env:domainAdminPw
    $userName = $env:domainAdminUn
    
    if ( $null -eq $password -or $null -eq $userName ) {
        Throw ("Could not find a domain username or password in Datto RMM site variables")
    }
    $passwordSecureString = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ( $userName , $passwordSecureString )
    return $credential
}