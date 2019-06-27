function Write-Log {
    <#
    .SYNOPSIS 
    Writes to the event log and the Datto RMM stdout window.

    .DESCRIPTION
    Creates a Weindows event event log source "Datto RMM" and writes log messages to that log. Simultaneously writes to stdout.

    .PARAMETER message
    The text to write to the event log and stdout 

    .PARAMETER entryType
    The event log entry type. Must be "Information", "Warning", or "Error"

    .PARAMETER eventID
    The event log event id (default = 20). 0 = Adding Windows Eventlog source, 10 = Global Functions, 20 = Script components

    .EXAMPLE
    Write-Log -Message "This is a log message`nThat spans two lines" -EntryType "Information" -EventID 10
    This example writes an information message to the event log and puts the same text into the stdout so it is viewable from within the Datto RMM interface

    .NOTES

    #>
    param(
        [parameter(Mandatory=$true)]
        [validateNotNullorEmpty()]
        [string]$message,

        [parameter(Mandatory=$true)]
        [ValidateSet("Information","Warning","Error")]
        [string]$entryType,
        
        [parameter(Mandatory=$false)]
        [ValidateSet("0","10","20")]
        [int]$eventID=20
    )

    $eventLogSourceName = "Datto RMM";

    #create the event log if neccessary
    if ([System.Diagnostics.EventLog]::SourceExists($eventLogSourceName) -eq $false)
    {
        $newLogMessage = "Started event log for $eventLogSourceName"
        New-EventLog -LogName Application -Source $eventLogSourceName        
        Write-EventLog -LogName Application -Source $eventLogSourceName -EntryType Information -EventId 0 -Message $newLogMessage
        Write-Host $newLogMessage
    }
    Write-EventLog -LogName Application -Source $eventLogSourceName -EntryType $entryType -EventId $eventID -Message $message
    Write-Host $message
}