---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Unprotect-File

## SYNOPSIS
Decrypts a file encrypted with Protect-File.

## SYNTAX

### SecureString (Default)
```
Unprotect-File [-FileName] <String[]> [[-Algorithm] <String>] [-Key] <SecureString>
 [[-CipherMode] <CipherMode>] [[-PaddingMode] <PaddingMode>] [[-Suffix] <String>] [-RemoveSource]
 [<CommonParameters>]
```

### PlainText
```
Unprotect-File [-FileName] <String[]> [[-Algorithm] <String>] [-KeyAsPlainText] <String>
 [[-CipherMode] <CipherMode>] [[-PaddingMode] <PaddingMode>] [[-Suffix] <String>] [-RemoveSource]
 [<CommonParameters>]
```

## DESCRIPTION
Decrypts a file using a provided cryptography key.

## EXAMPLES

### EXAMPLE 1
```
Unprotect-File 'C:\secrets.txt.AES' $key
```

This example decrypts C:\secrets.txt.AES using the key stored in the variable $key.
The decrypted file would remove the default extension of '.AES' and the source (encrypted) file would not be removed.

### EXAMPLE 2
```
Unprotect-File 'C:\secrets.txt.Encrypted' -Algorithm DES -Key $key -Suffix '.Encrypted' -RemoveSource
```

This example decrypts C:\secrets.txt.Encrypted using DES and the key stored in the variable $key.
The decrypted file would remove the extension of '.Encrypted' and the source (encrypted) file would be removed.

### EXAMPLE 3
```
Get-ChildItem 'C:\Files' -Recurse | Unprotect-File -Algorithm AES -Key $key -RemoveSource
```

This example decrypts all of the files under the C:\Files directory using the key stored in the variable $key.
The decrypted files would remove the default extension of '.AES' and the source (encrypted) files would be removed.

## PARAMETERS

### -FileName
File(s) to be decrypted.

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Key
Cryptography key as a SecureString be used for decryption.

```yaml
Type: SecureString
Parameter Sets: SecureString
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -KeyAsPlainText
Cryptography key as a String to be used for decryption.

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
Specifies the block cipher mode that was used for encryption.

```yaml
Type: CipherMode
Parameter Sets: (All)
Aliases:
Accepted values: CBC, ECB, OFB, CFB, CTS

Required: False
Position: 5
Default value: CBC
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PaddingMode
Specifies the type of padding that was applied when the message data block was shorter than the full number of bytes needed for a cryptographic operation.

```yaml
Type: PaddingMode
Parameter Sets: (All)
Aliases:
Accepted values: None, PKCS7, Zeros, ANSIX923, ISO10126

Required: False
Position: 6
Default value: PKCS7
Accept pipeline input: True (ByPropertyName)
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveSource
Removes the source (encrypted) file after decrypting.

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

### System.IO.FileInfo. Unprotect-File will return FileInfo with the SourceFile as an added NoteProperty
## NOTES
Author: Tyler Siegrist
Date: 9/22/2017
Downloaded from https://gallery.technet.microsoft.com/scriptcenter/EncryptDecrypt-files-use-65e7ae5d on 3/8/2019

## RELATED LINKS
