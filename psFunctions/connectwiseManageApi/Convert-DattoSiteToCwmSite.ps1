function Convert-DattoSiteToCwmSite {
    <#
    .SYNOPSIS 
    Returns the ConnectWise Manage company and site id for a given Datto RMM site

    .DESCRIPTION
    If provided with a valid Datto RMM site name, this function will return the corresponding ConnectWise Manage company id and site id.

    .PARAMETER siteName
    The name of the company as defined in Datto RMM.

    .OUTPUTS
    [psObject] ConnectWise Manage company id and site id

    .EXAMPLE
    $companyId = Convert-DattoSiteToCwmSite -name "TCX - Test Company"
    $companyId = Convert-DattoSiteToCwmSite -name "TCX - Test Company - Clinic"

    .NOTES
    #>

    Param(
    
        [Parameter(Mandatory=$true)]
        [validateNotNullOrEmpty()]
        [string]$siteName

    )

    $cwmInfo = New-Object -TypeName PSObject 
    $hyphenCount = ( $siteName.ToCharArray() | Where-Object { $_ -eq '-' } | Measure-Object ).Count
    if ( $hyphenCount -eq 1 ) {
        $endpoint = "/company/companies?conditions=name=`"$siteName`"&fields=id,site/id"
        $result = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString
        $cwmInfo | Add-Member -MemberType NoteProperty -Value $result.id -Name "companyId" 
        $cwmInfo | Add-Member -MemberType NoteProperty -Value $result.site.id -Name "siteId"
    } elseif ( $hyphenCount -eq 2 ) {
        $firstHyphen = $siteName.IndexOf( " - " );
        $secondHyphen = $siteName.IndexOf( " - " , $firstHyphen + 1 );
        $cn = $siteName.substring( 0 , $secondHyphen )
        $sn = $siteName.substring( $secondHyphen + 3 )
        $endpoint = "/company/companies?conditions=name=`"$cn`"&fields=id"
        $result = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString
        $cwmInfo | Add-Member -MemberType NoteProperty -Value $result.id -Name "companyId"
        if ( $null -eq $cwmInfo.companyId ) {
            Throw ("Could not find a CWM company id for The Datto RMM site name '$siteName'")
        }
        $endpoint = "/company/companies/" + $result.id + "/sites?conditions=name=`"$sn`"&fields=id"
        $result = New-CwmApiRequest -endpoint $endpoint -apiMethod "get" -apiUrl $cwmApiUrl -authString $cwmApiAuthString
        $cwmInfo | Add-Member -MemberType NoteProperty -Value $result.id -Name "siteId"
    } else {
        Throw ("The Datto RMM site name '$siteName' is invalid because it has $hyphenCount hyphens")
    }

    if ( $null -eq $cwmInfo.companyId ) {
        Throw ("Could not find a CWM company id for The Datto RMM site name '$siteName'")
    }
    if ( $null -eq $cwmInfo.siteId ) {
        Throw ("Could not find a CWM site id for The Datto RMM site name '$siteName'")
    }
    return $cwmInfo

}