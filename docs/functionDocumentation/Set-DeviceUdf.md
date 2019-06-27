---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Set-DeviceUdf

## SYNOPSIS
Sets Datto RMM UDF to a specified value for a single device, devices at a site, or devices in an account

## SYNTAX

### Set value for all devices in account
```
Set-DeviceUdf -dattoRmmApiAccessParams <Hashtable> -udf <Int32> -value <String> [<CommonParameters>]
```

### Set value for all devices at a site
```
Set-DeviceUdf -dattoRmmApiAccessParams <Hashtable> -siteId <String> -udf <Int32> -value <String>
 [<CommonParameters>]
```

### Set value for a single device
```
Set-DeviceUdf -dattoRmmApiAccessParams <Hashtable> -deviceId <String> -udf <Int32> -value <String>
 [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters this will set UDF values via the API.
This will impact devices whether or not they are online.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -dattoRmmApiAccessParams
Hashtable with API url and either API access key and secret key or an API access token.
Examples:

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deviceId
Datto-defined uid.
From within a machine this can be collected via
$deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId

```yaml
Type: String
Parameter Sets: Set value for a single device
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteId
Datto-defined uid.

```yaml
Type: String
Parameter Sets: Set value for all devices at a site
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -udf
UDF number (1-30)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
Value for the udf.
User-defined fields have a limit of 255 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
