# Functions:
- [Confirm-HubConfiguration](#Confirm-HubConfiguration)

 - [Get-CustomUdf](#Get-CustomUdf)

 - [Get-DeviceId](#Get-DeviceId)

 - [Get-DomainCredential](#Get-DomainCredential)

 - [Set-CustomUdf](#Set-CustomUdf)

 - [Set-HubConfiguration](#Set-HubConfiguration)



&nbsp;
&nbsp;
&nbsp;
# Confirm-HubConfiguration

## SYNOPSIS
Checks whether the needed variables have been defined in the Datto settings screen

## SYNTAX

```
Confirm-HubConfiguration
```

## DESCRIPTION
Checks whether the needed variables have been defined in the Datto settings screen

## EXAMPLES

### EXAMPLE 1
```
Confirm-HubConfiguration
```

## PARAMETERS

## INPUTS

## OUTPUTS

### [Boolean]
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Get-CustomUdf

## SYNOPSIS
Gets a custom udf value for the current device

## SYNTAX

```
Get-CustomUdf [-udf] <Int32> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
$value = Get-CustomUdf 26
```

## PARAMETERS

### -udf
Custom udf to get value of (1-30)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [String] udf value
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Get-DeviceId

## SYNOPSIS
Gets current device's Datto RMM Id

## SYNTAX

```
Get-DeviceId
```

## DESCRIPTION
Datto RMM assigns each device a unique id in the form "53c59385-f94w-43j8-583v-8wec83c93853".
This function returns the id 
of the device on which it is run.

## EXAMPLES

### EXAMPLE 1
```
$deviceId = Get-DeviceId
```

## PARAMETERS

## INPUTS

## OUTPUTS

### [String] device id
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Get-DomainCredential

## SYNOPSIS
Gets domain credentials

## SYNTAX

```
Get-DomainCredential
```

## DESCRIPTION
Gets domain credentials stored in Datto RMM site UDFs

## EXAMPLES

### EXAMPLE 1
```
Get-DomainCredentials
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Set-CustomUdf

## SYNOPSIS
Writes a value to a Datto RMM Custom UDF

## SYNTAX

```
Set-CustomUdf [-udf] <Int32> [-Value] <String> [<CommonParameters>]
```

## DESCRIPTION
Writes a specified value to a specified Datto RMM Custom UDF via the registry

## EXAMPLES

### EXAMPLE 1
```
Set-CustomUdf -customUdf 22 -value 'Complete'
```

## PARAMETERS

### -udf
UDF to write to (1-30)

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

### -Value
Value to write

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

## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Set-HubConfiguration

## SYNOPSIS
Creates global variables for use in hub derived from environment variables defined in DattoRMM

## SYNTAX

```
Set-HubConfiguration
```

## DESCRIPTION
Creates global variables for use in hub derived from environment variables defined in DattoRMM

## EXAMPLES

### EXAMPLE 1
```
Set-HubConfiguration
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
