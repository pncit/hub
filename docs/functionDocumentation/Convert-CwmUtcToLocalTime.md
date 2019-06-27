---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Convert-CwmUtcToLocalTime

## SYNOPSIS
Generates a DateTime value in local time matching the CWM formatted UTC string passed as a parameter

## SYNTAX

```
Convert-CwmUtcToLocalTime [-CwmDateTimeString] <String> [<CommonParameters>]
```

## DESCRIPTION
CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC.
This function converts those strings into DateTime ojects where the time zone is the local time zone

## EXAMPLES

### EXAMPLE 1
```
$cwmDateTime = "2019-04-20T10:06:29Z"
```

$locDateTime = Convert-CwmUtcToLocalTime -CwmDateTimeString $cwmDateTime
This would return a dateTime object with value "Saturday, April 20, 2019 2:06:29 AM" (if you were in Alaska)

## PARAMETERS

### -CwmDateTimeString
DateTime string in format YYYY-MM-DDTHH:MM:SSZ

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### DateTime object in local time
## NOTES

## RELATED LINKS
