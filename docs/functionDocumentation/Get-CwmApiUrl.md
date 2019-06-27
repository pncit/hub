---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Get-CwmApiUrl

## SYNOPSIS
Gets the Connectwise Manage API url

## SYNTAX

### Most current code base
```
Get-CwmApiUrl -apiRegion <String> -company <String> [<CommonParameters>]
```

### Specific code base
```
Get-CwmApiUrl -apiRegion <String> -codebase <String> [<CommonParameters>]
```

## DESCRIPTION
Connectwise changes their code bases regularly.
This function generates an API URL either for a specified code base or returns the most updated
code base available to your company.

## EXAMPLES

### EXAMPLE 1
```
$apiUrl = Get-CwmApiUrl -apiRegion "na" -company "mycompany"
```

This will return the url for the most recent code base in the na region (e.g.
"https://api-na.myconnectwise.net/v2019_3/apis/3.0")

### EXAMPLE 2
```
$apiUrl = Get-CwmApiUrl -apiRegion "na" -codebase "v4_6_release"
```

This will return the url for v4_6_release code base in the na region (e.g.
"https://api-na.myconnectwise.net/v4_6_release/apis/3.0")

## PARAMETERS

### -apiRegion
API region.
Allowable values are: 

au

eu

na

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

### -company
In order to get the most current code base available to you, you must specify your company.
This is not needed if specifying codebase.

```yaml
Type: String
Parameter Sets: Most current code base
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -codebase
To avoid breaking changes as the API develops, you can specify a specific code base (e.g.
v4_6_release/).
If this is not specified, the function
will return the URL for the most current code base.
This is not needed if specifying company.

Codebase value must end in a forward slash "/"

```yaml
Type: String
Parameter Sets: Specific code base
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

### [string] API URL
## NOTES

## RELATED LINKS
