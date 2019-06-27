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
# Get-CwmTicket

## SYNOPSIS
Gets data for a ConnectWise Manage Ticket

## SYNTAX

```
Get-CwmTicket [-ticketId] <Int32> [-apiUrl] <String> [-authString] <String> [<CommonParameters>]
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
# Get-DeviceData

## SYNOPSIS
Gets device data from the Datto RMM API

## SYNTAX

```
Get-DeviceData [-dattoRmmApiAccessParams] <Hashtable> [-deviceId] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters and a valid device uid, this will return the device info available from the Datto RMM API

## EXAMPLES

### EXAMPLE 1
```
$deviceData = Get-DeviceData -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId
```

## PARAMETERS

### -dattoRmmApiAccessParams
Hashtable with API url and either API access key and secret key or an API access token.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
Position: 2
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
# Get-DeviceId

## SYNOPSIS
Gets current device's Datto RMM Id

## SYNTAX

```
Get-DeviceId
```

## DESCRIPTION
Datto RMM assigns each device a unique id in the form "53c59385-f94w-43j8-583v-8wec83c93853".
This function returns the id 
of the device on which it is run.

## EXAMPLES

### EXAMPLE 1
```
$deviceId = Get-DeviceId
```

## PARAMETERS

## INPUTS

## OUTPUTS

### [String] device id
## NOTES

## RELATED LINKS
# Get-DevicePatchStatus

## SYNOPSIS
Gets device patch status from the Datto RMM API

## SYNTAX

```
Get-DevicePatchStatus [-dattoRmmApiAccessParams] <Hashtable> [-deviceId] <String> [<CommonParameters>]
```

## DESCRIPTION
If provided with valid access parameters and a valid device uid, this will return the patch status from the Datto RMM API

## EXAMPLES

### EXAMPLE 1
```
$devicePatchStatus = Get-DevicePatchStatus -dattoRmmApiAccessParams $dattoRmmApiAccessParams -deviceId $deviceId
```

## PARAMETERS

### -dattoRmmApiAccessParams
Hashtable with API url and either API access key and secret key or an API access token.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
Position: 2
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
# Get-PendingReboot

## SYNOPSIS
Gets the pending reboot status on a local or remote computer.

## SYNTAX

```
Get-PendingReboot [[-ComputerName] <String[]>] [-ErrorLog <String>] [<CommonParameters>]
```

## DESCRIPTION
This function will query the registry on a local or remote computer and determine if the
system is pending a reboot, from Microsoft updates, Configuration Manager Client SDK, Pending Computer 
Rename, Domain Join or Pending File Rename Operations.
For Windows 2008+ the function will query the 
CBS registry key as another factor in determining pending reboot state. 
"PendingFileRenameOperations" 
and "Auto Update\RebootRequired" are observed as being consistant across Windows Server 2003 & 2008.

CBServicing = Component Based Servicing (Windows 2008+)
WindowsUpdate = Windows Update / Auto Update (Windows 2003+)
CCMClientSDK = SCCM 2012 Clients only (DetermineIfRebootPending method) otherwise $null value
PendComputerRename = Detects either a computer rename or domain join operation (Windows 2003+)
PendFileRename = PendingFileRenameOperations (Windows 2003+)
PendFileRenVal = PendingFilerenameOperations registry value; used to filter if need be, some Anti-
Virus leverage this key for def/dat removal, giving a false positive PendingReboot

## EXAMPLES

### EXAMPLE 1
```
Get-PendingReboot -ComputerName (Get-Content C:\ServerList.txt) | Format-Table -AutoSize
```

Computer CBServicing WindowsUpdate CCMClientSDK PendFileRename PendFileRenVal RebootPending
-------- ----------- ------------- ------------ -------------- -------------- -------------
DC01           False         False                       False                        False
DC02           False         False                       False                        False
FS01           False         False                       False                        False

This example will capture the contents of C:\ServerList.txt and query the pending reboot
information from the systems contained in the file and display the output in a table.
The
null values are by design, since these systems do not have the SCCM 2012 client installed,
nor was the PendingFileRenameOperations value populated.

