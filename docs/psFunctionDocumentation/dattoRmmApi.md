# Get-DeviceData

## SYNOPSIS
Gets device data from the Datto RMM API

## SYNTAX

```
Get-DeviceData [[-apiAccessToken] <String>] [[-apiUrl] <String>] [-deviceId] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters and a valid device uid, this will return the device info available from the Datto RMM API

## EXAMPLES

### EXAMPLE 1
```
$deviceData = Get-DeviceData -deviceId $deviceId
```

## PARAMETERS

### -apiAccessToken
{{ Fill apiAccessToken Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $global:dattoRmmApiAccessToken
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiUrl
{{ Fill apiUrl Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $global:dattoRmmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -deviceId
Datto-defined uid.
From within a machine this can be collected via

$deviceId = Get-DeviceId

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

### [System.Object] custom object containing device data
## NOTES

## RELATED LINKS
# Get-DevicePatchStatus

## SYNOPSIS
Gets device patch status from the Datto RMM API

## SYNTAX

```
Get-DevicePatchStatus [-deviceId] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters and a valid device uid, this will return the patch status from the Datto RMM API

## EXAMPLES

### EXAMPLE 1
```
$devicePatchStatus = Get-DevicePatchStatus -deviceId $deviceId
```

## PARAMETERS

### -deviceId
Datto-defined uid.
From within a machine this can be collected via

$deviceId = Get-DeviceId

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [String] patch status
## NOTES

## RELATED LINKS
# New-DattoRmmApiAccessToken

## SYNOPSIS
Generates a new Datto RMM API Access Token

## SYNTAX

```
New-DattoRmmApiAccessToken [-apiUrl] <String> [-accessKey] <String> [-secretKey] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid API key pair, this function returns an OAuth2 authorization token
See https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm for details on enabling the API and defining key pairs

## EXAMPLES

### EXAMPLE 1
```
$apiAccessToken = New-DattoRmmApiAccessToken -apiUrl = "https://zinfandel-api.centrastage.net" - accessKey = "fjlkdjk" -secretKey = "adlsfaffdk"
```

## PARAMETERS

### -apiUrl
Region-specific API Url.
Allowable values are:

https://pinotage-api.centrastage.net

https://merlot-api.centrastage.net

https://concord-api.centrastage.net

https://zinfandel-api.centrastage.net

https://syrah-api.centrastage.net

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

### -accessKey
API Access Key

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

### -secretKey
API Secret Key

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

### [String] Authorization Token
## NOTES

## RELATED LINKS
# New-DattoRmmApiRequest

## SYNOPSIS
Performs a query against the Datto RMM API

## SYNTAX

```
New-DattoRmmApiRequest [[-apiAccessToken] <String>] [[-apiUrl] <String>] [-apiMethod] <String>
 [-apiRequest] <String> [[-apiRequestBody] <String>] [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid API key pair OR a valid API access token, this will return the result of the specified API request
See https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm for details on enabling the API and defining key pairs

## EXAMPLES

### EXAMPLE 1
```
$response = New-DattoRmmApiRequest -apiUrl "https://zinfandel-api.centrastage.net" -apiAccessToken "fjdfkdfjfeifj" -apiMethod "get" -apiRequest "device/$deviceId"
```

## PARAMETERS

### -apiAccessToken
API Access Token generated by New-DattoRmmApiAccessToken.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $global:dattoRmmApiAccessToken
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiUrl
Region-specific API Url.
Allowable values are:

https://pinotage-api.centrastage.net

https://merlot-api.centrastage.net

https://concord-api.centrastage.net

https://zinfandel-api.centrastage.net

https://syrah-api.centrastage.net

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $global:dattoRmmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiMethod
API SMethod (GET, POST, or PATCH)

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

### -apiRequest
Endpoint for API request.
For endpoint information, see Swagger links at https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm

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

### -apiRequestBody
json-formatted body for POST or PATCH requests

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [System.Object] custom object containing request response data
## NOTES

## RELATED LINKS
# Set-DeviceUdf

## SYNOPSIS
Sets Datto RMM UDF to a specified value for a single device, devices at a site, or devices in an account

## SYNTAX

### Set value for a single device
```
Set-DeviceUdf -deviceId <String> -udf <Int32> -value <String> [<CommonParameters>]
```

### Set value for all devices at a site
```
Set-DeviceUdf -siteId <String> -udf <Int32> -value <String> [<CommonParameters>]
```

### Set value for all devices in account
```
Set-DeviceUdf -udf <Int32> -value <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters this will set UDF values via the API.
This will impact devices whether or not they are online.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -deviceId
Datto-defined uid.
From within a machine this can be collected via
$deviceId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\CentraStage' -Name deviceId).deviceId

```yaml
Type: String
Parameter Sets: Set value for a single device
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteId
Datto-defined uid.

```yaml
Type: String
Parameter Sets: Set value for all devices at a site
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -udf
UDF number (1-30)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
Value for the udf.
User-defined fields have a limit of 255 characters.

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

## NOTES

## RELATED LINKS
