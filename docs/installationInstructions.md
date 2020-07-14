# Using the PNC IT Hub System in your Datto RMM Environment
## Requirements
This system assumes you are running **PowerShell 5.0**. We know for sure it will fail on versions prior to 3.0, and *no attempt is made for backward compatibility*.

## Environment Configuration
In order to use these functions, you must define a set of variables in your Datto account. 

1. Navigate to Setup>Account Settings in the Datto RMM dashboard
2. Scroll down to Variables
3. Create and define the configuration variables listed below (mask where you feel it is appropriate). If you do not use ConnectWise Manage or Office 365, or do not want to leverage those integrations, you can not define the variables without negative impact.

### Configuration Variables
#### Hub
* `hubFunctionsSource = "https://github.com/pncit/hub/raw/master/hubFunctions.zip`

#### Datto RMM API
* `dattoRmmApiUrl = "https://myregion-api.centrastage.net"`
* `dattoRmmAccessKey = "00000000000000000000000000000000"`
* `dattoRmmSecretKey = "00000000000000000000000000000000"`

#### ConnectWise Manage API
* `cwmCompany = "mycompany"`
* `cwmApiRegion = "xx"`
* `cwmApiClientId = "00000000-0000-0000-0000-000000000000"`
* `cwmApiPublicKey = "0000000000000000"`
* `cwmApiPrivateKey = "0000000000000000"`
* `cwmServiceBoardId = 0`
* `cwmProjectBoardId = 0`
* `cwmServiceTicketStatusClosed = 0`
* `cwmServiceTicketStatusOpen = 0`
* `cwmServiceTicketTimeAllowedStatus = { 0 , 1 , 2 }`
* `cwmProjectTicketStatusClosed = 0`
* `cwmProjectTicketStatusOpen = 0`
* `cwmProjectTicketTimeAllowedStatus = { 0 , 1 , 2 }`
* `cwmMemberId = 0`
* `cwmWorkRoleId = 0`

#### Office 365
Note that the full msTeams webhook is too long to enter as a single variable in Datto, so we break it into two values. These are automatically combined to generate the full webhook as `https://outlook.office.com/webhook/$msTeamsWebhook1/IncomingWebhook/$msTeamsWebhook2`

* `o365Account = "sender@conosto.com"`
* `o365Password = 'password'`
* `msTeamsWebhook1 = "00000000-0000-0000-0000-000000000000000000000-0000-0000-0000-000000000000`
* `msTeamsWebhook2 = "00000000000000000000000000000000/00000000-0000-0000-0000-000000000000"`

#### Dell Warranty API
* `dellWarrantyApiClientId = "0000000000000000000000000000000000"`
* `dellWarrantyApiClientSecret = "00000000000000000000000000000000"`

## Using the system within a component
Using the system within a component is a two-step process. After this is done, all functions defined in /functions will be available for use, as will all variables defined in your config file:
1. Attach `Get-HubFunctions.ps1` to your PowerShell component
2. Add the following line to the component script, ideally at the beginning
```
. .\Get-HubFunctions.ps1
```