### EXAMPLE 2
```
Get-PendingReboot
```

Computer           : WKS01
CBServicing        : False
WindowsUpdate      : True
CCMClient          : False
PendComputerRename : False
PendFileRename     : False
PendFileRenVal     : 
RebootPending      : True

This example will query the local machine for pending reboot information.

### EXAMPLE 3
```
$Servers = Get-Content C:\Servers.txt
```

PS C:\\\> Get-PendingReboot -Computer $Servers | Export-Csv C:\PendingRebootReport.csv -NoTypeInformation

This example will create a report that contains pending reboot information.

## PARAMETERS

### -ComputerName
A single Computer or an array of computer names. 
The default is localhost ($env:COMPUTERNAME).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CN, Computer

Required: False
Position: 1
Default value: "$env:COMPUTERNAME"
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ErrorLog
A single path to send error data to a log file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
Author:  Brian Wilhite
Email:   bcwilhite (at) live.com
Date:    29AUG2012
PSVer:   2.0/3.0/4.0/5.0
Updated: 27JUL2015
UpdNote: Added Domain Join detection to PendComputerRename, does not detect Workgroup Join/Change
Fixed Bug where a computer rename was not detected in 2008 R2 and above if a domain join occurred at the same time.
Fixed Bug where the CBServicing wasn't detected on Windows 10 and/or Windows Server Technical Preview (2016)
Added CCMClient property - Used with SCCM 2012 Clients only
Added ValueFromPipelineByPropertyName=$true to the ComputerName Parameter
Removed $Data variable from the PSObject - it is not needed
Bug with the way CCMClientSDK returned null value if it was false
Removed unneeded variables
Added PendFileRenVal - Contents of the PendingFileRenameOperations Reg Entry
Removed .Net Registry connection, replaced with WMI StdRegProv
Added ComputerPendingRename

## RELATED LINKS
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

## RELATED LINKS
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
# New-CwmTimeEntry

## SYNOPSIS
Creates a new ConnectWise Manage time entry

## SYNTAX

```
New-CwmTimeEntry [-ticketId] <Int32> [-timeStart] <DateTime> [-timeEnd] <DateTime> [-notes] <String>
 [-apiUrl] <String> [-authString] <String> [<CommonParameters>]
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

Required: True
Position: 5
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
Position: 6
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

### With Auth Key
```
New-DattoRmmApiRequest -apiAccessToken <String> -apiUrl <String> -apiMethod <String> -apiRequest <String>
 [-apiRequestBody <String>] [-depth <Int32>] [<CommonParameters>]
```

### Without Auth Key
```
New-DattoRmmApiRequest -accessKey <String> -secretKey <String> -apiUrl <String> -apiMethod <String>
 -apiRequest <String> [-apiRequestBody <String>] [-depth <Int32>] [<CommonParameters>]
```

## DESCRIPTION
If provided with a valid API key pair OR a valid API access token, this will return the result of the specified API request
See https://help.aem.autotask.net/en/Content/2SETUP/APIv2.htm for details on enabling the API and defining key pairs

## EXAMPLES

### EXAMPLE 1
```
$response = New-DattoRmmApiRequest -apiUrl "https://zinfandel-api.centrastage.net" -accessKey "fjlkdjk" -secretKey "adlsfaffdk" -apiMethod "get" -apiRequest "device/$deviceId"
```

### EXAMPLE 2
```
$response = New-DattoRmmApiRequest -apiUrl "https://zinfandel-api.centrastage.net" -apiAccessToken "fjdfkdfjfeifj" -apiMethod "get" -apiRequest "device/$deviceId"
```

## PARAMETERS

### -apiAccessToken
API Access Token generated by New-DattoRmmApiAccessToken.

```yaml
Type: String
Parameter Sets: With Auth Key
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accessKey
API Access Key.

```yaml
Type: String
Parameter Sets: Without Auth Key
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -secretKey
API secret key corresponding to the supplied access key.

```yaml
Type: String
Parameter Sets: Without Auth Key
Aliases:

