---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Protect-File

## SYNOPSIS
Encrypts a file using a symmetrical algorithm.

## SYNTAX

### SecureString (Default)
```
Protect-File [-FileName] <String[]> [[-Algorithm] <String>] [[-Key] <SecureString>]
 [[-CipherMode] <CipherMode>] [[-PaddingMode] <PaddingMode>] [[-Suffix] <String>] [-RemoveSource]
 [<CommonParameters>]
```

### PlainText
```
Protect-File [-FileName] <String[]> [[-Algorithm] <String>] [-KeyAsPlainText] <String>
 [[-CipherMode] <CipherMode>] [[-PaddingMode] <PaddingMode>] [[-Suffix] <String>] [-RemoveSource]
 [<CommonParameters>]
```

## DESCRIPTION
Encrypts a file using a symmetrical algorithm.

## EXAMPLES

### EXAMPLE 1
```
Protect-File 'C:\secrets.txt' $key
```

This example encrypts C:\secrets.txt using the key stored in the variable $key.
The encrypted file would have the default extension of '.AES' and the source (decrypted) file would not be removed.

### EXAMPLE 2
```
Protect-File 'C:\secrets.txt' -Algorithm DES -Suffix '.Encrypted' -RemoveSource
```

This example encrypts C:\secrets.txt with a randomly generated DES key.
The encrypted file would have an extension of '.Encrypted' and the source (decrypted) file would be removed.

### EXAMPLE 3
```
Get-ChildItem 'C:\Files' -Recurse | Protect-File -Algorithm AES -Key $key -RemoveSource
```

This example encrypts all of the files under the C:\Files directory using the key stored in the variable $key.
The encrypted files would have the default extension of '.AES' and the source (decrypted) files would be removed.

## PARAMETERS

### -FileName
File(s) to be encrypted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PSPath, LiteralPath

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Algorithm
{{ Fill Algorithm Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: AES
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
Cryptography key as a SecureString to be used for encryption.

```yaml
Type: SecureString
Parameter Sets: SecureString
Aliases:

Required: False
Position: 4
Default value: (New-CryptographyKey -Algorithm $Algorithm)
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyAsPlainText
Cryptography key as a String to be used for encryption.

```yaml
Type: String
Parameter Sets: PlainText
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CipherMode
Specifies the block cipher mode to use for encryption.

```yaml
Type: CipherMode
Parameter Sets: (All)
Aliases:
Accepted values: CBC, ECB, OFB, CFB, CTS

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PaddingMode
Specifies the type of padding to apply when the message data block is shorter than the full number of bytes needed for a cryptographic operation.

```yaml
Type: PaddingMode
Parameter Sets: (All)
Aliases:
Accepted values: None, PKCS7, Zeros, ANSIX923, ISO10126

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Suffix
Suffix of the encrypted file to be removed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: ".$Algorithm"
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveSource
Removes the source (decrypted) file after encrypting.

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

### System.IO.FileInfo. Protect-File will return FileInfo with the SourceFile, Algorithm, Key, CipherMode, and PaddingMode as added NoteProperties
## NOTES
Author: Tyler Siegrist
Date: 9/22/2017
Downloaded from https://gallery.technet.microsoft.com/scriptcenter/EncryptDecrypt-files-use-65e7ae5d on 3/8/2019

## RELATED LINKS
