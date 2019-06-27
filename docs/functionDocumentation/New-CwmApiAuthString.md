---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# New-CwmApiAuthString

## SYNOPSIS
Generates a new connectwise Manage API Access Token

## SYNTAX

```
New-CwmApiAuthString [-company] <String> [-publicKey] <String> [-privateKey] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid combination of company id, public key, and private key, this will return a basic auth string for api requests

The output can be used in headers as:

$headers = @{ Authorization = $authString }

## EXAMPLES

### EXAMPLE 1
```
$authString = New-CwmApiAuthString -company "mycompany" - publicKey "fjlkdjk" -privateKey "adlsfaffdk"
```

This would return a string "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"

## PARAMETERS

### -company
Your company id as defined in ConnectWise Manage

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

### -publicKey
Public key for your ConnectWise Manage API access (https://developer.connectwise.com/Products/Manage/Developer_Guide)

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

### -privateKey
Private key for your ConnectWise Manage API access (https://developer.connectwise.com/Products/Manage/Developer_Guide)

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

### [String] authorization sring
## NOTES

## RELATED LINKS
