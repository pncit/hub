# Functions:
- [New-CryptographyKey](#New-CryptographyKey)

 - [Protect-File](#Protect-File)

 - [Unprotect-File](#Unprotect-File)



&nbsp;
&nbsp;
&nbsp;
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

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
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

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
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

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## RELATED LINKS
