function Convert-CwmUtcToAk {
    <#
    .SYNOPSIS 
    Generates a DateTime value in AK time matching the CWM formatted UTC string passed as a parameter

    .DESCRIPTION
    CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC. This function converts those strings into DateTime ojects where the time zone is AK standard time

    .PARAMETER dateTimeString
    DateTime string in format YYYY-MM-DDTHH:MM:SSZ

    .OUTPUTS
    DateTime object in AK time

    .EXAMPLE
    $cwmDateTime = "2019-04-20T10:06:29Z"
    $akDateTime = Convert-CwmUtcToAk -dateTimeString $cwmDateTime
    This would return a dateTime object with value "Saturday, April 20, 2019 2:06:29 AM"

    .NOTES
    #>
	param
	(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$dateTimeString
	)

    #remove Z character and replace T with space
    # "2019-04-20T10:06:29Z" -> "2019-04-20 10:06:29"
    $dateTimeStringReformatted = $dateTimeString.replace('T',' ').replace('Z','')

    #get time zones
    $gmt = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "Greenwich Standard Time" }
    $ak = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "Alaskan Standard Time" }

    #retrun converted time
    return [System.TimeZoneInfo]::ConvertTime( $dateTimeStringReformatted , $gmt , $ak )
}