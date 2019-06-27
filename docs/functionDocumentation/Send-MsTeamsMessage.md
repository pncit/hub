---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Send-MsTeamsMessage

## SYNOPSIS
Posts a message to Microsoft Teams

## SYNTAX

```
Send-MsTeamsMessage [[-webhook] <String>] [-summary] <String> [-title] <String> [-text] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Uses a pre-created webhook to post a message to a Teams channel

## EXAMPLES

### EXAMPLE 1
```
Send-MsTeamsMessage -summary "Critical event" -title "Hard Drive Failure" -text "Hard drive has failed on server at hospital" -webhook "https://outlook.office.com/webhook/00000000-0000-0000-0000-000000000000000000000-0000-0000-0000-000000000000/IncomingWebhook/00000000000000000000000000000000/00000000-0000-0000-0000-000000000000"
```

## PARAMETERS

### -webhook
uri for webhook

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $msTeamsWebhook
Accept pipeline input: False
Accept wildcard characters: False
```

### -summary
Message summary

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

### -title
Message title

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

### -text
Message text

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Summary is what shows up in the teams feed

Title is what is bold/h1 in the message itself

Text is plain text in the message itself

## RELATED LINKS
