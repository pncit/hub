---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Test-RegistryKeyValueData

## SYNOPSIS
Tests the value of a registry key

## SYNTAX

```
Test-RegistryKeyValueData [-Key] <String> [-Value] <String> [-TestValueData] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns true if a registry value exists and matches the given value.
Otherwise, returns false.

## EXAMPLES

### EXAMPLE 1
```
Test-registryentry -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging' -key 'EnableModuleLogging' -value '1'
```

## PARAMETERS

### -Key
Registry key to look in

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

### -Value
Value to check (must be a string.
If not, this function will return $false)

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

### -TestValueData
Value data to compare to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [Boolean]
## NOTES

## RELATED LINKS
