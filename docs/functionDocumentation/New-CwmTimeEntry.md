---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# New-CwmTimeEntry

## SYNOPSIS
Creates a new ConnectWise Manage time entry

## SYNTAX

```
New-CwmTimeEntry [-ticketId] <Int32> [-timeStart] <DateTime> [-timeEnd] <DateTime> [-notes] <String>
 [-apiUrl] <String> [-authString] <String> [<CommonParameters>]
```

## DESCRIPTION
Creates a new ConnectWise Manage ticket on the default board with the default source for the given comand the supplied

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ticketId
Id for ticket to which to add time.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeStart
DateTime value indicating when work began.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEnd
DateTime value indicating when work ended.
If $timeEnd -le $timeStart, then $timeEnd will be set to $timeStart + 1 minute.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
Notes to include in time entry.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiUrl
The base ConnectWise Manage API URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
Authorization string to access the ConnectWise Manage API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