Required: True
Position: Named
Default value: None
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

Required: True
Position: Named
Default value: None
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
Position: Named
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
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -depth
Recursion level.
This is not normally specified, and is used internally when using recursion to handle cool-down periods when rate limits have been exceeded

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
# Protect-ModuleData

## SYNOPSIS
Checks whether module logging is turned on and exits if so

## SYNTAX

```
Protect-ModuleData
```

## DESCRIPTION
If module logging is enabled, private data may be written to the windows event log.
This function checks for whether logging is enabled and exits if it is.

## EXAMPLES

### EXAMPLE 1
```
Protect-ModuleData
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
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
# Set-DeviceUdf

## SYNOPSIS
Sets Datto RMM UDF to a specified value for a single device, devices at a site, or devices in an account

## SYNTAX

### Set value for all devices in account
```
Set-DeviceUdf -dattoRmmApiAccessParams <Hashtable> -udf <Int32> -value <String> [<CommonParameters>]
```

### Set value for all devices at a site
```
Set-DeviceUdf -dattoRmmApiAccessParams <Hashtable> -siteId <String> -udf <Int32> -value <String>
 [<CommonParameters>]
```

### Set value for a single device
```
Set-DeviceUdf -dattoRmmApiAccessParams <Hashtable> -deviceId <String> -udf <Int32> -value <String>
 [<CommonParameters>]
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

### -dattoRmmApiAccessParams
Hashtable with API url and either API access key and secret key or an API access token.
Examples:

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
# Test-RebootRequired

## SYNOPSIS
Detects whether a reboot is required

## SYNTAX

```
Test-RebootRequired
```

## DESCRIPTION
Detects whether a reboot is required

## EXAMPLES

### EXAMPLE 1
```
$rebootRequired = Test-RebootRequired
```

## PARAMETERS

## INPUTS

## OUTPUTS

### [Boolean]
## NOTES

## RELATED LINKS
# Test-RegistryKeyValueData

## SYNOPSIS
Tests the value of a registry key

## SYNTAX

```
Test-RegistryKeyValueData [-Key] <String> [-Value] <String> [-TestValueData] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns true if a registry value exists and matches the given value.
Otherwise, returns false.

## EXAMPLES

### EXAMPLE 1
```
Test-registryentry -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging' -key 'EnableModuleLogging' -value '1'
```

## PARAMETERS

### -Key
Registry key to look in

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

### -Value
Value to check (must be a string.
If not, this function will return $false)

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

### -TestValueData
Value data to compare to

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

### [Boolean]
## NOTES

## RELATED LINKS
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
# Write-CustomUdf

## SYNOPSIS
Writes a value to a Datto RMM Custom UDF

## SYNTAX

```
Write-CustomUdf [-udf] <Int32> [-Value] <String> [<CommonParameters>]
```

## DESCRIPTION
Writes a specified value to a specified Datto RMM Custom UDF via the registry

## EXAMPLES

### EXAMPLE 1
```
Write-CustomUdf -customUdf 22 -value 'Complete'
```

## PARAMETERS

### -udf
UDF to write to (1-30)

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

### -Value
Value to write

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
# Write-Log

## SYNOPSIS
Writes to the event log and the Datto RMM stdout window.

## SYNTAX

```
Write-Log [-message] <String> [-entryType] <String> [[-eventID] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Creates a Weindows event event log source "Datto RMM" and writes log messages to that log.
Simultaneously writes to stdout.

## EXAMPLES

### EXAMPLE 1
```
Write-Log -Message "This is a log message`nThat spans two lines" -EntryType "Information" -EventID 10
```

This example writes an information message to the event log and puts the same text into the stdout so it is viewable from within the Datto RMM interface

## PARAMETERS

### -message
The text to write to the event log and stdout

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

### -entryType
The event log entry type.
Must be "Information", "Warning", or "Error"

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

### -eventID
The event log event id (default = 20).
0 = Adding Windows Eventlog source, 10 = Global Functions, 20 = Script components

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
