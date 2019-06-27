---
external help file: hubFunctions-help.xml
Module Name: hubFunctions
online version:
schema: 2.0.0
---

# New-CwmApiRequest

## SYNOPSIS
Performs a query against the Connectwise Manage API

## SYNTAX

```
New-CwmApiRequest [[-endpoint] <String>] [-apiMethod] <String> [[-apiRequestBody] <String>] [-apiUrl] <String>
 [-authString] <String> [<CommonParameters>]
```

## DESCRIPTION
This is a very generic function that performs GET, POST, and PATCH requests to the ConnectWise Manage API.
If pageSize is not
specified in the endpoint parameter, this function will automatically pull the maximum page size (1000) and then loop to pull
any additional pages, returning all responses combined into a single response object.

## EXAMPLES

### EXAMPLE 1
```
$tickets = New-CwmApiRequest -endpoint "/service/tickets?conditions=board/id=1 and status/id=505&fields=id,owner/id" -apiMethod "get" -apiUrl "https://api-na.myconnectwise.net/v2019_3/apis/3.0/" -authString "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"
```

### EXAMPLE 2
```

```

## PARAMETERS

### -endpoint
The ConnectWise Manage API endpoint to hit.
This can include additional query data.
Endpoint should NOT be URL encoded.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiMethod
API method (get, post, patch)

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

### -apiRequestBody
API request body

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Position: 4
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [System.Object] custom object containing API response
## NOTES

## RELATED LINKS
