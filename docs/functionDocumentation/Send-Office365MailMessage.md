---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Send-Office365MailMessage

## SYNOPSIS
Posts a message via o365 email

## SYNTAX

```
Send-Office365MailMessage [[-From] <String>] [[-Credential] <PSCredential>] [-To] <String> [-Subject] <String>
 [-BodyAsHtml] <String> [<CommonParameters>]
```

## DESCRIPTION
Sends an email from an Office365 account with HTML-encoded message content.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -From
Email address to send from

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $O365Account
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential object containing credentials for $o365Account

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $o365AccountCredential
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
Email address to send to

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

### -Subject
Email subject

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodyAsHtml
Message (as html)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
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
