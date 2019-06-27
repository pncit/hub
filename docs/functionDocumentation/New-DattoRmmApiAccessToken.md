---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# New-DattoRmmApiAccessToken

## SYNOPSIS
Generates a new Datto RMM API Access Token

## SYNTAX

```
New-DattoRmmApiAccessToken [-apiUrl] <String> [-accessKey] <String> [-secretKey] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid API key pair, this function returns an OAuth2 authorization token
See https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm for details on enabling the API and defining key pairs

## EXAMPLES

### EXAMPLE 1
```
$apiAccessToken = New-DattoRmmApiAccessToken -apiUrl = "https://zinfandel-api.centrastage.net" - accessKey = "fjlkdjk" -secretKey = "adlsfaffdk"
```

## PARAMETERS

### -apiUrl
Region-specific API Url.
Allowable values are:

https://pinotage-api.centrastage.net

https://merlot-api.centrastage.net

https://concord-api.centrastage.net

https://zinfandel-api.centrastage.net

https://syrah-api.centrastage.net

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

### -accessKey
API Access Key

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

### -secretKey
API Secret Key

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

### [String] Authorization Token
## NOTES

## RELATED LINKS
