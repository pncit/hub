---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Convert-CwmCompanyNameToId

## SYNOPSIS
Returns the ConnectWise Manage id for a given company

## SYNTAX

```
Convert-CwmCompanyNameToId [-companyName] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid company name, this function will return the corresponding ConnectWise Manage company id.

## EXAMPLES

### EXAMPLE 1
```
$companyId = Convert-CwmCompanyNameToId -name "Test Company"
```

## PARAMETERS

### -companyName
The name of the company as defined in ConnectWise Manage.

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

### [int32] ConnectWise Manage company id
## NOTES

## RELATED LINKS
