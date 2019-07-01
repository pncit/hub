Functions:
##[Get-DeviceId](#Get-DeviceId)
 ##[Set-CustomUdf](#Set-CustomUdf)


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
