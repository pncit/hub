function Convert-CwmUtcToLocalTime {
    <#
    .SYNOPSIS 
    Generates a DateTime value in local time matching the CWM formatted UTC string passed as a parameter

    .DESCRIPTION
    CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC. This function converts those strings into DateTime ojects where the time zone is the local time zone

    .PARAMETER CwmDateTimeString
    DateTime string in format YYYY-MM-DDTHH:MM:SSZ

    .OUTPUTS
    DateTime object in local time

    .EXAMPLE
    $cwmDateTime = "2019-04-20T10:06:29Z"
    $locDateTime = Convert-CwmUtcToLocalTime -CwmDateTimeString $cwmDateTime
    This would return a dateTime object with value "Saturday, April 20, 2019 2:06:29 AM" (if you were in Alaska)
    #>
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$CwmDateTimeString
	)

    #remove Z character and replace T with space
    # "2019-04-20T10:06:29Z" -> "2019-04-20 10:06:29"
    $dateTimeStringReformatted = $CwmDateTimeString.replace('T',' ').replace('Z','')

    #get time zones
    $gmt = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "Greenwich Standard Time" }
    $loc = Get-TimeZone

    #retrun converted time
    return [System.TimeZoneInfo]::ConvertTime( $dateTimeStringReformatted , $gmt , $loc )
}