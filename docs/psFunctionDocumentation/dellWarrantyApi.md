# Functions:
- [Get-DellWarrantyApiToken](#Get-DellWarrantyApiToken)

 - [Get-DellWarrantyInfo](#Get-DellWarrantyInfo)



&nbsp;
&nbsp;
&nbsp;
# Get-DellWarrantyApiToken

## SYNOPSIS
Gets Dell Warranty API Token

## SYNTAX

```
Get-DellWarrantyApiToken [[-clientId] <String>] [[-clientSecret] <String>] [<CommonParameters>]
```

## DESCRIPTION
Given a client id and a client secret, this function returns a token for accessing the Dell Warranty API

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -clientId
Dell Warranty API client_id value

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $global:dellWarrantyApiClientId
Accept pipeline input: False
Accept wildcard characters: False
```

### -clientSecret
Dell Warranty API client_secret value

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $global:dellWarrantyApiClientSecret
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
# Get-DellWarrantyInfo

## SYNOPSIS
Gets Dell Warranty Info

## SYNTAX

```
Get-DellWarrantyInfo [[-token] <String>] [-serviceTag] <String> [<CommonParameters>]
```

## DESCRIPTION
Uses the Dell API to get warranty info for a given service tag number

## EXAMPLES

### EXAMPLE 1
```
$warrantyInfo = Get-DellWarrantyInfo -serviceTag 'ABCDEF'
```

## PARAMETERS

### -token
{{ Fill token Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $global:dellWarrantyApiToken
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceTag
Service tag to look up

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
