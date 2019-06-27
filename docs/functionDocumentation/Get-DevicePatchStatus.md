---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Get-DevicePatchStatus

## SYNOPSIS
Gets device patch status from the Datto RMM API

## SYNTAX

```
Get-DevicePatchStatus [-dattoRmmApiAccessParams] <Hashtable> [-deviceId] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters and a valid device uid, this will return the patch status from the Datto RMM API

## EXAMPLES

### EXAMPLE 1
```
$devicePatchStatus = Get-DevicePatchStatus -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId
```

## PARAMETERS

### -dattoRmmApiAccessParams
Hashtable with API url and either API access key and secret key or an API access token.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deviceId
Datto-defined uid.
From within a machine this can be collected via

$deviceId = Get-DeviceId

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [String] patch status
## NOTES

## RELATED LINKS
