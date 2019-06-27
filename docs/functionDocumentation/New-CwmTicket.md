---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# New-CwmTicket

## SYNOPSIS
Creates a new ConnectWise Manage ticket

## SYNTAX

### Create a project ticket
```
New-CwmTicket -summary <String> -initialDescription <String> -projectId <Int32> -phaseDescription <String>
 -apiUrl <String> -authString <String> [<CommonParameters>]
```

### Create a service ticket
```
New-CwmTicket -summary <String> -initialDescription <String> [-priority <Int32>] -apiUrl <String>
 -authString <String> [<CommonParameters>]
```

## DESCRIPTION
Creates a new ConnectWise Manage ticket on the default board with the default source for the given comand the supplied

## EXAMPLES

### EXAMPLE 1
```
$ticketId = New-CwmTicket -summary "test ticket" -initialDescription "this is a test" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"
```

### EXAMPLE 2
```
$ticketId = New-CwmTicket -summary "test ticket" -initialDescription "this is a test" -projectId 33 -phaseDescription "Test Phase" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"
```

## PARAMETERS

### -summary
Summary for the new ticket

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialDescription
Text for the initial description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
Ticket priority id (defaults to 8, which is "medium")

```yaml
Type: Int32
Parameter Sets: Create a service ticket
Aliases:

Required: False
Position: Named
Default value: 8
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectId
Project id to which to attach ticket

```yaml
Type: Int32
Parameter Sets: Create a project ticket
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -phaseDescription
Phase to which to attach ticket

```yaml
Type: String
Parameter Sets: Create a project ticket
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiUrl
The base ConnectWise Manage API URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
Authorization string to access the ConnectWise Manage API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [int32] ticket id
## NOTES

## RELATED LINKS
