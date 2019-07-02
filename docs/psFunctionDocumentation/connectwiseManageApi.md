# Functions:
- [Close-CwmTicket](#Close-CwmTicket)

 - [Convert-CwmCompanyNameToId](#Convert-CwmCompanyNameToId)

 - [Convert-CwmUtcToLocalTime](#Convert-CwmUtcToLocalTime)

 - [Convert-LocalTimeToCwmUtc](#Convert-LocalTimeToCwmUtc)

 - [Get-CwmApiUrl](#Get-CwmApiUrl)

 - [Get-CwmTicket](#Get-CwmTicket)

 - [New-CwmApiAuthString](#New-CwmApiAuthString)

 - [New-CwmApiRequest](#New-CwmApiRequest)

 - [New-CwmTicket](#New-CwmTicket)

 - [New-CwmTicketNote](#New-CwmTicketNote)

 - [New-CwmTimeEntry](#New-CwmTimeEntry)



&nbsp;
&nbsp;
&nbsp;
# Close-CwmTicket

## SYNOPSIS
Closes a ConnectWise Manage ticket

## SYNTAX

```
Close-CwmTicket [-ticketId] <Int32> [[-apiUrl] <String>] [[-authString] <String>] [<CommonParameters>]
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

Required: False
Position: 2
Default value: $global:cwmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
ConnectWise Manage API authorization string

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $global:cwmApiAuthString
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

&nbsp;
&nbsp;
&nbsp;
# Convert-CwmCompanyNameToId

## SYNOPSIS
Returns the ConnectWise Manage id for a given company

## SYNTAX

```
Convert-CwmCompanyNameToId [-companyName] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid company name, this function will return the corresponding ConnectWise Manage company id.

## EXAMPLES

### EXAMPLE 1
```
$companyId = Convert-CwmCompanyNameToId -name "Test Company"
```

## PARAMETERS

### -companyName
The name of the company as defined in ConnectWise Manage.

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

### [int32] ConnectWise Manage company id
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Convert-CwmUtcToLocalTime

## SYNOPSIS
Generates a DateTime value in local time matching the CWM formatted UTC string passed as a parameter

## SYNTAX

```
Convert-CwmUtcToLocalTime [-CwmDateTimeString] <String> [<CommonParameters>]
```

## DESCRIPTION
CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC.
This function converts those strings into DateTime ojects where the time zone is the local time zone

## EXAMPLES

### EXAMPLE 1
```
$cwmDateTime = "2019-04-20T10:06:29Z"
```

$locDateTime = Convert-CwmUtcToLocalTime -CwmDateTimeString $cwmDateTime
This would return a dateTime object with value "Saturday, April 20, 2019 2:06:29 AM" (if you were in Alaska)

## PARAMETERS

### -CwmDateTimeString
DateTime string in format YYYY-MM-DDTHH:MM:SSZ

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

### DateTime object in local time
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Convert-LocalTimeToCwmUtc

## SYNOPSIS
Generates a CWM formatted UTC string from the DateTime value in local time passed as a parameter

## SYNTAX

```
Convert-LocalTimeToCwmUtc [-localDateTime] <DateTime> [<CommonParameters>]
```

## DESCRIPTION
CWM encodes dates as YYYY-MM-DDTHH:MM:SSZ in UTC.
This function converts DateTime ojects where the time zone is the local time zone into those strings

## EXAMPLES

### EXAMPLE 1
```
$localDateTime = Get-Date
```

$cwmDateTime = Convert-LocalTimeToCwmUtc -localDateTime $localDateTime
This would return a dateTime object with value "2019-04-20T10:06:29Z"

## PARAMETERS

### -localDateTime
DateTime in local time zone

```yaml
Type: DateTime
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

### DateTime string in format YYYY-MM-DDTHH:MM:SSZ
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Get-CwmApiUrl

## SYNOPSIS
Gets the Connectwise Manage API url

## SYNTAX

### Most current code base
```
Get-CwmApiUrl -apiRegion <String> -company <String> [<CommonParameters>]
```

### Specific code base
```
Get-CwmApiUrl -apiRegion <String> -codebase <String> [<CommonParameters>]
```

## DESCRIPTION
Connectwise changes their code bases regularly.
This function generates an API URL either for a specified code base or returns the most updated
code base available to your company.

## EXAMPLES

### EXAMPLE 1
```
$apiUrl = Get-CwmApiUrl -apiRegion "na" -company "mycompany"
```

This will return the url for the most recent code base in the na region (e.g.
"https://api-na.myconnectwise.net/v2019_3/apis/3.0")

### EXAMPLE 2
```
$apiUrl = Get-CwmApiUrl -apiRegion "na" -codebase "v4_6_release"
```

This will return the url for v4_6_release code base in the na region (e.g.
"https://api-na.myconnectwise.net/v4_6_release/apis/3.0")

## PARAMETERS

### -apiRegion
API region.
Allowable values are: 

au

eu

na

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

### -company
In order to get the most current code base available to you, you must specify your company.
This is not needed if specifying codebase.

```yaml
Type: String
Parameter Sets: Most current code base
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -codebase
To avoid breaking changes as the API develops, you can specify a specific code base (e.g.
v4_6_release/).
If this is not specified, the function
will return the URL for the most current code base.
This is not needed if specifying company.

Codebase value must end in a forward slash "/"

```yaml
Type: String
Parameter Sets: Specific code base
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

### [string] API URL
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# Get-CwmTicket

## SYNOPSIS
Gets data for a ConnectWise Manage Ticket

## SYNTAX

```
Get-CwmTicket [-ticketId] <Int32> [[-apiUrl] <String>] [[-authString] <String>] [<CommonParameters>]
```

## DESCRIPTION
Queries the ConnectWise Manage API for a ticket with a specified Id and returns the data for that ticket.

## EXAMPLES

### EXAMPLE 1
```
Get-CwmTicket -ticketId 12345678-apiUrl "https://api-na.myconnectwise.net/v2019_4/apis/3.0/" -authString "Basic ZmRqa2VvaXdmaithZHNmYXNkZmFzZmRkZmZpOmZkaWVqZmlkamZpZGZkZmo="
```

## PARAMETERS

### -ticketId
The id (as defined within ConnectWise Manage) of the ticket to get data for

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

Required: False
Position: 2
Default value: $global:cwmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
ConnectWise Manage API authorization string

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $global:cwmApiAuthString
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

&nbsp;
&nbsp;
&nbsp;
# New-CwmApiAuthString

## SYNOPSIS
Generates a new connectwise Manage API Access Token

## SYNTAX

```
New-CwmApiAuthString [-company] <String> [-publicKey] <String> [-privateKey] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid combination of company id, public key, and private key, this will return a basic auth string for api requests

The output can be used in headers as:

$headers = @{ Authorization = $authString }

## EXAMPLES

### EXAMPLE 1
```
$authString = New-CwmApiAuthString -company "mycompany" - publicKey "fjlkdjk" -privateKey "adlsfaffdk"
```

This would return a string "Basic a2lqbHUrSTEyMzQ1NjdOTTBwaEpDbjozVmFKbzA5OTk5OTk4ODhG"

## PARAMETERS

### -company
Your company id as defined in ConnectWise Manage

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

### -publicKey
Public key for your ConnectWise Manage API access (https://developer.connectwise.com/Products/Manage/Developer_Guide)

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

### -privateKey
Private key for your ConnectWise Manage API access (https://developer.connectwise.com/Products/Manage/Developer_Guide)

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

### [String] authorization sring
## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# New-CwmApiRequest

## SYNOPSIS
Performs a query against the Connectwise Manage API

## SYNTAX

```
New-CwmApiRequest [[-endpoint] <String>] [-apiMethod] <String> [[-apiRequestBody] <String>]
 [[-apiUrl] <String>] [[-authString] <String>] [<CommonParameters>]
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

Required: False
Position: 4
Default value: $global:cwmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
Authorization string to access the ConnectWise Manage API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: $global:cwmApiAuthString
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

&nbsp;
&nbsp;
&nbsp;
# New-CwmTicket

## SYNOPSIS
Creates a new ConnectWise Manage ticket

## SYNTAX

### Create a project ticket
```
New-CwmTicket -summary <String> -initialDescription <String> -projectId <Int32> -phaseDescription <String>
 [-apiUrl <String>] [-authString <String>] [<CommonParameters>]
```

### Create a service ticket
```
New-CwmTicket -summary <String> -initialDescription <String> [-priority <Int32>] [-apiUrl <String>]
 [-authString <String>] [<CommonParameters>]
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

Required: False
Position: Named
Default value: $global:cwmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
Authorization string to access the ConnectWise Manage API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $global:cwmApiAuthString
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

&nbsp;
&nbsp;
&nbsp;
# New-CwmTicketNote

## SYNOPSIS
Creates a new ConnectWise Manage ticket note

## SYNTAX

```
New-CwmTicketNote [-ticketId] <Int32> [-text] <String> [-detailDescription] [-internalAnalysis] [-resolution]
 [[-apiUrl] <String>] [[-authString] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new ConnectWise Manage ticket note for either a project or a service ticket

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ticketId
Id for ticket to which to add a note.

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

### -text
Note text

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

### -detailDescription
Indicates that note should be flagged as "discussion"

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

### -internalAnalysis
Indicates that note should be flagged as "internal"

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

### -resolution
Indicates that note should be flagged as "resolution"

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

### -apiUrl
The base ConnectWise Manage API URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $global:cwmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
Authorization string to access the ConnectWise Manage API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $global:cwmApiAuthString
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

&nbsp;
&nbsp;
&nbsp;
# New-CwmTimeEntry

## SYNOPSIS
Creates a new ConnectWise Manage time entry

## SYNTAX

```
New-CwmTimeEntry [-ticketId] <Int32> [-timeStart] <DateTime> [-timeEnd] <DateTime> [-notes] <String>
 [[-apiUrl] <String>] [[-authString] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new ConnectWise Manage ticket on the default board with the default source for the given comand the supplied

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ticketId
Id for ticket to which to add time.

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

### -timeStart
DateTime value indicating when work began.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeEnd
DateTime value indicating when work ended.
If $timeEnd -le $timeStart, then $timeEnd will be set to $timeStart + 1 minute.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
Notes to include in time entry.

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

### -apiUrl
The base ConnectWise Manage API URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: $global:cwmApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -authString
Authorization string to access the ConnectWise Manage API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: $global:cwmApiAuthString
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
