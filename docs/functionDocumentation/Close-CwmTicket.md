---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# Close-CwmTicket

## SYNOPSIS
Closes a ConnectWise Manage ticket

## SYNTAX

```
Close-CwmTicket [-ticketId] <Int32> [-apiUrl] <String> [-authString] <String> [<CommonParameters>]
```

## DESCRIPTION
Sets a ticket to "closed" status.
This status differs for service and project tickets, and the exact values are defined elsewhere as global parameters ($cwmServiceTicketStatusClosed and $cwmProjectTicketStatusClosed).

## EXAMPLES

### EXAMPLE 1
```
Close-CwmTicket -ticketId 12345678 -apiUrl "https://api-na.myconnectwise.net/v2019_4/apis/3.0/" -authString "Basic ZmRqa2VvaXdmaithZHNmYXNkZmFzZmRkZmZpOmZkaWVqZmlkamZpZGZkZmo="
```

## PARAMETERS

### -ticketId
The id (as defined within ConnectWise Manage) of the ticket to close

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiUrl
ConnectWise Manage API URL

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

### -authString
ConnectWise Manage API authorization string

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

### [System.Object] custom object containing ticket data
## NOTES

## RELATED LINKS
