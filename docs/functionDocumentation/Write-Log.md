---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Write-Log

## SYNOPSIS
Writes to the event log and the Datto RMM stdout window.

## SYNTAX

```
Write-Log [-message] <String> [-entryType] <String> [[-eventID] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Creates a Weindows event event log source "Datto RMM" and writes log messages to that log.
Simultaneously writes to stdout.

## EXAMPLES

### EXAMPLE 1
```
Write-Log -Message "This is a log message`nThat spans two lines" -EntryType "Information" -EventID 10
```

This example writes an information message to the event log and puts the same text into the stdout so it is viewable from within the Datto RMM interface

## PARAMETERS

### -message
The text to write to the event log and stdout

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entryType
The event log entry type.
Must be "Information", "Warning", or "Error"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -eventID
The event log event id (default = 20).
0 = Adding Windows Eventlog source, 10 = Global Functions, 20 = Script components

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
