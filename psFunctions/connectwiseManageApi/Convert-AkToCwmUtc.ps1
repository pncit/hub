function Convert-AkToCwmUtc {
    <#
    .SYNOPSIS 
    Generates a CWM formatted UTC string from the DateTime value in AK time passed as a parameter

    .DESCRIPTION
    CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC. This function converts DateTime ojects where the time zone is AK standard time into those strings

    .PARAMETER akDateTime
    DateTime in AK time zone

    .OUTPUTS
    DateTime string in format YYYY-MM-DDTHH:MM:SSZ

    .EXAMPLE
    $akDateTime = Get-Date 
    $cwmDateTime = Convert-AkToCwmUtc -akDateTime $akDateTime
    This would return a dateTime object with value "2019-04-20T10:06:29Z"

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [datetime]$akDateTime
	)

    #get time zones
    $gmt = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "Greenwich Standard Time" }
    $ak = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "Alaskan Standard Time" }


    #convert time zone
    $GmtDateTime = [System.TimeZoneInfo]::ConvertTime( $akDateTime.ToString('yyyy-MM-ddTHH:mm:ss') , $ak , $gmt )

    #convert to string in CWM format
    return $GmtDateTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
}