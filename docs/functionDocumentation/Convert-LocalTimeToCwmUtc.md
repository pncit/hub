---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Convert-LocalTimeToCwmUtc

## SYNOPSIS
Generates a CWM formatted UTC string from the DateTime value in local time passed as a parameter

## SYNTAX

```
Convert-LocalTimeToCwmUtc [-localDateTime] <DateTime> [<CommonParameters>]
```

## DESCRIPTION
CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC.
This function converts DateTime ojects where the time zone is the local time zone into those strings

## EXAMPLES

### EXAMPLE 1
```
$localDateTime = Get-Date
```

$cwmDateTime = Convert-LocalTimeToCwmUtc -localDateTime $localDateTime
This would return a dateTime object with value "2019-04-20T10:06:29Z"

## PARAMETERS

### -localDateTime
DateTime in local time zone

```yaml
Type: DateTime
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

### DateTime string in format YYYY-MM-DDTHH:MM:SSZ
## NOTES

## RELATED LINKS
