function Convert-LocalTimeToCwmUtc {
    <#
    .SYNOPSIS 
    Generates a CWM formatted UTC string from the DateTime value in local time passed as a parameter

    .DESCRIPTION
    CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC. This function converts DateTime ojects where the time zone is the local time zone into those strings

    .PARAMETER localDateTime
    DateTime in local time zone

    .OUTPUTS
    DateTime string in format YYYY-MM-DDTHH:MM:SSZ

    .EXAMPLE
    $localDateTime = Get-Date 
    $cwmDateTime = Convert-LocalTimeToCwmUtc -localDateTime $localDateTime
    This would return a dateTime object with value "2019-04-20T10:06:29Z"

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [datetime]$localDateTime
	)

    #get time zones
    $gmt = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "Greenwich Standard Time" }
    $loc = Get-TimeZone


    #convert time zone
    $GmtDateTime = [System.TimeZoneInfo]::ConvertTime( $localDateTime.ToString('yyyy-MM-ddTHH:mm:ss') , $loc , $gmt )

    #convert to string in CWM format
    return $GmtDateTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
}