---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# New-CryptographyKey

## SYNOPSIS
Generates a random cryptography key.

## SYNTAX

```
New-CryptographyKey [[-Algorithm] <String>] [[-KeySize] <Int32>] [-AsPlainText] [<CommonParameters>]
```

## DESCRIPTION
Generates a random cryptography key based on the desired key size.

## EXAMPLES

### EXAMPLE 1
```
$key = New-CryptographyKey
```

This example generates a random 256-bit AES key and stores it in the variable $key.

## PARAMETERS

### -Algorithm
Algorithm to generate key for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: AES
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeySize
Number of bits the generated key will have.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsPlainText
Returns a String instead of SecureString.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Security.SecureString. New-CryptographyKey return the key as a SecureString by default.
### System.String. New-CryptographyKey will return the key in plain text as a string if the -AsPlainText parameter is specified.
## NOTES
Author: Tyler Siegrist
Date: 9/22/2017
Downloaded from https://gallery.technet.microsoft.com/scriptcenter/EncryptDecrypt-files-use-65e7ae5d on 3/8/2019

## RELATED LINKS
